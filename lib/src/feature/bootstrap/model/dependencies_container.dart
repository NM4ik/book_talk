import 'package:book_talk/common.dart';
import 'package:book_talk/src/feature/account/bloc/account_bloc.dart';
import 'package:book_talk/src/feature/account/data/user_repository.dart';
import 'package:book_talk/src/feature/auth/bloc/auth_bloc.dart';
import 'package:book_talk/src/feature/rooms/bloc/rooms_bloc.dart';
import 'package:book_talk/src/feature/settings/bloc/app_settings_bloc.dart';

class DependenciesContainer {
  const DependenciesContainer({
    required this.config,
    required this.appSettingsBloc,
    required this.appMetadata,
    required this.authBloc,
    required this.userRepository,
    required this.roomsBloc,
    required this.accountBloc,
  });

  final Config config;

  /// Information about the application and client environment
  final AppMetadata appMetadata;

  /// Manages application settings such as theme and locale
  final AppSettingsBloc appSettingsBloc;

  /// Handles user authentication and session management
  final AuthBloc authBloc;

  /// Provides access to user-related data and operations
  final UserRepository userRepository;

  /// Manages account information and operations related to the user profile
  final AccountBloc accountBloc;

  /// Manages rooms information and operations
  final RoomsBloc roomsBloc;
}
