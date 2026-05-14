enum SilentReplyNeed {
  relief('Rahatlamak', 'Şu anki yoğunluk kararım olmak zorunda değil. Önce kendime alan açıyorum.'),
  explanation('Açıklanmak', 'Kendimi açıklama isteğimi fark ediyorum, ama şu an kendimi korumayı seçiyorum.'),
  heard('Duyulmak', 'Duyulma ihtiyacım gerçek. Bunu göndermeden de kendime duyurabilirim.'),
  boundaries('Sınır koymak', 'Şu an bu konuşmaya devam etmek bana iyi gelmiyor. Kendime alan açmam gerekiyor.'),
  apology('Özür dilemek', 'Pişmanlık hissimi kabul ediyorum. Ama bugün aceleyle hareket etmeyeceğim.'),
  control('Kontrolü geri almak', 'Kontrolü mesaj göndererek değil, durarak geri alıyorum.');

  final String label;
  final String boundarySentence;

  const SilentReplyNeed(this.label, this.boundarySentence);
}
