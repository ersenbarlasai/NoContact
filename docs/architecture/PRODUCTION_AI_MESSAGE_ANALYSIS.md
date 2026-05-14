# Production AI Message Analysis

> [!IMPORTANT]
> **Status: Deferred / Not Primary Release Path**
> Current release focus has shifted to the **Trustworthy Support System (Bugünün Desteği)**. Production AI integration remains part of the long-term vision but requires separate readiness gates for cost, consent, and quality control.

## Overview

This document outlines the architecture and privacy safeguards for the production-ready Message Analysis feature in the Still (NoContact) app.

## 1. Architecture Overview

1.  **Flutter Client**: The user pastes a message and requests analysis.
2.  **Consent Layer**: Before the first request, the user must explicitly consent to sending text to a secure server.
3.  **Supabase Edge Function (`analyze-message`)**:
    *   Authenticates the user.
    *   Enforces server-side daily usage limits (e.g., 3/day for free users).
    *   Validates message length and content.
    *   Calls the AI Provider (OpenAI/Google Vertex) with a structured prompt.
    *   **Privacy Constraint**: Raw message text is NEVER logged or stored in the database.
4.  **AI Provider**: Processes the message and returns structured JSON.
5.  **Response Handling**: The Edge Function returns the structured JSON to the client.

## 2. Privacy & Safety Boundaries

### Zero-Persistence Policy
- **Messages**: The raw message text provided by the user is processed in memory by the Edge Function and the AI provider. It is never persisted to disk or database.
- **Analysis Results**: Results are returned to the client and not stored on the server. Users can see their analysis in the current session.

### AI Constraints (The "Still" Philosophy)
- **No Manipulation**: The AI will never suggest "how to get them back" or how to manipulate the other person.
- **No Certainty**: The AI uses probabilistic language ("Bu bir suçluluk hissettirme çabası olabilir" vs "O suçlu hissediyor").
- **No Therapy**: Every analysis includes a mandatory disclaimer that this is not professional psychological support.
- **SOS Integration**: If the message is detected as high-risk or crisis-inducing, the primary recommendation is to use the SOS tool.

## 3. Server-Side Usage Limits

To control costs and prevent abuse, limits are enforced at the Edge Function level:
- **Free Tier**: 3 requests per 24 hours.
- **Premium Tier**: 50 requests per 24 hours (placeholder).
- **Implementation**: Usage is tracked in a secure `ai_usage` table linked to the `auth.uid()`.

## 4. Prompt Strategy

The system prompt enforces:
- **Tone**: Calm, objective, and supportive of the "No Contact" healing process.
- **Language**: Turkish only.
- **Output**: Strict JSON format for reliable parsing.
- **Categories**: Breadcrumbing, Guilt-tripping, Pressure, Emotional Pull, Logistics, etc.

## 5. Release Readiness Checklist

- [ ] Supabase migration for `ai_usage` table applied.
- [ ] Edge Function `analyze-message` deployed with AI secret keys.
- [ ] Evaluation cases (30 samples) verified against the prompt.
- [ ] Consent dialog implemented in Flutter.
- [ ] Error handling for "Limit Reached" and "Network Error" tested.
- [ ] Privacy disclosure updated in-app.
