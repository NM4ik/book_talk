import 'package:book_talk/src/common/constants/pubspec.yaml.g.dart';
import 'package:flutter/material.dart';

class AppDebugWidget extends StatelessWidget {
  const AppDebugWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => Material(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          child,
          SafeArea(
            minimum: const EdgeInsets.all(20),
            child: Text(
              'version: ${Pubspec.version.canonical}',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
}
