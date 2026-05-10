import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nocontact/features/message_analysis/presentation/message_analysis_screen.dart';
import 'package:nocontact/features/subscription/domain/entitlement_state.dart';
import 'package:nocontact/features/subscription/presentation/entitlement_controller.dart';
import 'package:nocontact/features/subscription/data/entitlement_repository.dart';
import 'package:nocontact/core/design_system/still_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('MessageAnalysisScreen UI Flow', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: MessageAnalysisScreen(),
        ),
      ),
    );

    // 1. Initial State
    expect(find.text('MESAJ ANALİZİ'), findsOneWidget);
    final analyzeButton = find.byType(StillPrimaryButton);
    expect(analyzeButton, findsOneWidget);
    
    // Button should be disabled initially (null onPressed in the widget, but we check if input is empty)
    // Actually, in our implementation, we check inputText.trim().isEmpty.
    // Let's check if tapping it does nothing or shows error (if we added it).
    
    // 2. Enter Text
    await tester.enterText(find.byType(TextField), 'Seni özledim');
    await tester.pump();
    
    // 3. Start Analysis
    await tester.tap(analyzeButton);
    await tester.pump(); // Start loading
    
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    
    // Wait for mock delay
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    
    // 4. Show Results
    expect(find.text('ANALİZ SONUCU'), findsOneWidget);
    expect(find.text('Duygusal Ton'), findsOneWidget);
    expect(find.text('Risk Seviyesi'), findsOneWidget);
    expect(find.text('Önerilen Eylem'), findsOneWidget);
    
    // 5. Clear / Reset
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    
    expect(find.text('MESAJ ANALİZİ'), findsOneWidget);
  });

  testWidgets('MessageAnalysisScreen Limit Reached UI', (WidgetTester tester) async {
    final limitReachedState = EntitlementState(
      tier: SubscriptionTier.free,
      messageAnalysisDailyLimit: 3,
      messageAnalysisUsedToday: 3,
      lastResetDate: DateTime.now(),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          entitlementControllerProvider.overrideWith((ref) => EntitlementControllerMock(limitReachedState)),
        ],
        child: const MaterialApp(
          home: MessageAnalysisScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Test message');
    await tester.pump();

    await tester.tap(find.byType(StillPrimaryButton));
    await tester.pump();

    expect(find.textContaining('Günlük limitine ulaştın'), findsOneWidget);
  });
}

class EntitlementControllerMock extends EntitlementController {
  EntitlementControllerMock(EntitlementState state) : super(EntitlementRepository()) {
    this.state = state;
  }
  @override
  Future<void> refresh() async {}
}
