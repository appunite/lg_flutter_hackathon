import 'package:flutter/material.dart';

class AnimationManager {
  final TickerProvider vsync;

  late AnimationController shakeController;
  late Animation<double> shakeAnimation;

  late AnimationController growController;
  late Animation<double> growAnimation;

  late AnimationController healthChangeController;
  late Animation<double> healthAnimation;

  AnimationManager({required this.vsync});

  void initializeShakeAnimation() {
    shakeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: vsync,
    );

    shakeAnimation = Tween<double>(begin: 0, end: 10)
        .chain(
          CurveTween(curve: Curves.elasticIn),
        )
        .animate(
          shakeController,
        )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          shakeController.reverse();
        }
      });
  }

  void initializeGrowAnimation() {
    growController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: vsync,
    );

    growAnimation = Tween<double>(begin: 1.0, end: 1.1)
        .chain(
          CurveTween(curve: Curves.easeOut),
        )
        .animate(
          growController,
        )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          growController.reverse();
        }
      });
  }

  void initializeHealthChangeAnimation(double currentHealth, double incomingHealth) {
    healthChangeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: vsync,
    );

    healthAnimation = Tween<double>(
      begin: currentHealth,
      end: incomingHealth,
    ).animate(
      healthChangeController,
    );
  }

  void updateHealthAnimation(
    double currentHealth,
    double incomingHealth,
  ) {
    healthAnimation = Tween<double>(
      begin: currentHealth,
      end: incomingHealth,
    ).animate(
      healthChangeController,
    );

    if (incomingHealth < currentHealth) {
      shakeController.reset();
      shakeController.forward();
    } else if (incomingHealth > currentHealth) {
      growController.reset();
      growController.forward();
    }

    healthChangeController.reset();
    healthChangeController.forward();
  }

  void dispose() {
    shakeController.dispose();
    growController.dispose();
    healthChangeController.dispose();
  }
}
