import 'package:book_talk/generated/l10n.dart';
import 'package:book_talk/src/common/model/room/room.dart';
import 'package:book_talk/src/common/widgets/bloc_builder.dart';
import 'package:book_talk/src/feature/booking/bloc/booking_bloc.dart';
import 'package:book_talk/src/feature/booking/model/booking_days.dart';
import 'package:book_talk/src/feature/booking/widget/booking_calendar.dart';
import 'package:book_talk/src/feature/booking/widget/booking_error.dart';
import 'package:book_talk/src/feature/booking/widget/booking_scope.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_talk_ui/book_talk_ui.dart';

/// {@template booking_screen}
/// BookingScreen widget.
/// {@endtemplate}
class BookingScreen extends StatelessWidget {
  /// {@macro booking_screen}
  const BookingScreen({
    required this.roomId,
    super.key, // ignore: unused_element
  });

  final int roomId;

  @override
  Widget build(BuildContext context) {
    final Room? room = AppScope.of(context)
        .roomsBloc
        .state
        .rooms
        ?.firstWhereOrNull((room) => room.id == roomId);

    final String roomName = room?.name ?? S.of(context).roomNotFound;

    return BookingScope(
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          leading: Theme.of(context)
              .actionIconTheme!
              .backButtonIconBuilder!(context),
          middle: UiText.titleMedium(roomName, textAlign: TextAlign.center),
        ),
        body: const _BookingBody(),
      ),
    );
  }
}

/// {@template booking_screen}
/// _BookingDays widget.
/// {@endtemplate}
class _BookingBody extends StatelessWidget {
  /// {@macro booking_screen}
  const _BookingBody({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) =>
      AnimatedBlocBuilder<BookingBloc, BookingState>(
        bloc: BookingScope.of(context),
        builder: (context, state) {
          final BookingDays? bookingDays = state.bookingDays;

          if (bookingDays != null) {
            return BookingCalendar(bookingDays: bookingDays);
          }

          if (state.isProcessing) {
            return Center(child: UiProgressIndicator.deffered());
          }

          return BookingErrorWidget(
            onPressed: () {
              BookingScope.of(context).add(const BookingEvent.load());
            },
          );
        },
      );
}
