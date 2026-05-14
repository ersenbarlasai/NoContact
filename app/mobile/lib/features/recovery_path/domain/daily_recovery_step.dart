import '../../library/domain/library_item.dart';

class DailyRecoveryStep {
  final int dayNumber;
  final String title;
  final String theme;
  final String shortExplanation;
  final String smallTask;
  final String reflectionQuestion;
  final LibrarySuggestedAction linkedTool;
  final String linkedToolLabel;

  const DailyRecoveryStep({
    required this.dayNumber,
    required this.title,
    required this.theme,
    required this.shortExplanation,
    required this.smallTask,
    required this.reflectionQuestion,
    required this.linkedTool,
    required this.linkedToolLabel,
  });
}
