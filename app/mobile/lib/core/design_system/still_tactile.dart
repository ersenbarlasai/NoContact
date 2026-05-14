import 'package:flutter/material.dart';
import 'emotional_tokens.dart';

class StillTactilePress extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool enableScale;

  const StillTactilePress({
    super.key,
    required this.child,
    this.onTap,
    this.enableScale = true,
  });

  @override
  State<StillTactilePress> createState() => _StillTactilePressState();
}

class _StillTactilePressState extends State<StillTactilePress> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: EmotionalTokens.tactileDuration,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: EmotionalTokens.pressedScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: EmotionalTokens.tactileCurve,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null && widget.enableScale) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap != null && widget.enableScale) {
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onTap != null && widget.enableScale) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
