import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccuracyAnimatedText extends StatefulWidget {
  final double? accuracy;

  const AccuracyAnimatedText({super.key, required this.accuracy});

  @override
  State<AccuracyAnimatedText> createState() => _AccuracyAnimatedTextState();
}

class _AccuracyAnimatedTextState extends State<AccuracyAnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  late Animation<double> _positionAnimation;
  String displayText = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _sizeAnimation = Tween<double>(begin: 20.0, end: 50.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _positionAnimation = Tween<double>(begin: 0.0, end: -50.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant AccuracyAnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.accuracy != null && oldWidget.accuracy == null) {
      _setDisplayTextAndAnimate();
    }
  }

  void _setDisplayTextAndAnimate() {
    setState(() {
      if (widget.accuracy! >= 90) {
        displayText = 'EXCELLENT';
      } else if (widget.accuracy! >= 75) {
        displayText = 'VERY GOOD';
      } else if (widget.accuracy! >= 50) {
        displayText = 'GOOD';
      } else {
        displayText = 'NOT EVEN CLOSE';
      }
      _animationController.forward();
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _animationController.reset();
          displayText = '';
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.accuracy != null
      ? AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => Transform.translate(
            offset: Offset(0, _positionAnimation.value),
            child: Text(
              displayText,
              style: GoogleFonts.knewave(
                fontSize: _sizeAnimation.value,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        )
      : const SizedBox.shrink();
}
