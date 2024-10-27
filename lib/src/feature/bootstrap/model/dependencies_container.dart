import 'package:book_talk/src/common/model/app_metadata.dart';
import 'package:book_talk/src/feature/auth/bloc/auth_bloc.dart';
import 'package:book_talk/src/feature/settings/bloc/app_settings_bloc.dart';

class DependenciesContainer {
  const DependenciesContainer({
    required this.appSettingsBloc,
    required this.appMetadata,
    required this.authBloc,
  });

  /// [AppMetadata] client info
  final AppMetadata appMetadata;

  /// [AppSettingsBloc] manage theme and locale
  final AppSettingsBloc appSettingsBloc;

  /// [AuthBloc] user authentication
  final AuthBloc authBloc;
}
