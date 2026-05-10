import '../domain/milestone.dart';
import '../../recovery_path/domain/recovery_path_step.dart';

class MilestoneService {
  static List<Milestone> checkNewMilestones({
    required List<Milestone> existingMilestones,
    required int ncDays,
    required int moodCount,
    required int letterCount,
    required int managedUrgeCount,
    required List<RecoveryPathStep> pathSteps,
  }) {
    final newMilestones = <Milestone>[];

    void addIfMissing(String id, String title, String message) {
      if (!existingMilestones.any((m) => m.id == id)) {
        newMilestones.add(Milestone(
          id: id,
          title: title,
          message: message,
          triggerType: id,
          createdAt: DateTime.now(),
        ));
      }
    }

    // NC Day Milestones
    if (ncDays >= 3) {
      addIfMissing('nc_3', 'İlk Üç Gün', 'Fark ettin mi? Kendin için ilk üç günü tamamladın. Bu sessizlik senin iyileşme alanın.');
    }
    if (ncDays >= 7) {
      addIfMissing('nc_7', 'Bir Hafta Tamamlandı', 'Tam bir haftadır kendi yolunda, kararlılıkla yürüyorsun. Bu senin gücün.');
    }
    if (ncDays >= 14) {
      addIfMissing('nc_14', 'İki Hafta', 'Duyguların gelip geçiciliğini fark ettiğin on dört gün. Kendine verdiğin en nazik hediye.');
    }
    if (ncDays >= 30) {
      addIfMissing('nc_30', 'Kritik Eşik: Bir Ay', 'Otuz gün. Alışkanlıkların dönüştüğü, zihnin durulduğu yer. Sen başardın.');
    }

    // Feature Usage Milestones
    if (managedUrgeCount >= 1) {
      addIfMissing('first_sos', 'Dürtüye Karşı Durmak', 'O an geldiğinde durmayı ve nefes almayı seçtin. İlk dürtüyü başarıyla yönettin.');
    }
    if (moodCount >= 1) {
      addIfMissing('first_mood', 'Duygularınla Tanışmak', 'İlk kez nasıl hissettiğini isimlendirdin. Farkındalık iyileşmenin başlangıcıdır.');
    }
    if (letterCount >= 1) {
      addIfMissing('first_letter', 'İçini Dökmek', 'Söylemek istediklerini yazdın ama güvenli alanında tuttun. Bu büyük bir irade.');
    }

    // Recovery Path Phase Milestones
    final completedPhases = pathSteps
        .where((s) => s.status == StepStatus.completed)
        .map((s) => s.phase)
        .toSet();

    for (final phase in completedPhases) {
      final phaseId = 'phase_${phase.name}';
      String title = '';
      String message = '';

      switch (phase) {
        case RecoveryPhase.stabilize:
          title = 'Dengelenme Tamamlandı';
          message = 'Fırtınanın ortasında durmayı ve sakinleşmeyi öğrendin. İlk aşamayı geride bıraktın.';
          break;
        case RecoveryPhase.understand:
          title = 'Anlama Aşaması Geçildi';
          message = 'Duygularının dilini anlamaya başladın. Artık daha bilinçli bir yerdesin.';
          break;
        case RecoveryPhase.resist:
          title = 'Direnç Kazandın';
          message = 'Zor anların seni değil, senin onları yönettiğini kanıtladın.';
          break;
        case RecoveryPhase.rebuild:
          title = 'Yeniden Kuruluş';
          message = 'Eskinin yerine yeniyi, daha sağlıklı olanı koymaya başladın.';
          break;
        case RecoveryPhase.moveForward:
          title = 'Yolun Sonu Değil, Yeni Bir Başlangıç';
          message = 'Otuz günlük bu yolculuğu tamamladın. Artık kendi kanatlarınla uçmaya hazırsın.';
          break;
      }

      if (title.isNotEmpty) {
        addIfMissing(phaseId, title, message);
      }
    }

    return newMilestones;
  }
}
