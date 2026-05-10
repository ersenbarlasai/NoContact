import 'package:freezed_annotation/freezed_annotation.dart';
import '../../milestones/domain/milestone.dart';

part 'insights_data.freezed.dart';

@freezed
class InsightsData with _$InsightsData {
  const factory InsightsData({
    required int ncDays,
    required int managedUrgeCount,
    required int moodStreak,
    required int moodCount,
    required int milestoneCount,
    required int letterCount,
    required List<Milestone> milestoneHistory,
    required Map<String, int> moodDistribution,
    @Default(false) bool isLoading,
  }) = _InsightsData;
}
