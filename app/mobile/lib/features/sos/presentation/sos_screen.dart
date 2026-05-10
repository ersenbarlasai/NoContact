import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../onboarding/presentation/onboarding_controller.dart';
import 'sos_controller.dart';

class SosScreen extends ConsumerStatefulWidget {
  const SosScreen({super.key});

  @override
  ConsumerState<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends ConsumerState<SosScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sosControllerProvider.notifier).startSession();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.onSurfaceVariant),
                    onPressed: () => context.go('/'),
                  ),
                  Text(
                    'STILL',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          letterSpacing: 4,
                          color: AppColors.primary,
                        ),
                  ),
                  const SizedBox(width: 48), // Balance for leading icon
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: StillProgressIndicator(
                currentStep: _currentPage,
                totalSteps: 4,
              ),
            ),
            
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  _StepBreathe(onNext: _nextPage),
                  _StepRemember(onNext: _nextPage),
                  _StepWrite(onNext: _nextPage),
                  _StepChoose(onComplete: () async {
                    final router = GoRouter.of(context);
                    await ref.read(sosControllerProvider.notifier).finishSession();
                    if (mounted) router.go('/');
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Step 1: Breathe ---
class _StepBreathe extends StatefulWidget {
  final VoidCallback onNext;
  const _StepBreathe({required this.onNext});

  @override
  State<_StepBreathe> createState() => _StepBreatheState();
}

class _StepBreatheState extends State<_StepBreathe> with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  
  String _breathLabel = "Nefes Al";
  int _secondsLeft = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _breathLabel = "Nefes Ver");
          _breathingController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          setState(() => _breathLabel = "Nefes Al");
          _breathingController.forward();
        }
      });

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.4, end: 0.8).animate(
      CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut),
    );

    _breathingController.forward();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        if (mounted) setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        StillSectionHeader(
          title: 'Adım 1: Nefes',
          subtitle: 'Bu an geçecek. Sadece aşağıdaki harekete odaklan.',
          centered: true,
        ),
        const Spacer(),
        
        // Breathing Component
        AnimatedBuilder(
          animation: _breathingController,
          builder: (context, child) {
            return SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer soft glow
                  Container(
                    width: 280 * _scaleAnimation.value,
                    height: 280 * _scaleAnimation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withOpacity(0.05 * _opacityAnimation.value),
                    ),
                  ),
                  // Medium shell
                  Container(
                    width: 220 * _scaleAnimation.value,
                    height: 220 * _scaleAnimation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  // Main breathing element
                  Container(
                    width: 160 * _scaleAnimation.value,
                    height: 160 * _scaleAnimation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryFixed,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.1),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _breathLabel,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: AppColors.primary,
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        
        const SizedBox(height: 48),
        Text(
          'Huzuru solun, dürtüyü serbest bırakın.',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.primary,
                fontSize: 20,
              ),
        ),
        
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: StillPrimaryButton(
            label: 'DAHA SAKİN HİSSEDİYORUM',
            onPressed: _secondsLeft < 58 ? widget.onNext : null,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Kalan süre: $_secondsLeft saniye',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// --- Step 2: Remember ---
class _StepRemember extends ConsumerWidget {
  final VoidCallback onNext;
  const _StepRemember({required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(onboardingControllerProvider);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StillSectionHeader(
            title: 'Neden buradasın?',
            subtitle: 'Healing doğrusal değildir, ancak bilinçli seçimlerle ilerler.',
          ),
          const SizedBox(height: 32),
          StillCard(
            color: AppColors.tertiaryFixed.withOpacity(0.3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.favorite, color: AppColors.tertiary),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hatırla, ${profile.name}',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Şu an ${profile.dominantEmotion.toLowerCase()} hissediyorsun çünkü "${profile.reason}" seni buraya getirdi.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const StillSectionHeader(title: 'Kendine verdiğin sözler'),
          const SizedBox(height: 16),
          _buildCommitmentItem(
            context, 
            'Dürtü anında SOS’u açmak.',
            'Dürtüyle hareket etmeden önce kendime 10 dakika nefes alanı tanıyacağım.',
            Icons.emergency,
            AppColors.primary,
          ),
          _buildCommitmentItem(
            context, 
            'Sessizliği iyileşme için kullanmak.',
            'Sessizliğim karşı taraftan tepki almak için değil, kendi iyileşmem içindir.',
            Icons.visibility_off,
            AppColors.tertiary,
          ),
          const SizedBox(height: 32),
          StillPrimaryButton(
            label: 'DEVAM ET',
            onPressed: onNext,
          ),
        ],
      ),
    );
  }

  Widget _buildCommitmentItem(BuildContext context, String title, String subtitle, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: StillCard(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 4),
                  Text(
                    subtitle, 
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Step 3: Write Here Instead ---
class _StepWrite extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  const _StepWrite({required this.onNext});

  @override
  ConsumerState<_StepWrite> createState() => _StepWriteState();
}

class _StepWriteState extends ConsumerState<_StepWrite> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          StillSectionHeader(
            title: 'Buraya Yaz, Ona Değil',
            subtitle: 'Düşüncelerini bu sayfaya dök. Kelimelerin ağırlığı zihninden çıksın ve burada kalsın.',
            centered: true,
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Stack(
              children: [
                StillCard(
                  padding: const EdgeInsets.all(24),
                  color: AppColors.surfaceContainerLowest,
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    expands: true,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
                    decoration: InputDecoration(
                      hintText: 'Ona ne söylemek istiyorsan buraya yaz, asla duyulmayacak olsa bile...',
                      hintStyle: TextStyle(color: AppColors.outline.withOpacity(0.5), fontStyle: FontStyle.italic),
                      border: InputBorder.none,
                      fillColor: Colors.transparent,
                    ),
                    onChanged: (val) => ref.read(sosControllerProvider.notifier).updateUrgeText(val),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.lock_outline, size: 14, color: AppColors.onSurfaceVariant),
                      const SizedBox(width: 8),
                      Text(
                        'Bu mesaj asla gönderilmeyecek.',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: AppColors.onSurfaceVariant.withOpacity(0.6),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          StillPrimaryButton(
            label: 'Mesajı Serbest Bırak',
            icon: Icons.auto_awesome,
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                widget.onNext();
              }
            },
          ),
          const SizedBox(height: 16),
          // Small pulse
          const Icon(Icons.air, color: AppColors.tertiary, size: 24),
        ],
      ),
    );
  }
}

// --- Step 4: Choose Yourself ---
class _StepChoose extends ConsumerStatefulWidget {
  final VoidCallback onComplete;
  const _StepChoose({required this.onComplete});

  @override
  ConsumerState<_StepChoose> createState() => _StepChooseState();
}

class _StepChooseState extends ConsumerState<_StepChoose> {
  bool _stillStruggling = false;
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    if (_completed) return _buildCompletionState();
    if (_stillStruggling) return _buildExtraGroundingState();

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withOpacity(0.05),
            ),
            child: const Icon(Icons.shield_outlined, size: 64, color: AppColors.primary),
          ),
          const SizedBox(height: 48),
          StillSectionHeader(
            title: 'Son Bir Adım',
            subtitle: 'Şu an temas etmeme kararını koruyor musun?',
            centered: true,
          ),
          const Spacer(),
          StillPrimaryButton(
            label: 'EVET, KENDİMİ SEÇİYORUM',
            onPressed: () {
              ref.read(sosControllerProvider.notifier).setOutcome('maintained_nc');
              setState(() => _completed = true);
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              ref.read(sosControllerProvider.notifier).setOutcome('still_struggling');
              setState(() => _stillStruggling = true);
            },
            child: Text(
              'HÂLÂ ÇOK ZORLANIYORUM',
              style: TextStyle(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildCompletionState() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.spa, size: 80, color: AppColors.primary),
          const SizedBox(height: 48),
          StillSectionHeader(
            title: 'Bu dalgayı atlattın.',
            subtitle: 'Bugün kendini seçtin. Gurur duyulacak bir şey yaptın.',
            centered: true,
          ),
          const Spacer(),
          StillPrimaryButton(
            label: 'HUZURLA DÖN',
            onPressed: widget.onComplete,
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildExtraGroundingState() {
    final actions = [
      {'title': 'Bir bardak su iç', 'icon': Icons.water_drop},
      {'title': 'Telefonu 10 dk başka odaya bırak', 'icon': Icons.phonelink_erase},
      {'title': 'Temiz hava al', 'icon': Icons.air},
    ];

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StillSectionHeader(
            title: 'Yanındayız.',
            subtitle: 'Zorlanman çok normal. Şu an bunlardan birini dene:',
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              children: actions.map((a) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: StillOptionTile(
                  title: a['title'] as String,
                  icon: a['icon'] as IconData,
                  isSelected: false,
                  onTap: () => ref.read(sosControllerProvider.notifier).toggleGroundingAction(a['title'] as String),
                ),
              )).toList(),
            ),
          ),
          const SizedBox(height: 24),
          StillCard(
            color: AppColors.errorContainer.withOpacity(0.1),
            child: Text(
              'Kendine zarar verme düşüncen varsa hemen yerel acil destek hattına ulaş.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.error, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          StillPrimaryButton(
            label: 'BİRAZ DAHA İYİYİM',
            onPressed: widget.onComplete,
          ),
        ],
      ),
    );
  }
}
