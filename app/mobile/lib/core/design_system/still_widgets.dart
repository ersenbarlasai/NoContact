import 'dart:ui';
import 'package:flutter/material.dart';
import '../../app/theme/app_theme.dart';
import 'still_tactile.dart';

class StillCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final VoidCallback? onTap;
  final double borderRadius;
  final bool hasShadow;
  final bool useTactile;

  const StillCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.onTap,
    this.borderRadius = 20,
    this.hasShadow = false,
    this.useTactile = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: padding ?? const EdgeInsets.all(24.0),
      child: child,
    );

    Widget cardBody = Container(
      decoration: BoxDecoration(
        color: color ?? AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.surfaceContainer, width: 1),
        boxShadow: hasShadow ? [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ] : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: content,
      ),
    );

    if (onTap != null) {
      if (useTactile) {
        return StillTactilePress(
          onTap: onTap,
          child: cardBody,
        );
      }
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: cardBody,
      );
    }

    return cardBody;
  }
}

class StillGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double borderRadius;
  final double blur;
  final double opacity;

  const StillGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderRadius = 24,
    this.blur = 20.0,
    this.opacity = 0.78, // Slightly more opaque as requested (0.74-0.82)
  });

  @override
  Widget build(BuildContext context) {
    final cardContent = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding ?? const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFFCFBF8).withValues(alpha: opacity), // Warmer cream-tinted glass
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.7),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.06), // Sage-tinted shadow
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      return StillTactilePress(
        onTap: onTap,
        child: cardContent,
      );
    }

    return cardContent;
  }
}

class StillPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool useTactile;

  const StillPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.useTactile = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null && !isLoading;
    
    final buttonContent = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? () {} : null,
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          overlayColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 20),
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.15), // Soft sage instead of grey
          foregroundColor: AppColors.onPrimary,
          disabledForegroundColor: AppColors.primary.withValues(alpha: 0.4),
          shape: const StadiumBorder(),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label.toUpperCase(),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: isEnabled ? AppColors.onPrimary : AppColors.primary.withValues(alpha: 0.4),
                      letterSpacing: 1.2,
                    ),
                  ),
                  if (icon == null) const SizedBox(width: 8), // Visual balance
                  if (icon == null) const Icon(Icons.arrow_forward, size: 18),
                ],
              ),
      ),
    );

    if (useTactile && !isLoading && onPressed != null) {
      return StillTactilePress(
        onTap: onPressed,
        child: IgnorePointer(child: buttonContent),
      );
    }

    return buttonContent;
  }
}

class StillSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool useTactile;

  const StillSecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.useTactile = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;

    final buttonContent = SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          overlayColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 20),
          side: BorderSide(
            color: isEnabled ? AppColors.outlineVariant : AppColors.outlineVariant.withValues(alpha: 0.3),
          ),
          shape: const StadiumBorder(),
          foregroundColor: isEnabled ? AppColors.onSurfaceVariant : AppColors.onSurfaceVariant.withValues(alpha: 0.38),
        ),
        onPressed: isEnabled ? () {} : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              label.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isEnabled ? AppColors.onSurfaceVariant : AppColors.onSurfaceVariant.withValues(alpha: 0.38),
                    letterSpacing: 1.2,
                  ),
            ),
          ],
        ),
      ),
    );

    if (useTactile && onPressed != null) {
      return StillTactilePress(
        onTap: onPressed,
        child: IgnorePointer(child: buttonContent),
      );
    }

    return buttonContent;
  }
}

class StillTertiaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool useTactile;

  const StillTertiaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.useTactile = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;

    final buttonContent = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          overlayColor: Colors.transparent,
          backgroundColor: AppColors.tertiaryContainer,
          disabledBackgroundColor: AppColors.surfaceContainerHigh,
          foregroundColor: AppColors.onTertiaryContainer,
          disabledForegroundColor: AppColors.onSurfaceVariant.withValues(alpha: 0.38),
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: const StadiumBorder(),
          elevation: 0,
        ),
        onPressed: isEnabled ? () {} : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 24),
              const SizedBox(width: 12),
            ],
            Text(
              label.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isEnabled ? AppColors.onTertiaryContainer : AppColors.onSurfaceVariant.withValues(alpha: 0.38),
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );

    if (useTactile && onPressed != null) {
      return StillTactilePress(
        onTap: onPressed,
        child: IgnorePointer(child: buttonContent),
      );
    }

    return buttonContent;
  }
}

class StillPrivacyNotice extends StatelessWidget {
  final String text;
  const StillPrivacyNotice({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.security, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.primary,
                    fontSize: 12,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class StillSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool centered;

  const StillSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 2,
                fontSize: 12,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            textAlign: centered ? TextAlign.center : TextAlign.start,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.onSurface,
                ),
          ),
        ],
      ],
    );
  }
}

class StillProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StillProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isActive = index <= currentStep;
        return Expanded(
          child: Container(
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );
      }),
    );
  }
}

class StillMoodChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const StillMoodChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = isSelected ? AppColors.primary : AppColors.surfaceContainerLowest;
    final Color textColor = isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant;
    final Color borderColor = isSelected ? AppColors.primary : AppColors.outlineVariant;

    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(fullRadius),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: textColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  static const double fullRadius = 999;
}

class StillOptionTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const StillOptionTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: StillCard(
        onTap: onTap,
        color: isSelected ? AppColors.primary.withValues(alpha: 0.05) : AppColors.surfaceContainerLowest,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
                size: 20,
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primary, size: 24),
          ],
        ),
      ),
    );
  }
}

class StillTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isLarge;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final int? maxLength;

  const StillTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isLarge = false,
    this.onChanged,
    this.autofocus = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      autofocus: autofocus,
      maxLength: maxLength,
      maxLines: isLarge ? 5 : 1, // Changed from null to 5 for better UX in large state
      minLines: isLarge ? 3 : 1,
      textAlignVertical: TextAlignVertical.top,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontFamily: 'Literata',
        height: 1.6,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontFamily: 'Literata',
          color: AppColors.outline,
        ),
        filled: true,
        fillColor: AppColors.surfaceContainerLow.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        counterText: '', // Hide default counter if needed
      ),
    );
  }
}
