enum LibraryCategory {
  ilkGunler,
  durtuGeldiginde,
  sosyalMedyaKontrolu,
  ozlemDalgasi,
  sinirKoymak,
  kendiniSuclama,
  geriDonmeDongusu,
  geceZorlanmalari;

  String get label {
    switch (this) {
      case LibraryCategory.ilkGunler: return 'İlk Günler';
      case LibraryCategory.durtuGeldiginde: return 'Dürtü Geldiğinde';
      case LibraryCategory.sosyalMedyaKontrolu: return 'Sosyal Medya';
      case LibraryCategory.ozlemDalgasi: return 'Özlem Dalgası';
      case LibraryCategory.sinirKoymak: return 'Sınır Koymak';
      case LibraryCategory.kendiniSuclama: return 'Kendini Suçlama';
      case LibraryCategory.geriDonmeDongusu: return 'Geri Dönme Döngüsü';
      case LibraryCategory.geceZorlanmalari: return 'Gece Zorlanmaları';
    }
  }
}

enum LibraryItemType {
  okuma,
  egzersiz,
  yansima;

  String get label {
    switch (this) {
      case LibraryItemType.okuma: return 'Okuma';
      case LibraryItemType.egzersiz: return 'Egzersiz';
      case LibraryItemType.yansima: return 'Yansıma';
    }
  }
}

enum LibrarySuggestedAction {
  sos,
  lettersVault,
  supportWait,
  moodJournal,
  supportCenter,
}

class LibraryItem {
  final String id;
  final String title;
  final LibraryCategory category;
  final LibraryItemType type;
  final int estimatedMinutes;
  final String summary;
  final String body;
  final String reflectionQuestion;
  final LibrarySuggestedAction suggestedActionType;
  final String suggestedActionLabel;

  const LibraryItem({
    required this.id,
    required this.title,
    required this.category,
    required this.type,
    required this.estimatedMinutes,
    required this.summary,
    required this.body,
    required this.reflectionQuestion,
    required this.suggestedActionType,
    required this.suggestedActionLabel,
  });
}
