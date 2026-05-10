import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recovery_path_step.freezed.dart';

enum RecoveryPhase {
  @JsonValue('stabilize')
  stabilize,
  @JsonValue('understand')
  understand,
  @JsonValue('resist')
  resist,
  @JsonValue('rebuild')
  rebuild,
  @JsonValue('moveForward')
  moveForward,
}

enum StepStatus {
  @JsonValue('locked')
  locked,
  @JsonValue('active')
  active,
  @JsonValue('completed')
  completed,
}

@freezed
class RecoveryPathStep with _$RecoveryPathStep {
  const factory RecoveryPathStep({
    required String id,
    required String title,
    required String description,
    required RecoveryPhase phase,
    int? dayTarget,
    @Default(StepStatus.locked) StepStatus status,
    String? suggestedActionRoute,
    IconData? icon,
  }) = _RecoveryPathStep;
}

extension RecoveryPhaseX on RecoveryPhase {
  String get label {
    switch (this) {
      case RecoveryPhase.stabilize:
        return 'Dengelen';
      case RecoveryPhase.understand:
        return 'Anla';
      case RecoveryPhase.resist:
        return 'Diren';
      case RecoveryPhase.rebuild:
        return 'Kendini Yeniden Kur';
      case RecoveryPhase.moveForward:
        return 'İlerle';
    }
  }

  String get dayRange {
    switch (this) {
      case RecoveryPhase.stabilize:
        return 'Gün 1 - 7';
      case RecoveryPhase.understand:
        return 'Gün 8 - 14';
      case RecoveryPhase.resist:
        return 'Gün 15 - 21';
      case RecoveryPhase.rebuild:
        return 'Gün 22 - 27';
      case RecoveryPhase.moveForward:
        return 'Gün 28 - 30';
    }
  }

  IconData get icon {
    switch (this) {
      case RecoveryPhase.stabilize:
        return Icons.spa_outlined;
      case RecoveryPhase.understand:
        return Icons.psychology_outlined;
      case RecoveryPhase.resist:
        return Icons.block_outlined;
      case RecoveryPhase.rebuild:
        return Icons.favorite_border_outlined;
      case RecoveryPhase.moveForward:
        return Icons.north_east_outlined;
    }
  }
}
