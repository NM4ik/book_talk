import 'package:book_talk/src/feature/auth/bloc/auth_bloc.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
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
          constraints: BoxConstraints(
            maxWidth: 350,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: SizedBox(
                    height: 48,
                    child: FilledButton(
                      onPressed: () => _onSignIn(context),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Sign in'),
                    ),
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
