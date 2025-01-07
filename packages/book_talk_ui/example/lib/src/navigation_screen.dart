import 'package:example/src/button_screen.dart';
import 'package:example/src/color_palette_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ColorPaletteScreen())),
              child: const Text('ColorPalette.Screen()'),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ButtonScreen())),
              child: const Text('Button.Screen()'),
            ),
          ],
        ),
      ),
    );
  }
}
