import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lg_flutter_hackathon/constants/strings.dart';

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

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          displayText = '';
        });
        _animationController.reset();
      }
    });
  }

  @override
  void didUpdateWidget(covariant AccuracyAnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.accuracy != null) {
      _setDisplayTextAndAnimate();
    }
  }

  void _setDisplayTextAndAnimate() {
    setState(() {
      if (widget.accuracy! >= 90) {
        displayText = Strings.commonExcellent;
      } else if (widget.accuracy! >= 75) {
        displayText = Strings.commonVeryGood;
      } else if (widget.accuracy! >= 50) {
        displayText = Strings.commonGood;
      } else {
        displayText = Strings.commonNotEvenClose;
      }
      _animationController.forward();
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
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _positionAnimation.value),
              child: Text(
                displayText,
                style: GoogleFonts.knewave(
                  fontSize: _sizeAnimation.value,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          },
        )
      : const SizedBox.shrink();
}
