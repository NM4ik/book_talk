import 'package:flutter/material.dart';

// TODO(mikhailov): Create error view.
class MaterialAppFailed extends StatelessWidget {
  const MaterialAppFailed({
    required this.onRetry,
    required this.error,
    required this.stackTrace,
    super.key,
  });

  final void Function() onRetry;
  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) => const MaterialApp(
    home: Scaffold(body: Center(child: Text('ERROR'))),
  );
}
