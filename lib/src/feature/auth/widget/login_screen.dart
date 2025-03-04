import 'package:book_talk/generated/assets.gen.dart';
import 'package:book_talk/src/common/widgets/window_size.dart';
import 'package:book_talk/src/feature/auth/bloc/auth_bloc.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final PageController _pageController = PageController();
  final ValueNotifier<int> _indexNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _fillDebugCredentials();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _indexNotifier.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final windowSize = WindowSizeScope.of(context);

    return Scaffold(
      body: Center(
        child: Row(
          children: [
            if (!windowSize.isCompactFormat)
              Expanded(
                child: _PresentationSlider(
                  pageController: _pageController,
                  indexNotifier: _indexNotifier,
                ),
              ),
            Expanded(
              child: LoginForm(
                emailController: _emailController,
                passwordController: _passwordController,
                passwordFocusNode: passwordFocusNode,
                emailFocusNode: emailFocusNode,
                onAuthPress: () => _onSignIn(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSignIn(BuildContext context) {
    AppScope.of(context).authBloc.add(
          AuthEvent.signEmailPassword(
            _emailController.text,
            _passwordController.text,
          ),
        );
  }

  void _fillDebugCredentials() {
    if (AppScope.of(context).config.environment.isDev) {
      _emailController.text = dotenv.env['DEBUG_EMAIL'] ?? '';
      _passwordController.text = dotenv.env['DEBUG_PASSWORD'] ?? '';
    }
  }
}

class _PasswordTextFieldWidget extends StatefulWidget {
  const _PasswordTextFieldWidget({
    required this.controller,
    required this.focusNode,
    required this.onEditingComplete,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function() onEditingComplete;

  @override
  State<_PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<_PasswordTextFieldWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return UiTextField.standart(
      hintText: 'Password',
      obscureText: _obscureText,
      controller: widget.controller,
      focus: widget.focusNode,
      onEditingComplete: widget.onEditingComplete,
      suffixIcon: IconButton(
        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      ),
    );
  }
}

final _bgAssets = [
  Assets.images.authBgSand.path,
  Assets.images.authBgSequoia.path,
];

const List<String> _titles = [
  'Capturing Moments,\nCreating Memories',
  'Bringing Ideas Together,\nCreating the Future',
];

class _PresentationSlider extends StatelessWidget {
  const _PresentationSlider({
    required this.pageController,
    required this.indexNotifier,
  });

  final PageController pageController;
  final ValueNotifier<int> indexNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CarouselSlider.builder(
            itemCount: _bgAssets.length,
            itemBuilder: (context, index, realIndex) {
              return Image.asset(
                _bgAssets[index],
                fit: BoxFit.cover,
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 1300),
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayInterval: const Duration(seconds: 5),
              viewportFraction: 1,
              height: double.infinity,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                indexNotifier.value = index;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ListenableBuilder(
              listenable: indexNotifier,
              builder: (context, child) => Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FittedBox(
                    child: Text(
                      _titles[indexNotifier.value],
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                  AnimatedSmoothIndicator(
                    activeIndex: indexNotifier.value,
                    count: _bgAssets.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.white,
                      activeDotColor: Colors.white,
                      dotHeight: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.passwordFocusNode,
    required this.emailFocusNode,
    required this.onAuthPress,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;
  final FocusNode emailFocusNode;
  final Function() onAuthPress;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Align(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 550,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Text(
                    'Log in to account',
                    style: Theme.of(context).appTypography?.headlineLarge,
                  ),
                ),
                UiTextField.standart(
                  hintText: 'Email',
                  controller: emailController,
                  onEditingComplete: passwordFocusNode.requestFocus,
                  focus: emailFocusNode,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 40),
                  child: _PasswordTextFieldWidget(
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    onEditingComplete: () {
                      passwordFocusNode.unfocus();
                      onAuthPress();
                    },
                  ),
                ),
                UiButton.filledPrimary(
                  onPressed: onAuthPress,
                  label: const Text('Sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
