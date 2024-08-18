import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';
import 'package:lg_flutter_hackathon/constants/strings.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _tipFadeController;
  late Animation<double> _tipFadeAnimation;
  late Timer _timer;
  int _backgroundIndex = 0;
  int _tipIndex = 0;

  final List<String> _backgroundImages = [
    ImageAssets.boardBackground,
    ImageAssets.loaderBackground,
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();

    _tipFadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _tipFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _tipFadeController, curve: Curves.easeInOut),
    );

    _tipFadeController.forward();

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() {
        if (_tipIndex % 3 == 0) {
          _backgroundIndex = (_backgroundIndex + 1) % _backgroundImages.length;
        }
      });
    });

    _controller.addListener(() {
      if (_controller.value >= 0.5) {
        if (_controller.value >= 0.5 && _controller.value < 0.51) {
          _changeTip();
        }

        if (_controller.value >= 1.0) {
          _changeTip();
        }
      }
    });
  }

  void _changeTip() {
    _tipFadeController.reverse().then((_) {
      setState(() {
        _tipIndex = (_tipIndex + 1) % Strings.gameTips.length;
      });
      _tipFadeController.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _tipFadeController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    final double loaderSize = screenWidth / 30;
    final double containerWidth = loaderSize * 10 + 48;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: SvgPicture.asset(
              _backgroundImages[_backgroundIndex],
              fit: BoxFit.cover,
              key: ValueKey<int>(_backgroundIndex),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Strings.loading,
                style: TextStyle(
                  fontFamily: 'Knewave',
                  fontSize: screenWidth / 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: containerWidth,
                height: screenHeight / 5,
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.loaderContainer,
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      top: screenHeight / 14,
                      left: screenWidth / 18,
                      child: Row(
                        children: [
                          for (int i = 0; i < 6; i++)
                            Padding(
                              padding: EdgeInsets.only(left: i == 0 ? 0 : 32),
                              child: AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  double opacity = _calculateOpacity(i, _controller.value);
                                  return Opacity(
                                    opacity: opacity,
                                    child: RotationTransition(
                                      turns: _controller,
                                      child: SvgPicture.asset(
                                        ImageAssets.loader,
                                        width: loaderSize - 16,
                                        height: loaderSize - 16,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              FadeTransition(
                opacity: _tipFadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'TIP: ${Strings.gameTips[_tipIndex]}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Knewave',
                      fontSize: screenWidth / 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight / 10)
            ],
          ),
        ],
      ),
    );
  }

  double _calculateOpacity(int index, double animationValue) {
    double segmentDuration = 1.0 / 6;
    double start = segmentDuration * index;
    double end = start + segmentDuration;

    if (animationValue >= start && animationValue < end) {
      return (animationValue - start) / segmentDuration;
    } else if (animationValue >= end) {
      return 1.0;
    } else {
      return 0.0;
    }
  }
}
