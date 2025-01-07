import 'package:book_talk/generated/l10n.dart';
import 'package:book_talk/src/common/router/router_mixin.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_debug_widget.dart';
import 'package:book_talk/src/feature/settings/widget/settings_scope.dart';
import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:octopus/octopus.dart';

class MaterialAppContext extends StatefulWidget {
  const MaterialAppContext({super.key});

  @override
  State<MaterialAppContext> createState() => _MaterialAppContextState();
}

class _MaterialAppContextState extends State<MaterialAppContext>
    with RouterMixin {
  final _materialAppKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final settings = SettingsScope.settingsOf(context);
    final bookTalkUI = BookTalkTheme();

    return MaterialApp.router(
      title: 'BookTalk',
      debugShowCheckedModeBanner: false,

      // App Router
      routerConfig: router.config,

      // Localization
      localizationsDelegates: const <LocalizationsDelegate<Object?>>[
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,

      locale: settings?.locale,
      darkTheme: bookTalkUI.darkTheme,
      theme: bookTalkUI.lightTheme,
      themeMode: settings?.themeMode ?? ThemeMode.system,

      builder: (context, child) {
        final safeChild = child ?? const SizedBox.shrink();
        final childWidget = kReleaseMode
            ? safeChild
            : AppDebugWidget(
                child: safeChild,
              );

        return MediaQuery(
          key: _materialAppKey,
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: OctopusTools(
            enable: true,
            octopus: router,
            child: childWidget,
          ),
        );
      },
    );
  }
}
