# Recovery Path (İyileşme Yolu)

The Recovery Path is a structured, calm healing roadmap designed to give users a sense of direction and progress without the pressure of aggressive gamification.

## Philosophy
- **Gentle Direction**: "Bu bir yarış değil. Sadece sıradaki nazik adım." (This is not a race. Just the next gentle step.)
- **Non-Prescriptive**: The path suggests actions based on current healing state rather than forcing a strict schedule.
- **Privacy First**: All logic is calculated locally. No AI or external tracking is used to determine the path.

## Phases & Steps
The path is divided into 5 phases, each with a specific emotional goal:

### 1. Stabilize (Dengelen) - Days 1-7
Focus on immediate relief and maintaining no-contact.
- **Step 1**: İlk 24 Saati Koru (SOS Tool)
- **Step 2**: Bugünkü Duygunu Adlandır (Mood Journal)
- **Step 3**: Yaz Ama Gönderme (Letters Vault)

### 2. Understand (Anla) - Days 8-14
Focus on pattern recognition and emotional education.
- **Step 4**: Tetikleyicini Tanı (Data Insights)
- **Step 5**: Duygusal Dalgalanma (Reflective Content)

### 3. Resist (Diren) - Days 15-21
Focus on building long-term willpower.
- **Step 6**: İrade Kasını Güçlendir

### 4. Rebuild (Kendine Dönüş) - Days 22-27
Focus on identity outside the breakup.
- **Step 7**: Kendine Dönüş Planı

### 5. Move Forward (İlerle) - Days 28-30
Focus on closure and new beginnings.
- **Step 8**: Yeni Bir Sayfa

## Technical Implementation
- **Model**: `RecoveryPathStep` (Freezed)
- **Service**: `RecoveryPathBuilder` (Deterministic local logic)
- **State Management**: `RecoveryPathController` (Riverpod)
- **UI**: `RecoveryPathScreen` (Vertical path visualization)

## Local Determination Rules
Statuses are calculated based on:
- `noContactStartDate`
- `moodEntryCount`
- `hasMoodEntryToday`
- `letterCount`
- `managedUrgeCount` (from SOS)

## Future Roadmap (Post-MVP)
- Custom steps based on onboarding answers.
- Achievement badges (Still style, muted/elegant).
- Shared path challenges (Privacy-preserving).
