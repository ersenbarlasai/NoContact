import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nocontact/features/recovery_path/application/recovery_path_builder.dart';
import 'package:nocontact/features/recovery_path/domain/recovery_path_step.dart';
import 'package:nocontact/features/recovery_path/presentation/recovery_path_screen.dart';

void main() {
  group('RecoveryPathBuilder Tests', () {
    test('returns core steps regardless of state', () {
      final steps = RecoveryPathBuilder.buildPath(
        noContactStartDate: DateTime.now(),
        moodEntryCount: 0,
        hasMoodEntryToday: false,
        letterCount: 0,
        managedUrgeCount: 0,
      );

      expect(steps.length, greaterThanOrEqualTo(5));
      expect(steps.any((s) => s.phase == RecoveryPhase.stabilize), isTrue);
      expect(steps.any((s) => s.phase == RecoveryPhase.moveForward), isTrue);
    });

    test('step 1 is active on day 0', () {
      final steps = RecoveryPathBuilder.buildPath(
        noContactStartDate: DateTime.now(),
        moodEntryCount: 0,
        hasMoodEntryToday: false,
        letterCount: 0,
        managedUrgeCount: 0,
      );

      final step1 = steps.firstWhere((s) => s.id == 'stabilize_1');
      expect(step1.status, StepStatus.active);
    });

    test('step 1 is completed on day 1', () {
      final steps = RecoveryPathBuilder.buildPath(
        noContactStartDate: DateTime.now().subtract(const Duration(days: 1)),
        moodEntryCount: 0,
        hasMoodEntryToday: false,
        letterCount: 0,
        managedUrgeCount: 0,
      );

      final step1 = steps.firstWhere((s) => s.id == 'stabilize_1');
      expect(step1.status, StepStatus.completed);
    });

    test('step 2 is completed if mood entry exists today', () {
      final steps = RecoveryPathBuilder.buildPath(
        noContactStartDate: DateTime.now().subtract(const Duration(days: 1)),
        moodEntryCount: 1,
        hasMoodEntryToday: true,
        letterCount: 0,
        managedUrgeCount: 0,
      );

      final step2 = steps.firstWhere((s) => s.id == 'stabilize_2');
      expect(step2.status, StepStatus.completed);
    });

    test('understand phase steps are locked if ncDays < 7', () {
      final steps = RecoveryPathBuilder.buildPath(
        noContactStartDate: DateTime.now().subtract(const Duration(days: 2)),
        moodEntryCount: 0,
        hasMoodEntryToday: false,
        letterCount: 0,
        managedUrgeCount: 0,
      );

      final understandStep = steps.firstWhere((s) => s.phase == RecoveryPhase.understand);
      expect(understandStep.status, StepStatus.locked);
    });
  });

  testWidgets('RecoveryPathScreen renders header and steps', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: RecoveryPathScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('İyileşme Yolun'), findsOneWidget);
    expect(find.text('Mevcut Kilometre Taşı'.toUpperCase()), findsOneWidget);
    expect(find.textContaining('DENGELEN'), findsAtLeast(1));
  });
}
