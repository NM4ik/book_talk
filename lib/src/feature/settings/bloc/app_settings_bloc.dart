import 'package:bloc/bloc.dart';
import 'package:book_talk/src/feature/settings/data/app_settings_repository.dart';
import 'package:book_talk/src/feature/settings/model/app_settings.dart';
import 'package:meta/meta.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

final class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc({
    required AppSettingsRepository appSettingsRepository,
    required AppSettingsState initialState,
  }) : _appSettingsRepository = appSettingsRepository,
       super(initialState) {
    on<AppSettingsEvent>(
      (event, emitter) => switch (event) {
        _UpdateAppSettingsEvent() => _onUpdateEvent(event, emitter),
      },
    );
  }

  final AppSettingsRepository _appSettingsRepository;

  Future<void> _onUpdateEvent(
    _UpdateAppSettingsEvent event,
    Emitter<AppSettingsState> emitter,
  ) async {
    try {
      emitter(const AppSettingsState.loading());
      _appSettingsRepository.setAppSettings(event.appSettings).ignore();
      emitter(AppSettingsState.idle(appSettings: event.appSettings));
    } on Object catch (error, st) {
      emitter(AppSettingsState.error(error: error));
      onError(error, st);
    }
  }
}
