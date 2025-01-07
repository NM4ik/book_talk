import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_talk_ui/book_talk_ui.dart';

class SnackManager {
  static void success(
    BuildContext context, {
    required String message,
  }) {
    final snackBar = SnackBar(
      content: UiText.bodyMedium(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void error(
    BuildContext context, {
    required String message,
  }) {
    final snackBar = SnackBar(
      content: UiText.bodyMedium(message),
      backgroundColor: Theme.of(context).colorPalette!.destructive,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // TODO(Mikhailov): localize
  static Future<bool?> confirm(
    BuildContext context, {
    required String message,
  }) async {
    return showCupertinoModalPopup<bool?>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: UiText.titleLarge('Delete Room'),
        message: UiText.bodyMedium('Delete `Saint-Petersubrb #45 room`?'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: UiText.titleMedium(
              'Cancel',
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: UiText.titleMedium(
              'Delete',
              color: Theme.of(context).colorPalette!.destructive,
            ),
          ),
        ],
      ),
    );
  }
}
