import 'package:book_talk/generated/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:book_talk_ui/book_talk_ui.dart';

/// {@template booking_error}
/// BookingErrorWidget widget.
/// {@endtemplate}
class BookingErrorWidget extends StatelessWidget {
  /// {@macro booking_error}
  const BookingErrorWidget({
    required this.onPressed,
    super.key, // ignore: unused_element
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UiText.titleMedium(
                S.of(context).bookingSheduleError,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              UiText.bodySmall(
                S.of(context).retryOrLater,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              UiButton.filledPrimary(
                onPressed: onPressed,
                label: UiText.bodyMedium(S.of(context).tryAgain),
                innerPadding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ],
          ),
        ),
      );
}
