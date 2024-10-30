import 'package:book_talk/src/common/model/app_metadata.dart';
import 'package:book_talk/src/feature/account/bloc/account_bloc.dart';
import 'package:book_talk/src/feature/account/data/user_repository.dart';
import 'package:book_talk/src/feature/auth/bloc/auth_bloc.dart';
import 'package:book_talk/src/feature/settings/bloc/app_settings_bloc.dart';

class DependenciesContainer {
  const DependenciesContainer({
    required this.appSettingsBloc,
    required this.appMetadata,
    required this.authBloc,
    required this.userRepository,
    required this.accountBloc,
  });

  /// [AppMetadata] client info
  final AppMetadata appMetadata;

  /// [AppSettingsBloc] manage theme and locale
  final AppSettingsBloc appSettingsBloc;

  /// [AuthBloc] user authentication
  final AuthBloc authBloc;

  /// [UserRepository] for manage user data
  final UserRepository userRepository;

  final AccountBloc accountBloc;
}
