import 'package:flutter/material.dart';
import 'package:lg_flutter_hackathon/audio/audio_controller.dart';
import 'package:lg_flutter_hackathon/audio/sounds.dart';
import 'package:provider/provider.dart';

class PushableButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double scale;
  final Duration duration;
  final SfxType? sfxType;

  const PushableButton({
    required this.child,
    this.onPressed,
    this.scale = 0.95,
    this.duration = const Duration(milliseconds: 100),
    this.sfxType,
    super.key,
  });

  @override
  State<PushableButton> createState() => _PushableButtonState();
}

class _PushableButtonState extends State<PushableButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioController>();

    return GestureDetector(
      onTapDown: (_) {
        if (widget.onPressed != null) {
          setState(() => _isPressed = true);
          audioController.playSfx(widget.sfxType ?? SfxType.buttonTap);
        }
      },
      onTapUp: (_) {
        if (widget.onPressed != null) {
          widget.onPressed!();
          setState(() => _isPressed = false);
        }
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? widget.scale : 1.0,
        duration: widget.duration,
        child: widget.child,
      ),
    );
  }
}
