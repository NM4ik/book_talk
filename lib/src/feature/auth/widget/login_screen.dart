import 'package:book_talk/src/feature/auth/bloc/auth_bloc.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 350,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                _PasswordTextFieldWidget(controller: _passwordController),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: UiButton.filledPrimary(
                    onPressed: () => _onSignIn(context),
                    label: const Text('Sign in'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onSignIn(BuildContext context) {
    final authBloc = AppScope.of(context).authBloc;
    if (authBloc.state.isLoading) return;
    authBloc.add(
      AuthEvent.signEmailPassword(
        _emailController.text,
        _passwordController.text,
      ),
    );
  }
}

class _PasswordTextFieldWidget extends StatefulWidget {
  const _PasswordTextFieldWidget({required this.controller});

  final TextEditingController controller;

  @override
  State<_PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<_PasswordTextFieldWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() => _obscureText = !_obscureText);
          },
        ),
      ),
      obscureText: _obscureText,
    );
  }
}

// mixin _AuthenticationFormStateMixin on State<LoginScreen> {
//   static String? _emailValidator(String value) => switch (value.length) {
//         0 => 'Email is required',
//         < 3 => 'Too short value',
//         _ => null,
//       };

//   static String? _passwordValidator(String value) => switch (value.length) {
//         0 => 'Password is required',
//         < 6 ||
//         > 32 =>
//           'Must be 6 or more characters and must be less than 32 characters',
//         _ => null,
//       };
// }
