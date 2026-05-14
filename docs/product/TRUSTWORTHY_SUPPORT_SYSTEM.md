# Trustworthy Support System (Bugünün Desteği)

This document outlines the philosophy and implementation of the Trustworthy Support System in Still (NoContact), which replaces unreliable AI-based analysis with evidence-based self-regulation and commitment tools.

## Phase 1: Today’s Support (Implemented & Verified)

### 1. Purpose
Instead of asking an AI "what they meant", which can be speculative and triggering, we guide the user to look inward and maintain their own boundaries.

### 2. Core Features
- **Neden Başlamıştım? (Why I Started)**: Quick access to the user's primary motivation entered during onboarding.
- **Tek Cümle Not (One Sentence Note)**: A rapid self-reflection tool to capture a grounding thought for the moment.
- **24 Saat Bekle (24-Hour Pause)**: A formal commitment to delay contact for 24 hours, giving the prefrontal cortex time to regulate emotions.
    - **Active State**: Home dashboard displays a calm timer and supportive copy ("Kararını şu an koruyorsun").
    - **Expired State**: Once the 24 hours pass, the app gently acknowledges the completion and guides the user toward calm next steps (e.g., "Göndermeden yaz").
    - **Persistence**: Status is preserved across app restarts using local timestamps.

### 3. Privacy Boundaries
- **Crisis Cards & Notes**: All personal reflections are stored locally on the device using encrypted storage (`EncryptedStorageService`).
- **No Cloud Sync**: In Phase 1, these deeply personal items are NEVER synced to Supabase or any cloud provider.
- **Local Persistence**: Data remains available even without an internet connection.

### 4. SOS Integration
The SOS "Remember" step now prioritizes pinned Crisis Cards (e.g., the user's reason for starting), making the grounding phase more personal and effective.

### 5. Dürtü Yönetimi (Managed Urge) Metriği
- **Bütünleşik Metrik (Unified Metric):** Dürtü Yönetildi metriği; SOS tamamlama, Sessiz Cevap güvenli çıkışı (Kasaya bırakma) ve 24 saat bekleme başlatma gibi tüm güvenli davranışlardan beslenir.
- **Gizlilik:** Hassas metin veya kullanıcı girdisi saklamaz, sadece metadata (id, source, createdAt) tutar.
- **Kriz Deduplication (Ürün Kararı):** 2 dakika içinde yapılan birden fazla güvenli çıkış işlemi, tek ve yoğun bir kriz anının yönetimi kabul edilir ve sayaca yalnızca +1 olarak yansır.
- **Geriye Dönük Uyumluluk:** Legacy SOS count (eski kullanıcı verisi) sadece okunarak yeni sisteme fallback (taban puan) olarak eklenir, yeni sistemde hiçbir zaman artırılmaz.

---

## Future Phases

### Phase 2: Sessiz Kütüphane + 30 Günlük Yol
- **Sessiz Kütüphane**: A curated collection of short, calm audio/text resources on attachment, healing, and boundaries.
- **30 Günlük Yol**: A guided daily micro-task system for the first 30 days of No Contact.

### Phase 3: Göndermeden Cevapla
- A "Sandbox" area where users can type replies and "send" them to a digital void, allowing emotional release without breaking No Contact.

---

## Why this replaced primary Message Analysis

Transitioning the core value proposition from speculative AI analysis to internal support tools was a strategic decision based on user trust and psychological safety:

- **Trust & Reliability**: Repetitive mock analysis or inconsistent AI results could harm user trust during vulnerable moments. "Bugünün Desteği" provides reliable, predictable, and evidence-based self-regulation tools.
- **Empowerment**: Instead of asking an external entity (AI) to "translate" a partner's message, we empower the user to manage their own reactions and maintain their own boundaries.
- **Privacy & Speed**: By using local-only tools, we ensure absolute privacy and zero latency, which is critical for impulsive or high-stress moments.
- **Production AI Readiness**: While Message Analysis code remains in the codebase for future production-grade AI integration, it is not the primary user promise for this release. Production AI requires separate gates for cost, consent, and output quality.
