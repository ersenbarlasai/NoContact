import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../../features/milestones/presentation/milestone_overlay.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.background,
          body: child,
          // The SOS button is now a separate floating element to match the Stitch design
          floatingActionButton: location != '/onboarding' && location != '/sos' 
              ? const _SosPulseButton() 
              : null,
          bottomNavigationBar: _BottomNavBar(location: location),
        ),
        const MilestoneOverlay(),
      ],
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final String location;
  const _BottomNavBar({required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow.withOpacity(0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 40,
            offset: const Offset(0, -20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_max,
                  label: 'Ana Sayfa',
                  isActive: location == '/',
                  onTap: () => context.go('/'),
                ),
                _NavItem(
                  icon: Icons.edit_note,
                  label: 'Günlük',
                  isActive: location == '/mood-journal',
                  onTap: () => context.go('/mood-journal'),
                ),
                _NavItem(
                  icon: Icons.history_edu,
                  label: 'Kasa',
                  isActive: location.startsWith('/letters-vault'),
                  onTap: () => context.go('/letters-vault'),
                ),
                _NavItem(
                  icon: Icons.settings,
                  label: 'Ayarlar',
                  isActive: location == '/settings',
                  onTap: () => context.go('/settings'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isActive ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant,
                    fontSize: 10,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SosPulseButton extends StatefulWidget {
  const _SosPulseButton();

  @override
  State<_SosPulseButton> createState() => _SosPulseButtonState();
}

class _SosPulseButtonState extends State<_SosPulseButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, right: 8),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.tertiary.withOpacity(0.3 * _controller.value),
                  blurRadius: 15 * _controller.value,
                  spreadRadius: 2 * _controller.value,
                ),
              ],
            ),
            child: FloatingActionButton(
              onPressed: () => context.push('/sos'),
              backgroundColor: AppColors.tertiary,
              foregroundColor: AppColors.onTertiary,
              elevation: 4,
              shape: const CircleBorder(),
              child: const Icon(Icons.air, size: 28),
            ),
          );
        },
      ),
    );
  }
}
