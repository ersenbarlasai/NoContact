# Edge Function Contract: `analyze-message`

This document outlines the expected request and response structure for the future `analyze-message` Supabase Edge Function.

## Overview
The function will analyze a message from an ex-partner to help the user maintain "No Contact" by identifying manipulation, emotional triggers, and recommending the best course of action.

## Endpoint
- **URL**: `https://<project-id>.supabase.co/functions/v1/analyze-message`
- **Method**: `POST`
- **Auth**: Required (Bearer Token)

## Request Shape
```json
{
  "messageText": "string (the pasted message content)",
  "context": {
    "noContactDays": "number (optional)",
    "dominantEmotion": "string (optional, e.g., 'sad', 'angry')",
    "triggers": ["string"]
  },
  "privacyConsent": "boolean (must be true)"
}
```

## Response Shape
```json
{
  "toneLabel": "string (e.g., 'Manipulation', 'Logistical', 'Breadcrumbing')",
  "riskLevel": "low | medium | high",
  "manipulationSignals": ["string"],
  "recommendedAction": "doNotReply | wait24Hours | replyWithBoundary",
  "summary": "string (brief explanation of the niyet)",
  "suggestedReply": "string (optional, only for logistical boundary)",
  "groundingReminder": "string (empowering quote/affirmation)",
  "createdAt": "ISO8601 string"
}
```

## Privacy & Security Policies
1. **No Persistence**: The raw `messageText` is processed in memory and **must not** be saved to any database by the Edge Function.
2. **AI Processing**: Message content is sent to the LLM (e.g., GPT-4o) with strict "Zero Data Retention" settings if possible.
3. **Logging**: Do not log the actual message content in Supabase function logs.
4. **Crisis Handling**: If the message contains self-harm or violence threats, the response should include standard help resources.

## Implementation Notes
- Use OpenAI or Anthropic via Edge Function.
- System prompt should be grounded in "No Contact" recovery principles.
- Avoid encouraging reconciliation or manipulation.
- Focus on "Gray Rock" communication style for logistical replies.
