import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lg_flutter_hackathon/battle/presentation/widgets/overlay_widget.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';

class BattleEndAnimation extends StatelessWidget {
  const BattleEndAnimation({
    super.key,
    this.isGameOver = false,
  });

  final bool isGameOver;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return OverlayWidget(
      child: CurtainAnimation(
        leftTreeAsset: ImageAssets.leftTrees,
        rightTreeAsset: ImageAssets.rightTrees,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        isGameOver: isGameOver,
      ),
    );
  }
}

class CurtainAnimation extends StatefulWidget {
  const CurtainAnimation({
    super.key,
    required this.leftTreeAsset,
    required this.rightTreeAsset,
    required this.screenWidth,
    required this.screenHeight,
    required this.isGameOver,
  });

  final String leftTreeAsset;
  final String rightTreeAsset;
  final double screenWidth;
  final double screenHeight;
  final bool isGameOver;

  @override
  State createState() => _CurtainAnimationState();
}

class _CurtainAnimationState extends State<CurtainAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _leftTreeAnimation, _rightTreeAnimation;
  static const _duration = Duration(seconds: 1);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000), // Adjust duration as needed
      vsync: this,
    );

    _leftTreeAnimation = Tween<Offset>(
      begin: Offset(-widget.screenWidth, 0),
      end: Offset(-widget.screenWidth * 1 / 3, 0),
    ).animate(_animationController);

    _rightTreeAnimation = Tween<Offset>(
      begin: Offset(widget.screenWidth, 0),
      end: Offset(widget.screenWidth * 1 / 3, 0),
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: _duration,
          curve: Curves.easeInOut,
          left: _leftTreeAnimation.value.dx,
          top: _leftTreeAnimation.value.dy,
          child: SvgPicture.asset(
            widget.leftTreeAsset,
            width: widget.screenWidth / 2,
            height: widget.screenHeight,
            fit: BoxFit.cover,
          ),
        ),
        AnimatedPositioned(
          duration: _duration,
          curve: Curves.easeInOut,
          left: _rightTreeAnimation.value.dx,
          top: _rightTreeAnimation.value.dy,
          child: SvgPicture.asset(
            widget.rightTreeAsset,
            width: widget.screenWidth / 2,
            height: widget.screenHeight,
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Text(
            widget.isGameOver ? 'Game Over' : 'Monster defeated',
            style: TextStyle(
              fontFamily: DesignConsts.fontFamily,
              color: Colors.white,
              fontSize: widget.screenWidth / 40,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
