# Subscriptions and Entitlements Planning

This document outlines the future backend architecture for managing user subscriptions, entitlements, and AI usage limits.

## 1. Database Schema

### `subscriptions` table
Stores the source of truth for active subscriptions (synced from RevenueCat or StoreKit).
- `id`: UUID (Primary Key)
- `user_id`: UUID (References auth.users)
- `tier`: subscription_tier (Enum: 'free', 'premium')
- `status`: subscription_status (Enum: 'active', 'canceled', 'expired', 'trialing')
- `provider`: string ('apple', 'google', 'revenue_cat')
- `expires_at`: timestamp
- `created_at`: timestamp

### `ai_usage` table
Tracks AI processing events for rate limiting and cost control.
- `id`: UUID (Primary Key)
- `user_id`: UUID (References auth.users)
- `feature_name`: string ('message_analysis', 'ai_coach')
- `processed_at`: timestamp (default: now())
- `metadata`: jsonb (e.g., token count, response time)

## 2. Entitlement Enforcement

### Client-Side (Riverpod)
- The `EntitlementController` will fetch the current tier from the `subscriptions` table.
- Usage counts will be derived from the `ai_usage` table using a summary RPC or View.

### Server-Side (Edge Functions)
- **Mandatory Enforcement**: Before processing an AI request (e.g., `analyze-message`), the Edge Function MUST:
  1. Verify the user's active tier in the `subscriptions` table.
  2. Count records in `ai_usage` for the current calendar day (UTC).
  3. Reject the request with `429 Too Many Requests` if the limit is exceeded.
  4. Log the usage record *after* successful AI processing.

## 3. Usage Limits (Proposed)

| Feature | Free Tier | Premium Tier |
| :--- | :--- | :--- |
| **Message Analysis** | 3 / day | 50+ / day |
| **AI Recovery Coach** | Unavailable | Unlimited (Soft Cap) |
| **Recovery Insights** | Basic | Advanced / AI-Driven |
| **SOS Urge Support** | Unlimited | Unlimited |

## 4. Integration Roadmap

1. **Phase 1 (Current)**: Local mock persistence for MVP.
2. **Phase 2**: Supabase schema implementation and usage logging in Edge Functions.
3. **Phase 3**: RevenueCat integration for cross-platform subscription management.
4. **Phase 4**: Real-time sync of entitlements to client via Supabase Realtime.

## 5. Privacy Requirements
- AI usage records MUST NOT store the content of the analyzed messages.
- Metadata should only include technical metrics (tokens, latency, model ID).
