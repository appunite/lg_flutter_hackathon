import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';
import 'package:lg_flutter_hackathon/main_menu/main_menu_screen.dart';
import 'package:lg_flutter_hackathon/utils/transitions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Future.delayed(
          const Duration(seconds: 5),
          () => Navigator.pushReplacement(
            context,
            FadeRoute(
              page: const MainMenuScreen(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgPicture.asset(
        ImageAssets.splashScreenBackground,
        fit: BoxFit.cover,
      ),
    );
  }
}
