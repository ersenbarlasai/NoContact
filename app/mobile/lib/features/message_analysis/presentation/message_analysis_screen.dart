import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
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
                    isAnalyzed ? 'ANALİZ SONUCU' : 'MESAJ ANALİZİ',
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
              
              const StillPrivacyNotice(
                text: 'Mesaj metni sunucularımızda saklanmaz, sadece analiz için işlenir.',
              ),
              const SizedBox(height: 16),
              Text(
                'AI desteği profesyonel terapi veya acil yardım yerine geçmez.',
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
              'Veri İşleme İzni',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              'Bu analiz için yapıştırdığın mesaj güvenli sunucu üzerinden AI sağlayıcısına gönderilir. Mesaj metni veritabanına kaydedilmez. Devam ederek bunu kabul edersin.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            StillPrimaryButton(
              label: 'KABUL EDİYORUM',
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
        const StillSectionHeader(
          title: 'Mesajı Paylaş',
          subtitle: 'Gelen mesajın altındaki niyetleri daha sakin bir gözle değerlendirelim.',
        ),
        const SizedBox(height: 32),
        StillTextField(
          controller: _messageController,
          hintText: 'Mesajı buraya yapıştır...',
          isLarge: true,
          onChanged: (val) => ref.read(messageAnalysisControllerProvider.notifier).updateInput(val),
        ),
        if (state.error != null) ...[
          const SizedBox(height: 8),
          Text(state.error!, style: const TextStyle(color: AppColors.error, fontSize: 12)),
        ],
        const SizedBox(height: 32),
        StillPrimaryButton(
          label: state.isAnalyzing ? 'ANALİZ EDİLİYOR...' : 'ANALİZİ BAŞLAT',
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
                    Text('Risk Seviyesi', style: Theme.of(context).textTheme.labelSmall),
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
          Text('Tespit Edilen Paternler', style: Theme.of(context).textTheme.labelSmall),
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
                'Önerilen Eylem',
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
              Text('Detaylı Analiz', style: Theme.of(context).textTheme.labelSmall),
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
                Text('Güvenli Yanıt Örneği', style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 12),
                Text(
                  result.safeReplyExample!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontFamily: 'Literata', fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 16),
                StillSecondaryButton(
                  label: 'KOPYALA',
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
        const StillSectionHeader(title: 'İçsel Onaylama'),
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
          label: 'YENİ ANALİZ',
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
    switch (level) {
      case RiskLevel.high: return 'Yüksek';
      case RiskLevel.medium: return 'Orta';
      case RiskLevel.low: return 'Düşük';
    }
  }

  String _getRiskDescription(RiskLevel level) {
    switch (level) {
      case RiskLevel.high: return 'Duygusal güvenliğin için yanıt vermemek en iyisidir.';
      case RiskLevel.medium: return 'İletişim döngüsünü yeniden açma riski taşır.';
      case RiskLevel.low: return 'Bu mesaj düşük duygusal risk içeriyor gibi görünüyor.';
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
    switch (action) {
      case RecommendedAction.doNotReply: return 'Cevap Verme';
      case RecommendedAction.wait: return 'Bekle';
      case RecommendedAction.replyWithBoundary: return 'Sınır Koy';
      case RecommendedAction.useSos: return 'SOS Kullan';
      case RecommendedAction.writeUnsentLetter: return 'Mektup Yaz';
    }
  }
}
