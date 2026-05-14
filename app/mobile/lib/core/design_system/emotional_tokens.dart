import 'package:flutter/material.dart';
import '../../app/theme/app_theme.dart';

class EmotionalGradients {
  static const List<Color> homeMist = [
    Color(0xFFF3F5F2), // Lightest Sage
    Color(0xFFE8ECE7), // Misty Sage
    Color(0xFFF9F9FA), // Surface Cream
  ];

  static const List<Color> homeMorning = [
    Color(0xFFF3F5F2), // Lightest Sage
    Color(0xFFFFF9F0), // Soft Dawn Sand
    Color(0xFFFDF2E4), // Warm Cream
  ];

  static const List<Color> homeDaylight = [
    Color(0xFFE3F2FD), // Very Light Blue
    Color(0xFFF1F8E9), // Very Light Sage
    Color(0xFFF9F9FA), // Background
  ];

  static const List<Color> homeEvening = [
    Color(0xFFFDF2E4), // Warm Cream
    Color(0xFFFFECB3), // Muted Gold/Amber
    Color(0xFFEFEBE9), // Sand
  ];

  static const List<Color> homeNight = [
    Color(0xFFE8ECE7), // Misty Sage
    Color(0xFFCFD8DC), // Cool Grey
    Color(0xFFF9F9FA), // Surface Cream
  ];

  static const List<Color> onboardingDawn = [
    Color(0xFFFFF9F0), // Soft Dawn Sand
    Color(0xFFFDF2E4), // Warm Cream
    Color(0xFFF9F9FA), // Background
  ];

  static const List<Color> sosShelter = [
    Color(0xFF2C3E2B), // Lighter Deep Sage
    Color(0xFFE8ECE7), // Misty Sage
    Color(0xFFF9F9FA), // Background
  ];

  static const List<Color> sosShelterDark = [
    Color(0xFF1A1C1D), // Charcoal
    Color(0xFF242A22), // Deep Sage
    Color(0xFF101E0F), // OnPrimaryFixed (Darkest Sage)
  ];

  static const List<Color> moodAura = [
    Color(0xFFE8ECE7), // Sage
    Color(0xFFF3F3F4), // Surface Container Low
    Color(0xFFFFF9F0), // Sand
  ];

  static const List<Color> supportWarmth = [
    Color(0xFFFDF2E4), // Warm Cream
    Color(0xFFFFF9F0), // Sand
    Color(0xFFF9F9FA), // Surface
  ];

  static const List<Color> recoveryHorizon = [
    Color(0xFFDADADB), // Surface Dim
    Color(0xFFEEEEEF), // Surface Container
    Color(0xFFF9F9FA), // Background
  ];
}

class EmotionalTokens {
  // Tactile Interaction
  static const double pressedScale = 0.98;
  static const Duration tactileDuration = Duration(milliseconds: 150);
  static const Curve tactileCurve = Curves.easeInOut;

  // Surface Overlays
  static const double surfaceOpacity = 0.15;
  static const double surfaceBlur = 12.0;

  // Shadows
  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: AppColors.onSurface.withValues(alpha: 0.04),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> innerGlow = [
    BoxShadow(
      color: Colors.white.withValues(alpha: 0.5),
      blurRadius: 8,
      spreadRadius: -4,
      offset: const Offset(0, 2),
    ),
  ];
}
