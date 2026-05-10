import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/milestone_repository.dart';
import '../domain/milestone.dart';
import '../application/milestone_service.dart';
import '../../recovery_path/presentation/recovery_path_controller.dart';

part 'milestone_controller.freezed.dart';

@freezed
class MilestoneState with _$MilestoneState {
  const factory MilestoneState({
    @Default([]) List<Milestone> allMilestones,
    Milestone? pendingMilestone,
  }) = _MilestoneState;
}

class MilestoneController extends StateNotifier<MilestoneState> {
  final MilestoneRepository _repository;
  final Ref _ref;

  MilestoneController(this._repository, this._ref) : super(const MilestoneState()) {
    _init();
  }

  Future<void> _init() async {
    final milestones = await _repository.fetchMilestones();
    if (!mounted) return;
    state = state.copyWith(allMilestones: milestones);
    _checkNew();
  }

  void _checkNew() {
    final pathState = _ref.read(recoveryPathControllerProvider);
    if (pathState.isLoading) return;

    final newMilestones = MilestoneService.checkNewMilestones(
      existingMilestones: state.allMilestones,
      ncDays: pathState.ncDays,
      moodCount: pathState.moodCount,
      letterCount: pathState.letterCount,
      managedUrgeCount: pathState.managedUrgeCount,
      pathSteps: pathState.steps,
    );

    if (newMilestones.isNotEmpty) {
      final updatedAll = [...state.allMilestones, ...newMilestones];
      state = state.copyWith(
        allMilestones: updatedAll,
        pendingMilestone: state.pendingMilestone ?? newMilestones.first,
      );
      _repository.saveMilestones(updatedAll);
    }
  }

  Future<void> dismissMilestone() async {
    final current = state.pendingMilestone;
    if (current == null) return;
    
    final id = current.id;
    await _repository.markAsSeen(id);
    
    final updatedAll = state.allMilestones.map((m) {
      if (m.id == id) return m.copyWith(isSeen: true, seenAt: DateTime.now());
      return m;
    }).toList();

    // Find next unseen milestone
    final nextPending = updatedAll.where((m) => !m.isSeen).firstOrNull;
    
    state = state.copyWith(
      allMilestones: updatedAll,
      pendingMilestone: nextPending,
    );
  }
}

final milestoneRepositoryProvider = Provider((ref) => MilestoneRepository());

final milestoneControllerProvider =
    StateNotifierProvider<MilestoneController, MilestoneState>((ref) {
  // Refresh when recovery path updates
  ref.watch(recoveryPathControllerProvider);
  final repo = ref.watch(milestoneRepositoryProvider);
  return MilestoneController(repo, ref);
});
