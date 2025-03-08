import 'package:book_talk/src/common/widgets/user_avatar_widget.dart';
import 'package:book_talk/src/feature/account/bloc/account_bloc.dart';
import 'package:book_talk/src/feature/auth/bloc/auth_bloc.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:book_talk/src/feature/settings/bloc/app_settings_bloc.dart';
import 'package:book_talk/src/feature/settings/model/app_settings.dart';
import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountBloc = AppScope.of(context).accountBloc;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const UserAvatarWidget(),
                  const SizedBox(width: 20),
                  BlocBuilder<AccountBloc, AccountState>(
                    bloc: accountBloc,
                    builder: (context, state) {
                      return Text(state.user?.email ?? '');
                    },
                  ),
                ],
              ),
            ),
            const _AppThemeSwitcher(),
            const Spacer(),
            UiButton.negativePrimary(
              onPressed: () => _onLogout(context),
              label: const Text(
                'LogOut',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onLogout(BuildContext context) {
    AppScope.of(context).authBloc.add(AuthEvent.signOut());
  }
}

class _AppThemeSwitcher extends StatelessWidget {
  const _AppThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UiButton.negativePrimary(
          label: UiText.titleSmall('light'),
          onPressed: () => _onSwitchTheme(
            context,
            ThemeMode.light,
          ),
        ),
        UiButton.negativePrimary(
          label: UiText.titleSmall('dark'),
          onPressed: () => _onSwitchTheme(
            context,
            ThemeMode.dark,
          ),
        ),
        UiButton.negativePrimary(
          label: UiText.titleSmall('system'),
          onPressed: () => _onSwitchTheme(
            context,
            ThemeMode.system,
          ),
        ),
      ],
    );
  }

  void _onSwitchTheme(BuildContext context, ThemeMode themeMode) {
    final appSettingsBloc = AppScope.of(context).appSettingsBloc;
    final currentSettings = appSettingsBloc.state.settings;
    if (appSettingsBloc.state.isLoading || currentSettings == null) return;
    appSettingsBloc.add(
      AppSettingsEvent.update(
        AppSettings(
          themeMode: themeMode,
          locale: currentSettings.locale,
        ),
      ),
    );
  }
}
