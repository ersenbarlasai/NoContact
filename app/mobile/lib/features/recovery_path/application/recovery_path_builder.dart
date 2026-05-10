import 'package:flutter/material.dart';
import '../domain/recovery_path_step.dart';

class RecoveryPathBuilder {
  static List<RecoveryPathStep> buildPath({
    required DateTime noContactStartDate,
    required int moodEntryCount,
    required bool hasMoodEntryToday,
    required int letterCount,
    required int managedUrgeCount,
  }) {
    final now = DateTime.now();
    final ncDays = now.difference(noContactStartDate).inDays;

    final steps = <RecoveryPathStep>[
      // Phase 1: Stabilize (Gün 1-7)
      RecoveryPathStep(
        id: 'stabilize_1',
        title: 'İlk 24 Saati Koru',
        description: 'En zorlu anlarda SOS aracını kullanarak temas etmemeyi başar.',
        phase: RecoveryPhase.stabilize,
        dayTarget: 1,
        status: ncDays >= 1 ? StepStatus.completed : StepStatus.active,
        suggestedActionRoute: '/sos',
        icon: Icons.emergency_outlined,
      ),
      RecoveryPathStep(
        id: 'stabilize_2',
        title: 'Bugünkü Duygunu Adlandır',
        description: 'Duygularını fark etmek, onları yönetmenin ilk adımıdır.',
        phase: RecoveryPhase.stabilize,
        dayTarget: 2,
        status: hasMoodEntryToday 
            ? StepStatus.completed 
            : (ncDays >= 1 ? StepStatus.active : StepStatus.locked),
        suggestedActionRoute: '/mood-journal',
        icon: Icons.wb_sunny_outlined,
      ),
      RecoveryPathStep(
        id: 'stabilize_3',
        title: 'Yaz Ama Gönderme',
        description: 'İçinde kalanları mektuba dök ama asla paylaşma.',
        phase: RecoveryPhase.stabilize,
        dayTarget: 4,
        status: letterCount > 0 
            ? StepStatus.completed 
            : (ncDays >= 3 ? StepStatus.active : StepStatus.locked),
        suggestedActionRoute: '/letters-vault',
        icon: Icons.history_edu_outlined,
      ),

      // Phase 2: Understand (Gün 8-14)
      RecoveryPathStep(
        id: 'understand_1',
        title: 'Tetikleyicini Tanı',
        description: 'Seni en çok neyin zorladığını anlamak için günlük verilerini incele.',
        phase: RecoveryPhase.understand,
        dayTarget: 8,
        status: moodEntryCount >= 5 
            ? StepStatus.completed 
            : (ncDays >= 7 ? StepStatus.active : StepStatus.locked),
        suggestedActionRoute: '/mood-journal',
        icon: Icons.analytics_outlined,
      ),
      RecoveryPathStep(
        id: 'understand_2',
        title: 'Duygusal Dalgalanma',
        description: 'Duyguların gelip geçici olduğunu fark etmeye başla.',
        phase: RecoveryPhase.understand,
        dayTarget: 12,
        status: ncDays >= 12 ? StepStatus.active : StepStatus.locked,
        icon: Icons.waves_outlined,
      ),

      // Phase 3: Resist (Gün 15-21)
      RecoveryPathStep(
        id: 'resist_1',
        title: 'İrade Kasını Güçlendir',
        description: 'Anlık dürtülere karşı koyma becerini geliştir.',
        phase: RecoveryPhase.resist,
        dayTarget: 15,
        status: ncDays >= 15 ? StepStatus.active : StepStatus.locked,
        icon: Icons.fitness_center_outlined,
      ),

      // Phase 4: Rebuild (Gün 22-27)
      RecoveryPathStep(
        id: 'rebuild_1',
        title: 'Kendine Dönüş Planı',
        description: 'Eski alışkanlıkların yerine yeni ve sağlıklı rutinler koy.',
        phase: RecoveryPhase.rebuild,
        dayTarget: 22,
        status: ncDays >= 22 ? StepStatus.active : StepStatus.locked,
        icon: Icons.auto_fix_high_outlined,
      ),

      // Phase 5: Move Forward (Gün 28-30)
      RecoveryPathStep(
        id: 'move_forward_1',
        title: 'Yeni Bir Sayfa',
        description: 'Artık kontrol sende. İyileşme yolunda dev bir adım attın.',
        phase: RecoveryPhase.moveForward,
        dayTarget: 30,
        status: ncDays >= 30 ? StepStatus.active : StepStatus.locked,
        icon: Icons.celebration_outlined,
      ),
    ];

    return steps;
  }
}
