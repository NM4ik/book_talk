import 'package:flutter/material.dart';

class MaterialAppFailed extends StatelessWidget {
  const MaterialAppFailed({
    super.key,
    required this.onRetry,
    required this.error,
    required this.stackTrace,
  });

  final Function() onRetry;
  final Object error;
  final StackTrace stackTrace;

  // TODO(mikhailov): Create error view.
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('ERROR'),
          ),
        ),
      );
}
