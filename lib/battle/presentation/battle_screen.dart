import 'package:flutter/material.dart';

import 'package:lg_flutter_hackathon/components/confirmation_pop_up.dart';
import 'package:lg_flutter_hackathon/components/tool_tip.dart';
import 'package:lg_flutter_hackathon/constants/strings.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  final TooltipController _controller = TooltipController();
  bool done = false;

  @override
  void initState() {
    _controller.onDone(() {
      setState(() {
        done = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) async {
        // TODO comment on PR
        /// PopScope not working on flutter WEB :) https://github.com/jonataslaw/getx/issues/3121
        /// this is for web back button
        // await showDialog(
        //   context: context,
        //   builder: (context) {
        //     return const ConfirmationPopUp(title: Strings.exitConfirmation);
        //   },
        // );
      },
      child: OverlayTooltipScaffold(
        overlayColor: Colors.red.withOpacity(.4),
        tooltipAnimationCurve: Curves.linear,
        tooltipAnimationDuration: const Duration(milliseconds: 1000),
        controller: _controller,
        preferredOverlay: GestureDetector(
          onTap: () {
            _controller.dismiss();
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.blue.withOpacity(.2),
          ),
        ),
        builder: (context) => Scaffold(
          appBar: _buildAppbar(context),
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OverlayTooltipItem(
                        displayIndex: 0,
                        tooltip: (controller) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: MTooltip(title: 'this is the player!', controller: controller),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 200,
                          color: Colors.blue,
                          child: const Center(child: Text('Player')),
                        ),
                      ),
                      OverlayTooltipItem(
                        displayIndex: 1,
                        tooltip: (controller) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: MTooltip(title: 'This is the rune!', controller: controller),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 200,
                          color: Colors.green,
                          child: const Center(child: Text('Runes')),
                        ),
                      ),
                      OverlayTooltipItem(
                        displayIndex: 2,
                        tooltip: (controller) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: MTooltip(title: 'kill dis!', controller: controller),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 200,
                          color: Colors.red,
                          child: const Center(child: Text('Enemy')),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          done = false;
                        });
                      },
                      child: const Text('reset Tooltip')),
                  TextButton(
                      onPressed: () {
                        //_controller.start();
                        OverlayTooltipScaffold.of(context)?.controller.start();
                      },
                      child: const Text('Start Tooltip manually')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

AppBar _buildAppbar(BuildContext context) {
  return AppBar(
    elevation: 3,
    leading: BackButton(
      color: Colors.black,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const ConfirmationPopUp(title: Strings.exitConfirmation);
          },
        );
      },
    ),
  );
}
