import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/animations/animations_manager.dart';
import 'package:lg_flutter_hackathon/constants/colors.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';

class HealthBar extends StatefulWidget {
  final double maxHealthPoints;
  final double newHealthPoints;

  const HealthBar({
    super.key,
    required this.maxHealthPoints,
    required this.newHealthPoints,
  });

  @override
  State<HealthBar> createState() => _HealthBarState();
}

class _HealthBarState extends State<HealthBar> with TickerProviderStateMixin {
  late AnimationManager _animationManager;

  @override
  void initState() {
    super.initState();

    _animationManager = AnimationManager(vsync: this);
    _animationManager.initializeShakeAnimation();
    _animationManager.initializeGrowAnimation();
    _animationManager.initializeHealthChangeAnimation(widget.maxHealthPoints, widget.newHealthPoints);

    _animationManager.healthChangeController.forward();
  }

  @override
  void didUpdateWidget(HealthBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.newHealthPoints != widget.newHealthPoints) {
      _animationManager.updateHealthAnimation(oldWidget.newHealthPoints, widget.newHealthPoints);
    }
  }

  @override
  void dispose() {
    _animationManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final healthBarWidth = screenWidth / DesignConsts.healthBarWidthFactor;
    final foregroundWidth = healthBarWidth * DesignConsts.healthBarForegroundWidthFactor;
    const padding = 16.0;

    final maxHealthBarWidth = foregroundWidth - 2 * padding;

    Gradient healthGradient;
    if (_animationManager.healthAnimation.value > 60) {
      healthGradient = AppColors.healthBarGreen;
    } else if (_animationManager.healthAnimation.value > 25) {
      healthGradient = AppColors.healthBarOrange;
    } else {
      healthGradient = AppColors.healthBarRed;
    }

    return AnimatedBuilder(
      animation: Listenable.merge([_animationManager.shakeAnimation, _animationManager.growAnimation]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animationManager.shakeAnimation.value, 0),
          child: Transform.scale(
            scale: _animationManager.growAnimation.value,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  ImageAssets.healthBarBackground,
                  width: healthBarWidth,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: padding),
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              borderRadius: DesignConsts.healthBarRadius,
                              gradient: healthGradient,
                            ),
                            width: maxHealthBarWidth * (_animationManager.healthAnimation.value / 100),
                            height: MediaQuery.sizeOf(context).height / DesignConsts.healthBarHeightDivision,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          ImageAssets.healthBarForeground,
                          width: foregroundWidth,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
