import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';

class RoundWidget extends StatefulWidget {
  const RoundWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<RoundWidget> createState() => _RoundWidgetState();
}

class _RoundWidgetState extends State<RoundWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool _displayRound = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(_animationController);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _animationController.forward();
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          setState(() {
            _displayRound = false;
          });
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
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Stack(
      alignment: Alignment.center,
      children: [
        widget.child,
        if (_displayRound) ...[
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(.5),
          ),
          // const OverlayWidget(),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SvgPicture.asset(
                    ImageAssets.okButton,
                    width: screenWidth / 2,
                    height: screenHeight / 4,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}
