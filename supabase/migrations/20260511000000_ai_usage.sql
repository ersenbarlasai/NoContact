-- Migration: AI Usage Tracking
-- Description: Tracks daily AI analysis usage per user to enforce limits server-side.

CREATE TABLE IF NOT EXISTS public.ai_usage (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    feature_name TEXT NOT NULL, -- e.g., 'message_analysis'
    usage_date DATE NOT NULL DEFAULT CURRENT_DATE,
    count INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    UNIQUE(user_id, feature_name, usage_date)
);

-- Enable RLS
ALTER TABLE public.ai_usage ENABLE ROW LEVEL SECURITY;

-- Policies: Users can only read their own usage (Edge function will handle writes)
CREATE POLICY "Users can view own usage" 
ON public.ai_usage FOR SELECT 
TO authenticated 
USING (auth.uid() = user_id);

-- Helper function to increment usage (called via RPC or DB trigger, though Edge function can do it directly)
CREATE OR REPLACE FUNCTION public.increment_ai_usage(target_user_id UUID, target_feature TEXT)
RETURNS VOID AS $$
BEGIN
    INSERT INTO public.ai_usage (user_id, feature_name, usage_date, count)
    VALUES (target_user_id, target_feature, CURRENT_DATE, 1)
    ON CONFLICT (user_id, feature_name, usage_date)
    DO UPDATE SET 
        count = ai_usage.count + 1,
        updated_at = now();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
