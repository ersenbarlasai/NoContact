import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nocontact/features/milestones/application/milestone_service.dart';
import 'package:nocontact/features/milestones/domain/milestone.dart';
import 'package:nocontact/features/milestones/presentation/milestone_controller.dart';
import 'package:nocontact/features/milestones/presentation/milestone_overlay.dart';
import 'package:nocontact/features/recovery_path/domain/recovery_path_step.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('MilestoneService Tests', () {
    test('triggers nc_3 when ncDays reaches 3', () {
      final newMilestones = MilestoneService.checkNewMilestones(
        existingMilestones: [],
        ncDays: 3,
        moodCount: 0,
        letterCount: 0,
        managedUrgeCount: 0,
        pathSteps: [],
      );

      expect(newMilestones.any((m) => m.id == 'nc_3'), isTrue);
    });

    test('does not trigger nc_3 if already exists', () {
      final existing = [
        const Milestone(id: 'nc_3', title: 'T', message: 'M', triggerType: 'nc_3')
      ];
      final newMilestones = MilestoneService.checkNewMilestones(
        existingMilestones: existing,
        ncDays: 3,
        moodCount: 0,
        letterCount: 0,
        managedUrgeCount: 0,
        pathSteps: [],
      );

      expect(newMilestones.any((m) => m.id == 'nc_3'), isFalse);
    });
  });

  testWidgets('MilestoneOverlay renders when pendingMilestone exists', (WidgetTester tester) async {
    final milestone = Milestone(
      id: 'test',
      title: 'Tebrikler',
      message: 'Harika gidiyorsun',
      triggerType: 'test',
      createdAt: DateTime.now(),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          milestoneControllerProvider.overrideWith((ref) {
            return _SimpleMilestoneController(MilestoneState(
              allMilestones: [milestone],
              pendingMilestone: milestone,
            ));
          }),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: MilestoneOverlay(),
          ),
        ),
      ),
    );

    expect(find.text('Tebrikler'), findsOneWidget);
    expect(find.text('Harika gidiyorsun'), findsOneWidget);
  });
}

class _SimpleMilestoneController extends StateNotifier<MilestoneState> implements MilestoneController {
  _SimpleMilestoneController(MilestoneState state) : super(state);
  
  @override
  Future<void> dismissMilestone() async {}

  @override
  void _checkNew() {}

  @override
  Future<void> _init() async {}
}
