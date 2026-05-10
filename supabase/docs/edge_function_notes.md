# Edge Function Notes

## analyze-message
- Purpose: Analyze incoming messages from ex-partners.
- Input: `raw_text`
- AI Model: GPT-4o-mini or similar.
- Output:
  - Tone detection (manipulative, angry, breadcrumbing, etc.)
  - Recommended action (no reply, grey rock, etc.)
  - Safety classification.
- Disclaimer: Always include a safety disclaimer in the response.

## sos-safety-routing
- Purpose: Logic to determine if a user needs more than just an SOS timer.
- Triggered by: SOS session start or certain mood entries.
- Actions:
  - Return local crisis resource numbers based on user region.
  - Suggest grounding exercises.

## weekly-insight-generator
- Purpose: Generate recovery insights based on mood trends and NC streaks.
- Schedule: Weekly cron or on-demand.
