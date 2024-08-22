import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/level_enum.dart';
import 'package:lg_flutter_hackathon/battle/presentation/widgets/overlay_widget.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';

class RoundWidget extends StatefulWidget {
  const RoundWidget({
    super.key,
    required this.child,
    required this.level,
  });

  final Widget child;
  final LevelEnum level;

  @override
  State<RoundWidget> createState() => _RoundWidgetState();
}

class _RoundWidgetState extends State<RoundWidget> with SingleTickerProviderStateMixin {
  bool _displayRound = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 3500), () {
      setState(() {
        _displayRound = false;
      });
    });
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
          const OverlayWidget(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                ImageAssets.round,
                width: screenWidth / 2,
                height: screenHeight / 4,
                fit: BoxFit.contain,
              )
                  .animate()
                  .slideY(
                    curve: Curves.easeInOut,
                    begin: 0.5,
                    end: 0.0,
                    duration: const Duration(milliseconds: 800),
                  )
                  .fadeIn(
                    duration: const Duration(milliseconds: 800),
                  ),
              SvgPicture.asset(
                widget.level.roundAsset,
                width: screenWidth / 4,
                height: screenHeight / 4,
                fit: BoxFit.contain,
              )
                  .animate()
                  .slideY(
                    curve: Curves.easeInOut,
                    begin: 0.5,
                    end: 0.0,
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 250),
                  )
                  .fadeIn(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 250),
                  ),
              SizedBox(height: screenHeight / 10),
              Text(
                widget.level.monster.monsterName,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: DesignConsts.fontFamily,
                  fontSize: screenWidth / 40,
                ),
              ).animate().fadeIn(
                    delay: const Duration(milliseconds: 1500),
                    duration: const Duration(milliseconds: 1000),
                  ),
            ],
          ),
        ],
      ],
    );
  }
}
