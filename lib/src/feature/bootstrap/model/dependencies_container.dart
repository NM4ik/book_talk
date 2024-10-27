import 'package:book_talk/src/feature/settings/bloc/app_settings_bloc.dart';

class DependenciesContainer {
  const DependenciesContainer({required this.appSettingsBloc});

  /// [AppSettingsBloc] manage theme and locale
  final AppSettingsBloc appSettingsBloc;
}
