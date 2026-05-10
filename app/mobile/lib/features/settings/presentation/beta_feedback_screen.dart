import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../../data/models/beta_feedback.dart';
import 'beta_feedback_controller.dart';

class BetaFeedbackScreen extends ConsumerStatefulWidget {
  const BetaFeedbackScreen({super.key});

  @override
  ConsumerState<BetaFeedbackScreen> createState() => _BetaFeedbackScreenState();
}

class _BetaFeedbackScreenState extends ConsumerState<BetaFeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  
  double _rating = 0;
  final _firstImpressionCtrl = TextEditingController();
  final _onboardingCtrl = TextEditingController();
  final _sosCtrl = TextEditingController();
  final _moodJournalCtrl = TextEditingController();
  final _lettersVaultCtrl = TextEditingController();
  final _messageAnalysisCtrl = TextEditingController();
  final _aiValueCtrl = TextEditingController();
  final _paymentCtrl = TextEditingController();
  final _safetyCtrl = TextEditingController();
  final _valuableFeatureCtrl = TextEditingController();
  final _missingFeatureCtrl = TextEditingController();
  final _extraNotesCtrl = TextEditingController();

  @override
  void dispose() {
    _firstImpressionCtrl.dispose();
    _onboardingCtrl.dispose();
    _sosCtrl.dispose();
    _moodJournalCtrl.dispose();
    _lettersVaultCtrl.dispose();
    _messageAnalysisCtrl.dispose();
    _aiValueCtrl.dispose();
    _paymentCtrl.dispose();
    _safetyCtrl.dispose();
    _valuableFeatureCtrl.dispose();
    _missingFeatureCtrl.dispose();
    _extraNotesCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    
    final feedback = BetaFeedback(
      overallRating: _rating > 0 ? _rating.toInt() : null,
      firstImpression: _firstImpressionCtrl.text,
      onboardingFeedback: _onboardingCtrl.text,
      sosFeedback: _sosCtrl.text,
      moodJournalFeedback: _moodJournalCtrl.text,
      lettersVaultFeedback: _lettersVaultCtrl.text,
      messageAnalysisFeedback: _messageAnalysisCtrl.text,
      aiValueFeedback: _aiValueCtrl.text,
      paymentFeedback: _paymentCtrl.text,
      safetyOrDiscomfort: _safetyCtrl.text,
      mostValuableFeature: _valuableFeatureCtrl.text,
      missingFeature: _missingFeatureCtrl.text,
      extraNotes: _extraNotesCtrl.text,
    );
    
    ref.read(betaFeedbackControllerProvider.notifier).submit(feedback);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(betaFeedbackControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () {
            ref.read(betaFeedbackControllerProvider.notifier).reset();
            context.pop();
          },
        ),
        title: Text(
          'BETA GERİ BİLDİRİMİ',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 2,
                color: AppColors.primary,
              ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: state.isSuccess
            ? _buildSuccess(context)
            : _buildForm(context, state),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, size: 64, color: AppColors.primary),
            const SizedBox(height: 24),
            Text(
              'Geri bildirimin alındı.',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            Text(
              'Still’i daha iyi hale getirmemize yardım ettin. Teşekkür ederiz.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 48),
            StillSecondaryButton(
              label: 'GERİ DÖN',
              onPressed: () {
                ref.read(betaFeedbackControllerProvider.notifier).reset();
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, BetaFeedbackState state) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.tertiaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.tertiary.withValues(alpha: 0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.privacy_tip_outlined, color: AppColors.tertiary, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Lütfen bu forma gerçek isim, telefon numarası, eski partner bilgisi, özel mesaj içerikleri veya çok hassas kişisel bilgiler yazma. Bu form yalnızca ürün geliştirme geri bildirimi içindir.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.tertiary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          
          Text(
            'Genel Puanın',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          Slider(
            value: _rating,
            min: 0,
            max: 5,
            divisions: 5,
            activeColor: AppColors.primary,
            label: _rating > 0 ? _rating.toInt().toString() : 'Seçilmedi',
            onChanged: (val) {
              setState(() {
                _rating = val;
              });
            },
          ),
          
          _buildField('İlk ekran sana ne hissettirdi?', _firstImpressionCtrl),
          _buildField('Onboarding (giriş süreci) nasıldı?', _onboardingCtrl),
          _buildField('SOS modu zor bir anda işe yarar gibi hissettirdi mi?', _sosCtrl),
          _buildField('Günlük ve mektup kasası sana güvenli geldi mi?', _moodJournalCtrl), // Merging some questions for simplicity
          _buildField('Mesaj analizi faydalı mıydı?', _messageAnalysisCtrl),
          _buildField('Mesaj analizi gerçek AI ile çalışsa daha değerli olur muydu?', _aiValueCtrl),
          _buildField('Seni rahatsız eden, güvensiz hissettiren bir şey oldu mu?', _safetyCtrl),
          _buildField('En eksik bulduğun özellik nedir?', _missingFeatureCtrl),
          _buildField('Eklemek istediğin başka notlar?', _extraNotesCtrl),

          if (state.error != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Şu anda geri bildirim gönderilemedi. Daha sonra tekrar deneyebilirsin.',
                style: const TextStyle(color: AppColors.error),
                textAlign: TextAlign.center,
              ),
            ),

          const SizedBox(height: 32),
          state.isLoading
              ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
              : StillPrimaryButton(
                  label: 'GÖNDER',
                  onPressed: _submit,
                ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: 3,
            minLines: 1,
            decoration: InputDecoration(
              hintText: 'Yanıtınız...',
              hintStyle: TextStyle(color: AppColors.onSurfaceVariant.withValues(alpha: 0.5)),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.outlineVariant),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.outlineVariant),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
