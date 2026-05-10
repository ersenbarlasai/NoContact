import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Transition types for the Still design system.
enum StillTransitionType {
  /// Simple cross-fade.
  fade,
  
  /// Soft fade with a tiny bit of upward movement.
  fadeThrough,
  
  /// Shared axis vertical transition (more pronounced upward movement).
  sharedAxisVertical,
  
  /// No transition (used for instant access or accessibility).
  none,
}

/// A [CustomTransitionPage] that implements the Still design philosophy:
/// low-arousal, soft, and grounded.
class StillPageTransition extends CustomTransitionPage<void> {
  StillPageTransition({
    required super.child,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    StillTransitionType type = StillTransitionType.fadeThrough,
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Respect system-level reduced motion settings.
            if (MediaQuery.of(context).disableAnimations) {
              return child;
            }

            switch (type) {
              case StillTransitionType.fade:
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeOutCubic).animate(animation),
                  child: child,
                );
                
              case StillTransitionType.fadeThrough:
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeOutCubic).animate(animation),
                  child: SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                        begin: const Offset(0, 0.01),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeOutCubic)),
                    ),
                    child: child,
                  ),
                );
                
              case StillTransitionType.sharedAxisVertical:
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeOutCubic).animate(animation),
                  child: SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                        begin: const Offset(0, 0.05),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeOutCubic)),
                    ),
                    child: child,
                  ),
                );
                
              case StillTransitionType.none:
                return child;
            }
          },
          transitionDuration: duration,
          reverseTransitionDuration: duration,
        );
}
