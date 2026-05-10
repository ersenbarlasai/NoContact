# Competitor Screenshot Analysis

# Source
Screenshots shared on 2026-05-10 from an existing no-contact/breakup recovery app.

# What Works

## 1. Long Personalization Onboarding
The competitor asks many questions before showing the app:
- preferred name
- reason for joining
- relationship duration
- time since breakup
- who ended it
- whether this is the first breakup
- social media checking behavior
- no-contact start date
- dominant emotion
- current grief phase
- age and gender
- main goal
- contact-trigger situations

This creates a strong sense that the app understands the user. The emotional result is more important than the raw data: the user feels seen before the first dashboard.

## 2. Clear Question UI Pattern
The screens use a consistent pattern:
- back button
- progress bar
- large question
- short explanatory line
- large selectable options
- fixed bottom CTA

This reduces cognitive load and makes a long flow feel manageable.

## 3. Commitment Contract
The "establish a contract" screen is strong:
- do not message
- do not stalk social media
- choose myself
- understand no-contact as reflection, not manipulation

This is aligned with our ethics and should be adapted. The hold-to-commit gesture is emotionally meaningful because it turns an intention into a deliberate act.

## 4. Education Before Paywall
The app shows:
- healing journey visualization
- before/after comparison
- science-style graph
- feature explanation carousel
- personalized analysis teaser

This increases perceived value before asking for payment.

## 5. SOS Flow Preview
The crisis plan is framed as 4 steps:
1. breathe
2. remember/ground
3. write here
4. choose not to send

The "write here instead" pattern is especially useful. It redirects the user's impulse into a safe container.

# Risks / Weak Spots

## 1. Too Much Purple And Blue
The competitor uses a strong purple/blue identity. We should avoid looking like a clone. Our design system should lean into warm calm, mint, ivory, deep ink, and controlled coral for SOS.

## 2. Question Flow May Be Too Long
The onboarding is emotionally persuasive but could fatigue users. Our MVP should use a shorter core flow and make deeper personalization optional.

## 3. Questionable Claims
Screens show broad claims like "90%" and science-like charts. We should not use unsourced clinical-looking claims. If we use metrics, they must be product-owned or clearly framed.

## 4. Dark Paywall Interstitials
Dark motivational screens before paywall feel intense. We can use emotional gravity, but avoid pressure tactics.

## 5. "Try To Get My Ex Back"
The competitor includes this as an answer. We can collect this intent if needed, but the app must reframe it safely: no-contact is for self-regulation and clarity, not manipulation.

# What We Should Adapt

## MVP Onboarding
Use a concise 8-step onboarding:
1. What should we call you?
2. What brought you here?
3. How long were you together?
4. How long since the breakup?
5. Who ended it?
6. When did no-contact start?
7. What emotion is strongest today?
8. When do you most want to contact them?

Optional later questions:
- age
- gender
- first breakup or repeated cycle
- social media checking
- grief phase
- main goal

## Our Better First Promise
After onboarding, show a personalized plan without forcing immediate payment:
- "Bugun en zor anlarin yalnizlik ve gece saatleri olabilir."
- "Ilk hedef: 24 saat temas etmeden kalmak."
- "SOS planin hazir."
- "AI mesaj analizi premium/limited can be introduced transparently."

## Our Differentiation
- Turkish-first emotional copy.
- Stronger privacy explanation.
- Less manipulative paywall.
- Better SOS tracking after each crisis.
- AI cost control through limited, intentional AI calls.
- Design not dominated by purple.

# Recommended Next Product Task
Implement onboarding as the next feature, but keep it data-driven:
- define question models
- store answers locally first
- later sync to Supabase `recovery_profiles`
- create a generated-but-local initial plan without AI
- reserve AI-generated analysis for a later edge function

