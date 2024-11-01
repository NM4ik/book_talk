import 'package:book_talk/src/common/constants/pubspec.yaml.g.dart';
import 'package:flutter/material.dart';

class AppDebugWidget extends StatelessWidget {
  const AppDebugWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          child,
          SafeArea(
            minimum: const EdgeInsets.all(20),
            child: Text(
              'version: ${Pubspec.version.canonical}',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
