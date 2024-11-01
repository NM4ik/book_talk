import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:book_talk/src/feature/settings/bloc/app_settings_bloc.dart';
import 'package:book_talk/src/feature/settings/model/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScope extends StatefulWidget {
  const SettingsScope({
    required this.child,
    super.key,
  });

  static AppSettings? settingsOf(BuildContext context, {bool listen = true}) {
    final settingsScope = listen
        ? context.dependOnInheritedWidgetOfExactType<_InheritedSettingsScope>()
        : context.getInheritedWidgetOfExactType<_InheritedSettingsScope>();

    return settingsScope?.appSettings;
  }

  final Widget child;

  @override
  State<SettingsScope> createState() => _SettingsScopeState();
}

class _SettingsScopeState extends State<SettingsScope> {
  late final appSettingsBloc = AppScope.of(context).appSettingsBloc;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AppSettingsBloc, AppSettingsState>(
        bloc: appSettingsBloc,
        builder: (context, state) => _InheritedSettingsScope(
          appSettings: state.settings,
          child: widget.child,
        ),
      );
}

class _InheritedSettingsScope extends InheritedWidget {
  final AppSettings? appSettings;

  _InheritedSettingsScope({
    required this.appSettings,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant _InheritedSettingsScope oldWidget) =>
      oldWidget.appSettings != appSettings;
}
