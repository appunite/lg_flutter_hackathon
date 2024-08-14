import 'dart:ui';

import 'package:window_manager/window_manager.dart';

class WindowManagerListener extends WindowListener {
  @override
  void onWindowResize() {
    _maintainAspectRatio();
  }

  void _maintainAspectRatio() async {
    final currentSize = await windowManager.getSize();
    const double aspectRatio = 16 / 9;

    double newWidth = currentSize.width;
    double newHeight = currentSize.height;

    if ((currentSize.width / currentSize.height).toStringAsFixed(2) != aspectRatio.toStringAsFixed(2)) {
      if (currentSize.width / aspectRatio <= currentSize.height) {
        newHeight = currentSize.width / aspectRatio;
      } else {
        newWidth = currentSize.height * aspectRatio;
      }

      windowManager.setSize(Size(newWidth, newHeight));
    }
  }
}
