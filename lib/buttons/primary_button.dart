import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lg_flutter_hackathon/audio/audio_controller.dart';
import 'package:lg_flutter_hackathon/audio/sounds.dart';
import 'package:provider/provider.dart';

class PrimaryButton extends StatefulWidget {
  final Widget child;

  final VoidCallback? onPressed;

  final SfxType? sfxType;

  const PrimaryButton({super.key, required this.child, this.onPressed, this.sfxType});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioController>();

    return MouseRegion(
      onEnter: (event) {
        _controller.repeat();
      },
      onExit: (event) {
        _controller.stop(canceled: false);
      },
      child: RotationTransition(
        turns: _controller.drive(const _MySineTween(0.005)),
        child: FilledButton(
          onPressed: () {
            audioController.playSfx(widget.sfxType ?? SfxType.buttonTap);
            if (widget.onPressed != null) {
              widget.onPressed!();
            }
          },
          child: widget.child,
        ),
      ),
    );
  }
}

class _MySineTween extends Animatable<double> {
  final double maxExtent;

  const _MySineTween(this.maxExtent);

  @override
  double transform(double t) {
    return sin(t * 2 * pi) * maxExtent;
  }
}
