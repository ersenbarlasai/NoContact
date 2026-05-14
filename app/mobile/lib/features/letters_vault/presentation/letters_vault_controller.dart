import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/unsent_letter.dart';
import '../../../data/repositories/providers.dart';

class LettersVaultState {
  final List<UnsentLetter> letters;
  final bool isLoading;

  LettersVaultState({
    this.letters = const [],
    this.isLoading = false,
  });

  List<UnsentLetter> get activeLetters => 
      letters.where((l) => l.archivedAt == null).toList()
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

  List<UnsentLetter> get archivedLetters => 
      letters.where((l) => l.archivedAt != null).toList()
        ..sort((a, b) => b.archivedAt!.compareTo(a.archivedAt!));

  LettersVaultState copyWith({
    List<UnsentLetter>? letters,
    bool? isLoading,
  }) {
    return LettersVaultState(
      letters: letters ?? this.letters,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LettersVaultController extends StateNotifier<LettersVaultState> {
  final Ref _ref;

  LettersVaultController(this._ref) : super(LettersVaultState()) {
    loadLetters();
  }

  Future<void> loadLetters() async {
    state = state.copyWith(isLoading: true);
    final repo = _ref.read(localLettersVaultRepositoryProvider);
    final letters = await repo.fetchLetters();
    state = state.copyWith(letters: letters, isLoading: false);
  }

  UnsentLetter createDraft() {
    final now = DateTime.now();
    return UnsentLetter(
      id: const Uuid().v4(),
      body: '',
      createdAt: now,
      updatedAt: now,
    );
  }

  Future<void> saveLetter(UnsentLetter letter) async {
    final repo = _ref.read(localLettersVaultRepositoryProvider);
    final updatedLetter = letter.copyWith(updatedAt: DateTime.now());
    await repo.saveLetter(updatedLetter);
    await loadLetters();
  }

  Future<void> archiveLetter(String id) async {
    final repo = _ref.read(localLettersVaultRepositoryProvider);
    await repo.archiveLetter(id);
    await loadLetters();
  }

  Future<void> deleteLetter(String id) async {
    final repo = _ref.read(localLettersVaultRepositoryProvider);
    await repo.deleteLetter(id);
    await loadLetters();
  }

  Future<void> restoreLetter(String id) async {
    final repo = _ref.read(localLettersVaultRepositoryProvider);
    await repo.restoreLetter(id);
    await loadLetters();
  }

  Future<void> hardDeleteLetter(String id) async {
    final repo = _ref.read(localLettersVaultRepositoryProvider);
    await repo.hardDeleteLetter(id);
    await loadLetters();
  }
}

final lettersVaultControllerProvider =
    StateNotifierProvider<LettersVaultController, LettersVaultState>((ref) {
  return LettersVaultController(ref);
});
