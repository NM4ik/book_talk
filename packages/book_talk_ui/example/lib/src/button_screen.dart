import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:book_talk_ui/book_talk_ui.dart';

class ButtonScreen extends StatelessWidget {
  const ButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookTalkTheme theme = BookTalkTheme();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Buttons'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Theme(
                  data: theme.lightTheme,
                  child: UiButton.filledPrimary(
                    label: const Text('ButtonLabel'),
                    onPressed: () {
                      log('UiButton.filledPrimary');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
