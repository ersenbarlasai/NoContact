import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"

const OPENAI_API_KEY = Deno.env.get('OPENAI_API_KEY')
const SUPABASE_URL = Deno.env.get('SUPABASE_URL')
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // 1. Authenticate User
    const supabase = createClient(SUPABASE_URL!, SUPABASE_SERVICE_ROLE_KEY!)
    const authHeader = req.headers.get('Authorization')!
    const { data: { user }, error: authError } = await supabase.auth.getUser(authHeader.replace('Bearer ', ''))

    if (authError || !user) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), {
        status: 401,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    // 2. Validate Input
    const { message } = await req.json()
    if (!message || message.trim().length < 5) {
      return new Response(JSON.stringify({ error: 'Mesaj çok kısa veya boş.' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    if (message.length > 2000) {
      return new Response(JSON.stringify({ error: 'Mesaj çok uzun (max 2000 karakter).' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    // 3. Check Usage Limits
    // Fetch user entitlement/tier if possible, or use default
    // For now, default to 3/day for free users
    const { data: usage } = await supabase
      .from('ai_usage')
      .select('count')
      .eq('user_id', user.id)
      .eq('feature_name', 'message_analysis')
      .eq('usage_date', new Date().toISOString().split('T')[0])
      .single()

    const dailyLimit = 3 // Hardcoded MVP limit
    if (usage && usage.count >= dailyLimit) {
      return new Response(JSON.stringify({ error: 'Günlük limitine ulaştın. Yarın tekrar deneyebilirsin.' }), {
        status: 429,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    // 4. Call AI Provider (OpenAI)
    const systemPrompt = `Sen "Still" adlı bir iyileşme uygulamasının uzman analiz motorusun. 
Görevin, kullanıcının eski partnerinden gelen bir mesajı analiz ederek risk seviyesini ve psikolojik paternleri belirlemektir.

TEMEL KURALLAR:
- ASLA manipülasyon tavsiyesi verme.
- ASLA karşı tarafın ne hissettiğinden %100 eminmiş gibi konuşma ("olabilir", "ihtimali var" gibi ifadeler kullan).
- ASLA terapi veya tıbbi tavsiye verme.
- Eğer mesaj taciz veya yüksek baskı içeriyorsa mutlaka SOS modunu öner.
- İletişimsiz kalmayı (No Contact) destekle.
- Sadece Türkçe cevap ver.
- ÇIKTI SADECE JSON FORMATINDA OLMALIDIR.

JSON ŞEMASI:
{
  "risk_level": "low" | "medium" | "high",
  "detected_patterns": ["string"],
  "emotional_tone": "string",
  "manipulation_or_pressure_signals": ["string"],
  "boundary_recommendation": "string",
  "suggested_next_step": "wait" | "do_not_reply" | "reply_with_boundary" | "use_sos" | "write_unsent_letter",
  "short_summary": "string",
  "user_facing_explanation": "string",
  "safe_reply_example": "string" | null,
  "confidence": "low" | "medium" | "high",
  "disclaimer": "Bu bir yapay zeka analizidir, profesyonel destek yerine geçmez."
}`

    const response = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${OPENAI_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini',
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: `Aşağıdaki mesajı analiz et:\n\n"${message}"` }
        ],
        temperature: 0.3,
        response_format: { type: "json_object" }
      }),
    })

    const aiData = await response.json()
    const analysis = JSON.parse(aiData.choices[0].message.content)

    // 5. Increment Usage
    await supabase.rpc('increment_ai_usage', { 
      target_user_id: user.id, 
      target_feature: 'message_analysis' 
    })

    // 6. Return Result
    return new Response(JSON.stringify(analysis), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })

  } catch (err) {
    return new Response(JSON.stringify({ error: err.message }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })
  }
})
