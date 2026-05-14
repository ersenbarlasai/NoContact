import 'package:flutter/material.dart';
import 'emotional_tokens.dart';

enum EmotionalVariant {
  home,
  onboarding,
  sos,
  mood,
  support,
  recovery,
  neutral,
}

class EmotionalBackground extends StatelessWidget {
  final EmotionalVariant variant;
  final Widget? child;
  final bool useTimeOfDay;

  const EmotionalBackground({
    super.key,
    required this.variant,
    this.child,
    this.useTimeOfDay = false,
  });

  String? _getAssetPath(BuildContext context, EmotionalVariant variant) {
    if (variant == EmotionalVariant.home && useTimeOfDay) {
      final hour = DateTime.now().hour;
      if (hour >= 6 && hour < 11) return 'assets/backgrounds/home_morning_mist.png';
      if (hour >= 11 && hour < 17) return 'assets/backgrounds/home_soft_daylight.png';
      if (hour >= 17 && hour < 21) return 'assets/backgrounds/home_evening_sand.png';
      return 'assets/backgrounds/home_night_shelter.png';
    }

    switch (variant) {
      case EmotionalVariant.onboarding:
        return 'assets/backgrounds/onboarding_dawn.png';
      case EmotionalVariant.sos:
        return 'assets/backgrounds/sos_shelter_light.png';
      case EmotionalVariant.home:
        return 'assets/backgrounds/home_morning_mist.png';
      case EmotionalVariant.mood:
      case EmotionalVariant.support:
        return 'assets/backgrounds/journal_aura.png';
      case EmotionalVariant.recovery:
        return 'assets/backgrounds/recovery_horizon.png';
      case EmotionalVariant.neutral:
        return null;
    }
  }

  double _getImageOpacity(EmotionalVariant variant) {
    if (variant == EmotionalVariant.home && useTimeOfDay) {
      final hour = DateTime.now().hour;
      // Night shelter image might need different opacity
      if (hour >= 21 || hour < 6) return 0.72;
      return 0.84;
    }

    switch (variant) {
      case EmotionalVariant.onboarding:
        return 0.82;
      case EmotionalVariant.sos:
        return 0.84;
      case EmotionalVariant.home:
        return 0.84;
      case EmotionalVariant.mood:
        return 0.72;
      case EmotionalVariant.recovery:
        return 0.76;
      case EmotionalVariant.support:
        return 0.78;
      case EmotionalVariant.neutral:
        return 0.0;
    }
  }

  Color _getScrimColor(EmotionalVariant variant) {
    if (variant == EmotionalVariant.home && useTimeOfDay) {
      final hour = DateTime.now().hour;
      // Night home might need a slightly stronger scrim for readability on darker images
      if (hour >= 21 || hour < 6) return Colors.white.withValues(alpha: 0.22);
      return Colors.white.withValues(alpha: 0.10);
    }

    switch (variant) {
      case EmotionalVariant.onboarding:
        return Colors.white.withValues(alpha: 0.18);
      case EmotionalVariant.sos:
        return Colors.white.withValues(alpha: 0.12);
      case EmotionalVariant.home:
        return Colors.white.withValues(alpha: 0.10);
      case EmotionalVariant.mood:
        return Colors.white.withValues(alpha: 0.28);
      case EmotionalVariant.recovery:
        return Colors.white.withValues(alpha: 0.24);
      case EmotionalVariant.support:
        return Colors.white.withValues(alpha: 0.24);
      case EmotionalVariant.neutral:
        return Colors.transparent;
    }
  }

  List<Color> _getColors() {
    if (variant == EmotionalVariant.home && useTimeOfDay) {
      final hour = DateTime.now().hour;
      if (hour >= 6 && hour < 11) return EmotionalGradients.homeMorning;
      if (hour >= 11 && hour < 17) return EmotionalGradients.homeDaylight;
      if (hour >= 17 && hour < 21) return EmotionalGradients.homeEvening;
      return EmotionalGradients.homeNight;
    }

    switch (variant) {
      case EmotionalVariant.home:
        return EmotionalGradients.homeMist;
      case EmotionalVariant.onboarding:
        return EmotionalGradients.onboardingDawn;
      case EmotionalVariant.sos:
        return EmotionalGradients.sosShelter;
      case EmotionalVariant.mood:
        return EmotionalGradients.moodAura;
      case EmotionalVariant.support:
        return EmotionalGradients.supportWarmth;
      case EmotionalVariant.recovery:
        return EmotionalGradients.recoveryHorizon;
      case EmotionalVariant.neutral:
        return [
          const Color(0xFFF9F9FA),
          const Color(0xFFF6F5F2),
          const Color(0xFFF3F3F4),
        ];
    }
  }

  List<double>? _getStops(List<Color> colors) {
    if (colors.length == 3) return const [0.0, 0.5, 1.0];
    if (colors.length == 2) return const [0.0, 1.0];
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();
    final stops = _getStops(colors);
    final assetPath = _getAssetPath(context, variant);
    final isReducedMotion = MediaQuery.of(context).accessibleNavigation;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
          stops: stops,
        ),
      ),
      child: Stack(
        children: [
          // Background Image with Fallback handling
          if (assetPath != null)
            Positioned.fill(
              child: Image.asset(
                assetPath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                opacity: AlwaysStoppedAnimation(_getImageOpacity(variant)),
              ),
            ),
          
          // Readable Scrim Overlay
          Positioned.fill(
            child: Container(
              color: _getScrimColor(variant),
            ),
          ),

          // Subtle atmospheric shapes (legacy fallback for motion)
          if (assetPath == null && !isReducedMotion)
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      colors[0].withValues(alpha: 0.3),
                      colors[0].withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
