# Quiet Growth Insights (Sessiz Gelişim)

Quiet Growth Insights is a reflective space where users can see a summary of their progress without the pressure of gamification, scores, or competition. It prioritizes grounding and self-awareness.

## Philosophy
- **Anti-Gamification**: No badges, medals, or rankings. Progress is shown as gentle summaries.
- **Visual Silence**: High use of white space, soft colors (Sage, Cream, Terracotta), and Literata typography.
- **Privacy-First**: Summaries are derived only from local data. Sensitive journal notes and letter contents are never shown or synced.
- **Reflective Language**: Uses supportive Turkish copy that validates the user's journey.

## Key Features
- **Progress Summary**: NC days, mood streaks, managed urges, and milestone counts.
- **Mood Distribution**: A 14-day overview of emotional patterns using soft horizontal bars.
- **Milestone History**: A quiet timeline of achieved milestones.
- **SOS Reassurance**: A dedicated section acknowledging the strength it takes to manage urges.

## Data & Privacy Boundaries
- **Local Only**: All data is aggregated in-memory via `InsightsController` from existing local providers.
- **No Sync**: Insight summaries are not sent to Supabase.
- **No Content Exposure**: The screen never displays the `note` field from mood entries or the `body` of unsent letters.

## Technical Details
- **Feature Location**: `lib/features/insights/`
- **Controller**: `InsightsController` composes state from `RecoveryPath`, `MoodJournal`, and `Milestone` controllers.
- **UI**: `InsightsScreen` uses a `CustomScrollView` for a premium, spacious feel.
