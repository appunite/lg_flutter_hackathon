import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';

class PulsatingArrow extends StatefulWidget {
  final int currentPlayerIndex;
  final int numberOfPlayers;

  const PulsatingArrow({
    super.key,
    required this.currentPlayerIndex,
    required this.numberOfPlayers,
  });

  @override
  State<PulsatingArrow> createState() => _PulsatingArrowState();
}

class _PulsatingArrowState extends State<PulsatingArrow> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _positionAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Positioned(
      bottom: _getPositionBasedOnPlayer(screenHeight),
      left: screenWidth / 12 + _positionAnimation.value,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        transform: Matrix4.identity()..scale(_scaleAnimation.value),
        child: SvgPicture.asset(
          ImageAssets.arrow,
          height: screenWidth / 30,
          width: screenWidth / 26,
        ),
      ),
    );
  }

  double _getPositionBasedOnPlayer(double screenHeight) {
    final numOfPlayers = widget.numberOfPlayers;
    final currentPlayerIndex = widget.currentPlayerIndex;

    if (numOfPlayers == 2) {
      if (currentPlayerIndex == 0) {
        return screenHeight / 2.5;
      } else {
        return screenHeight / 6;
      }
    } else if (numOfPlayers == 3) {
      if (currentPlayerIndex == 0) {
        return screenHeight / 2;
      } else if (currentPlayerIndex == 1) {
        return screenHeight / 3;
      } else {
        return screenHeight / 6;
      }
    } else if (numOfPlayers == 4) {
      if (currentPlayerIndex == 0) {
        return screenHeight / 2;
      } else if (currentPlayerIndex == 1) {
        return screenHeight / 2.5;
      } else if (currentPlayerIndex == 2) {
        return screenHeight / 3.5;
      } else if (currentPlayerIndex == 3) {
        return screenHeight / 6;
      }
    }
    return screenHeight / 6;
  }
}
