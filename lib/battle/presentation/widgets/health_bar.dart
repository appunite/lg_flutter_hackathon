import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';

import 'package:flutter_svg/flutter_svg.dart';

class HealthBar extends StatefulWidget {
  final double currentHealth;
  final double incomingHealth;

  const HealthBar({
    super.key,
    required this.currentHealth,
    required this.incomingHealth,
  });

  @override
  State<HealthBar> createState() => _HealthBarState();
}

class _HealthBarState extends State<HealthBar> with TickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  late AnimationController _healthChangeController;
  late Animation<double> _healthAnimation;

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _shakeAnimation =
        Tween<double>(begin: 0, end: 10).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _shakeController.reverse();
            }
          });

    _healthChangeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _healthAnimation = Tween<double>(
      begin: widget.currentHealth,
      end: widget.incomingHealth,
    ).animate(_healthChangeController)
      ..addListener(() {
        setState(() {});
      });

    _shakeController.forward();
    _healthChangeController.forward();
  }

  @override
  void didUpdateWidget(HealthBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.incomingHealth != widget.incomingHealth) {
      _healthAnimation = Tween<double>(
        begin: oldWidget.currentHealth,
        end: widget.incomingHealth,
      ).animate(_healthChangeController);

      _shakeController.reset();
      _healthChangeController.reset();

      _shakeController.forward();
      _healthChangeController.forward();
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _healthChangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final healthBarWidth = screenWidth / 4;
    final foregroundWidth = healthBarWidth * 0.8;
    const padding = 16.0;

    final maxHealthBarWidth = foregroundWidth - 2 * padding;

    Gradient healthGradient = _healthAnimation.value <= 50
        ? const LinearGradient(
            colors: [Color(0xFFB65E2C), Color(0xFFE57C3D)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )
        : const LinearGradient(
            colors: [Color(0xFFB62C2C), Color(0xFFE53D3D)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          );

    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value, 0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                ImageAssets.healthBarBackground,
                width: healthBarWidth,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(56),
                            gradient: healthGradient,
                          ),
                          width: maxHealthBarWidth * (_healthAnimation.value / 100),
                          height: MediaQuery.sizeOf(context).height / 28,
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
        );
      },
    );
  }
}
