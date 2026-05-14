import 'package:flutter/material.dart';
import '../domain/recovery_path_step.dart';

class RecoveryPathBuilder {
  static List<RecoveryPathStep> buildPath({
    required DateTime recoveryJourneyStartDate,
    required int moodEntryCount,
    required bool hasMoodEntryToday,
    required int letterCount,
    required int managedUrgeCount,
  }) {
    final now = DateTime.now();
    final journeyDays = now.difference(DateTime(
      recoveryJourneyStartDate.year, recoveryJourneyStartDate.month, recoveryJourneyStartDate.day
    )).inDays + 1;

    final steps = <RecoveryPathStep>[
      // Phase 1: Stabilize (Gün 1-7)
      RecoveryPathStep(
        id: 'stabilize_1',
        title: 'İlk 24 Saati Koru',
        description: 'En zorlu anlarda SOS aracını kullanarak temas etmemeyi başar.',
        phase: RecoveryPhase.stabilize,
        dayTarget: 1,
        status: journeyDays >= 2 ? StepStatus.completed : StepStatus.active,
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
            : (journeyDays >= 2 ? StepStatus.active : StepStatus.locked),
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
            : (journeyDays >= 4 ? StepStatus.active : StepStatus.locked),
        suggestedActionRoute: '/silent-reply',
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
            : (journeyDays >= 8 ? StepStatus.active : StepStatus.locked),
        suggestedActionRoute: '/mood-journal',
        icon: Icons.analytics_outlined,
      ),
      RecoveryPathStep(
        id: 'understand_2',
        title: 'Duygusal Dalgalanma',
        description: 'Duyguların gelip geçici olduğunu fark etmeye başla.',
        phase: RecoveryPhase.understand,
        dayTarget: 12,
        status: journeyDays >= 13 ? StepStatus.active : (journeyDays >= 8 ? StepStatus.active : StepStatus.locked),
        suggestedActionRoute: '/library',
        icon: Icons.waves_outlined,
      ),

      // Phase 3: Resist (Gün 15-21)
      RecoveryPathStep(
        id: 'resist_1',
        title: 'İrade Kasını Güçlendir',
        description: 'Anlık dürtülere karşı koyma becerini geliştir.',
        phase: RecoveryPhase.resist,
        dayTarget: 15,
        status: journeyDays >= 15 ? StepStatus.active : StepStatus.locked,
        suggestedActionRoute: '/support-center',
        icon: Icons.fitness_center_outlined,
      ),
      RecoveryPathStep(
        id: 'resist_2',
        title: 'Sınır Koymak',
        description: 'Hayır demenin ve sessiz kalmanın özgürleştirici gücünü kullan.',
        phase: RecoveryPhase.resist,
        dayTarget: 18,
        status: journeyDays >= 18 ? StepStatus.active : StepStatus.locked,
        suggestedActionRoute: '/silent-reply',
        icon: Icons.shield_outlined,
      ),

      // Phase 4: Rebuild (Gün 22-27)
      RecoveryPathStep(
        id: 'rebuild_1',
        title: 'Kendine Dönüş Planı',
        description: 'Eski alışkanlıkların yerine yeni ve sağlıklı rutinler koy.',
        phase: RecoveryPhase.rebuild,
        dayTarget: 22,
        status: journeyDays >= 22 ? StepStatus.active : StepStatus.locked,
        suggestedActionRoute: '/recovery-path',
        icon: Icons.auto_fix_high_outlined,
      ),

      // Phase 5: Move Forward (Gün 28-30)
      RecoveryPathStep(
        id: 'move_forward_1',
        title: 'Yeni Bir Sayfa',
        description: 'Artık kontrol sende. İyileşme yolunda dev bir adım attın.',
        phase: RecoveryPhase.moveForward,
        dayTarget: 30,
        status: journeyDays >= 30 ? StepStatus.active : StepStatus.locked,
        suggestedActionRoute: '/support-center',
        icon: Icons.celebration_outlined,
      ),
    ];

    return steps;
  }
}
