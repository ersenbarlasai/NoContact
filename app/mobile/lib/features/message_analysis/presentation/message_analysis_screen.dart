import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/message_analysis_types.dart';
import 'message_analysis_controller.dart';

class MessageAnalysisScreen extends ConsumerStatefulWidget {
  const MessageAnalysisScreen({super.key});

  @override
  ConsumerState<MessageAnalysisScreen> createState() => _MessageAnalysisScreenState();
}

class _MessageAnalysisScreenState extends ConsumerState<MessageAnalysisScreen> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(messageAnalysisControllerProvider);
    final isAnalyzed = state.result != null;

    // Show consent dialog if needed
    if (state.needsConsent) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showConsentDialog(context);
      });
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.onSurfaceVariant),
                    onPressed: () {
                      if (isAnalyzed) {
                        ref.read(messageAnalysisControllerProvider.notifier).resetResult();
                      } else {
                        context.pop();
                      }
                    },
                  ),
                  Text(
                    isAnalyzed
                        ? AppLocalizations.of(context).messageAnalysisDetailTitle.toUpperCase()
                        : AppLocalizations.of(context).messageAnalysisTitle.toUpperCase(),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          letterSpacing: 2,
                          color: AppColors.primary,
                        ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 32),
              
              if (!isAnalyzed) 
                _buildInputState(state) 
              else 
                _buildResultState(state),
              
              const SizedBox(height: 48),
              
              StillPrivacyNotice(
                text: AppLocalizations.of(context).messageAnalysisInputSubtitle,
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context).appDisclaimer,
                textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConsentDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.privacy_tip_outlined, size: 48, color: AppColors.primary),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context).messageAnalysisInputTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).messageAnalysisInputSubtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            StillPrimaryButton(
              label: AppLocalizations.of(context).okBtn,
              onPressed: () {
                ref.read(messageAnalysisControllerProvider.notifier).acceptConsent();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputState(MessageAnalysisState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StillSectionHeader(
          title: AppLocalizations.of(context).messageAnalysisInputTitle,
          subtitle: AppLocalizations.of(context).messageAnalysisInputSubtitle,
        ),
        const SizedBox(height: 32),
        StillTextField(
          controller: _messageController,
          hintText: AppLocalizations.of(context).messageAnalysisHint,
          isLarge: true,
          onChanged: (val) => ref.read(messageAnalysisControllerProvider.notifier).updateInput(val),
        ),
        if (state.error != null) ...[
          const SizedBox(height: 8),
          Text(state.error!, style: const TextStyle(color: AppColors.error, fontSize: 12)),
        ],
        const SizedBox(height: 32),
        StillPrimaryButton(
          label: state.isAnalyzing
              ? AppLocalizations.of(context).messageAnalysisLoading
              : AppLocalizations.of(context).messageAnalysisAnalyzeBtn,
          icon: state.isAnalyzing ? null : Icons.psychology_outlined,
          isLoading: state.isAnalyzing,
          onPressed: state.inputText.trim().isEmpty || state.isAnalyzing
            ? null 
            : () => ref.read(messageAnalysisControllerProvider.notifier).analyze(),
        ),
      ],
    );
  }

  Widget _buildResultState(MessageAnalysisState state) {
    final result = state.result!;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StillSectionHeader(
          title: 'Mesafe ile Gelen Netlik',
          centered: true,
        ),
        const SizedBox(height: 32),
        
        // Bento Grid for Tone & Risk
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StillCard(
                color: AppColors.surfaceContainerLow,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.psychology, color: AppColors.tertiary, size: 24),
                    const SizedBox(height: 12),
                    Text('Duygusal Ton', style: Theme.of(context).textTheme.labelSmall),
                    const SizedBox(height: 4),
                    Text(result.emotionalTone, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      result.shortSummary,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: StillCard(
                color: AppColors.surfaceContainerLow,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      result.riskLevel == RiskLevel.high ? Icons.warning_amber_rounded : Icons.shield_moon, 
                      color: _getRiskColor(result.riskLevel), 
                      size: 24
                    ),
                    const SizedBox(height: 12),
                    Text(AppLocalizations.of(context).messageAnalysisRisk,
                        style: Theme.of(context).textTheme.labelSmall),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 8, 
                          height: 8, 
                          decoration: BoxDecoration(shape: BoxShape.circle, color: _getRiskColor(result.riskLevel))
                        ),
                        const SizedBox(width: 8),
                        Text(_getRiskLabel(result.riskLevel), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getRiskDescription(result.riskLevel),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 24),

        if (result.detectedPatterns.isNotEmpty) ...[
          Text(AppLocalizations.of(context).messageAnalysisPatterns,
              style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: result.detectedPatterns.map((s) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(s, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
            )).toList(),
          ),
          const SizedBox(height: 24),
        ],
        
        // Recommended Action
        StillCard(
          color: _getActionColor(result.recommendedAction),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).messageAnalysisSuggestedAction,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: _getOnActionColor(result.recommendedAction).withValues(alpha: 0.8)),
              ),
              const SizedBox(height: 8),
              Text(
                _getActionLabel(result.recommendedAction),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontFamily: 'Literata',
                      color: _getOnActionColor(result.recommendedAction),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Container(width: 40, height: 2, color: _getOnActionColor(result.recommendedAction).withValues(alpha: 0.3)),
              const SizedBox(height: 16),
              Text(
                result.boundaryRecommendation,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: _getOnActionColor(result.recommendedAction)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),
        StillCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context).messageAnalysisDetailTitle,
                  style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 12),
              Text(
                result.userFacingExplanation,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),

        if (result.safeReplyExample != null) ...[
          const SizedBox(height: 24),
          StillCard(
            color: AppColors.surfaceContainerHigh,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context).messageAnalysisSafeReply,
                    style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 12),
                Text(
                  result.safeReplyExample!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontFamily: 'Literata', fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 16),
                StillSecondaryButton(
                  label: AppLocalizations.of(context).copyBtn,
                  onPressed: () {
                    // TODO: Implement clipboard copy
                  },
                ),
              ],
            ),
          ),
        ],
        
        const SizedBox(height: 32),
        
        // Grounding Reminder
        StillSectionHeader(title: AppLocalizations.of(context).messageAnalysisGrounding),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primaryContainer.withValues(alpha: 0.1)),
          ),
          child: Column(
            children: [
              Text(
                '"${result.shortSummary}"',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontFamily: 'Literata',
                      fontStyle: FontStyle.italic,
                      color: AppColors.onSurfaceVariant,
                      height: 1.6,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                result.disclaimer,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10, color: AppColors.onSurfaceVariant.withValues(alpha: 0.5)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        StillSecondaryButton(
          label: AppLocalizations.of(context).newAnalysisBtn,
          onPressed: () => ref.read(messageAnalysisControllerProvider.notifier).resetResult(),
        ),
      ],
    );
  }

  Color _getRiskColor(RiskLevel level) {
    switch (level) {
      case RiskLevel.high: return AppColors.error;
      case RiskLevel.medium: return AppColors.tertiary;
      case RiskLevel.low: return AppColors.primary;
    }
  }

  String _getRiskLabel(RiskLevel level) {
    final l10n = AppLocalizations.of(_context!);
    switch (level) {
      case RiskLevel.high:   return l10n.messageAnalysisRiskHigh;
      case RiskLevel.medium: return l10n.messageAnalysisRiskMedium;
      case RiskLevel.low:    return l10n.messageAnalysisRiskLow;
    }
  }

  String _getRiskDescription(RiskLevel level) {
    final l10n = AppLocalizations.of(_context!);
    switch (level) {
      case RiskLevel.high:   return l10n.messageAnalysisRiskHighDesc;
      case RiskLevel.medium: return l10n.messageAnalysisRiskMediumDesc;
      case RiskLevel.low:    return l10n.messageAnalysisRiskLowDesc;
    }
  }

  Color _getActionColor(RecommendedAction action) {
    switch (action) {
      case RecommendedAction.doNotReply: return AppColors.tertiaryContainer;
      case RecommendedAction.wait: return AppColors.primaryContainer;
      case RecommendedAction.replyWithBoundary: return AppColors.secondaryContainer;
      case RecommendedAction.useSos: return AppColors.errorContainer;
      case RecommendedAction.writeUnsentLetter: return AppColors.primaryFixed;
    }
  }

  Color _getOnActionColor(RecommendedAction action) {
    switch (action) {
      case RecommendedAction.doNotReply: return AppColors.onTertiaryContainer;
      case RecommendedAction.wait: return AppColors.onPrimaryContainer;
      case RecommendedAction.replyWithBoundary: return AppColors.onSecondaryContainer;
      case RecommendedAction.useSos: return AppColors.onErrorContainer;
      case RecommendedAction.writeUnsentLetter: return AppColors.onPrimaryFixed;
    }
  }

  String _getActionLabel(RecommendedAction action) {
    final l10n = AppLocalizations.of(_context!);
    switch (action) {
      case RecommendedAction.doNotReply:        return l10n.messageAnalysisActionDoNotReply;
      case RecommendedAction.wait:              return l10n.messageAnalysisActionWait;
      case RecommendedAction.replyWithBoundary: return l10n.messageAnalysisActionBoundary;
      case RecommendedAction.useSos:            return l10n.messageAnalysisActionSos;
      case RecommendedAction.writeUnsentLetter: return l10n.messageAnalysisActionLetter;
    }
  }

  BuildContext? get _context => context;
}
