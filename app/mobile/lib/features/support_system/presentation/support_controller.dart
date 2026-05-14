import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';
import '../../onboarding/presentation/onboarding_controller.dart';
import '../../../data/repositories/providers.dart';
import '../data/local_support_repository.dart';
import '../domain/crisis_card.dart';
import '../../daily_rhythm/presentation/rhythm_controller.dart';
import '../../../core/notifications/notification_service.dart';

enum SupportPauseStatus { none, active, expired }

class SupportState {
  final List<CrisisCard> cards;
  final DateTime? pauseStartTime;
  final bool isLoading;

  SupportState({
    this.cards = const [],
    this.pauseStartTime,
    this.isLoading = true,
  });

  SupportPauseStatus get pauseStatus {
    if (pauseStartTime == null) return SupportPauseStatus.none;
    final diff = DateTime.now().difference(pauseStartTime!);
    return diff.inHours < 24 ? SupportPauseStatus.active : SupportPauseStatus.expired;
  }

  Duration? get remainingPauseTime {
    if (pauseStartTime == null) return null;
    final endTime = pauseStartTime!.add(const Duration(hours: 24));
    final remaining = endTime.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  SupportState copyWith({
    List<CrisisCard>? cards,
    DateTime? pauseStartTime,
    bool? isLoading,
  }) {
    return SupportState(
      cards: cards ?? this.cards,
      pauseStartTime: pauseStartTime ?? this.pauseStartTime,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  CrisisCard? get latestNote {
    final notes = cards
        .where((c) => c.type == CrisisCardType.supportNote)
        .toList();
    if (notes.isEmpty) return null;
    notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return notes.first;
  }

  CrisisCard? get pinnedReason {
    final reasonCards = cards
        .where((c) => c.type == CrisisCardType.reasonStarted)
        .toList();
    return reasonCards.isEmpty ? null : reasonCards.first;
  }
}

class SupportController extends StateNotifier<SupportState> {
  final LocalSupportRepository _repository;
  final Ref _ref;
  Timer? _ticker;

  SupportController(this._repository, this._ref) : super(SupportState()) {
    _init();
    _startTicker();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(minutes: 1), (_) {
      if (!mounted) {
        _ticker?.cancel();
        return;
      }
      if (state.pauseStatus == SupportPauseStatus.active) {
        state = state.copyWith(); // Trigger rebuild for remaining time
      }
    });
  }

  Future<void> _init() async {
    final cards = await _repository.getCrisisCards();
    final pauseStartTime = _repository.getPauseStartTime();

    state = state.copyWith(
      cards: cards,
      pauseStartTime: pauseStartTime,
      isLoading: false,
    );

    if (cards.isEmpty) {
      await _seedDefaultCards();
    }
  }

  Future<void> _seedDefaultCards() async {
    final profile = _ref.read(onboardingControllerProvider);
    final now = DateTime.now();
    final List<CrisisCard> seeds = [];

    if (profile.reason.isNotEmpty) {
      seeds.add(CrisisCard(
        id: const Uuid().v4(),
        type: CrisisCardType.reasonStarted,
        title: 'Neden Başlamıştım?',
        body: profile.reason,
        createdAt: now,
        updatedAt: now,
        isPinned: true,
      ));
    }

    if (profile.commitmentAcceptedAt != null) {
      seeds.add(CrisisCard(
        id: const Uuid().v4(),
        type: CrisisCardType.commitment,
        title: 'Sözüm',
        body: 'Bu yolculuğa kendim için çıkmaya söz verdim. İyileşmek için mesafeye ihtiyacım var.',
        createdAt: now,
        updatedAt: now,
      ));
    }

    if (profile.dominantEmotion.isNotEmpty) {
      seeds.add(CrisisCard(
        id: const Uuid().v4(),
        type: CrisisCardType.futureSelf,
        title: 'Şu Anki Duygum',
        body: 'Şu an ${profile.dominantEmotion.toLowerCase()} hissediyorum. Bu duygunun geçici olduğunu biliyorum.',
        createdAt: now,
        updatedAt: now,
      ));
    }

    if (seeds.isNotEmpty) {
      await _repository.saveCrisisCards(seeds);
      state = state.copyWith(cards: seeds);
    }
  }

  Future<void> saveSupportNote(String text) async {
    final now = DateTime.now();
    final note = CrisisCard(
      id: const Uuid().v4(),
      type: CrisisCardType.supportNote,
      title: 'Tek Cümle Not',
      body: text,
      createdAt: now,
      updatedAt: now,
    );

    await _repository.addOrUpdateCard(note);
    final updatedCards = await _repository.getCrisisCards();
    state = state.copyWith(cards: updatedCards);
  }

  Future<void> start24hPause({String source = 'support_wait'}) async {
    await _repository.start24hPause();
    await _ref.read(localManagedUrgeRepositoryProvider).saveEvent(source);
    _ref.invalidate(managedUrgeCountProvider);
    state = state.copyWith(
      pauseStartTime: _repository.getPauseStartTime(),
    );

    // Bağlamsal 24 saat takip bildirimini planla.
    final rhythmSettings = _ref.read(rhythmControllerProvider);
    if (rhythmSettings.isEnabled && rhythmSettings.contextualEnabled) {
      await NotificationService.schedule24hPauseFollowUp();
    }
  }

  Future<void> dismissPause() async {
    await _repository.clearPause();
    state = state.copyWith(
      pauseStartTime: null,
    );
  }

  Future<void> refreshPauseState() async {
    state = state.copyWith(
      pauseStartTime: _repository.getPauseStartTime(),
    );
  }
}

final localSupportRepositoryProvider = Provider((ref) => LocalSupportRepository());

final supportControllerProvider = StateNotifierProvider<SupportController, SupportState>((ref) {
  final repository = ref.watch(localSupportRepositoryProvider);
  return SupportController(repository, ref);
});
