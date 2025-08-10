import 'dart:io' as io;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Future<void> $platformInitialization() =>
    io.Platform.isAndroid || io.Platform.isIOS
        ? _mobileInitialization()
        : _desktopInitialization();

// ignore: no-empty-block
Future<void> _mobileInitialization() async {}

Future<void> _desktopInitialization() async {
  // Must add this line.
  await windowManager.ensureInitialized();
  const windowOptions = WindowOptions(
    minimumSize: Size(360, 480),
    // size: Size(960, 800),
    // maximumSize: Size(1440, 1080),
    center: true,

    // TODO(Mikhailov): save last window size for desktop and fetch it here
    size: kDebugMode ? Size(430, 932) : null,
    // backgroundColor:
    //     PlatformDispatcher.instance.platformBrightness == Brightness.dark
    //         ? ThemeData.dark().colorScheme.surface
    //         : ThemeData.light().colorScheme.surface,
    // skipTaskbar: false,
    // titleBarStyle: TitleBarStyle.hidden,
    /* alwaysOnTop: true, */
    fullScreen: false,
    title: 'BookTalk',
  );
  await windowManager.waitUntilReadyToShow(
    windowOptions,
    () async {
      if (io.Platform.isMacOS) {
        await windowManager.setMovable(true);
      }
      await windowManager.setMaximizable(false);
      await windowManager.show();
      await windowManager.focus();
    },
  );
}
