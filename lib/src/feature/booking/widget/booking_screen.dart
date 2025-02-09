import 'package:book_talk/src/common/model/room/room.dart';
import 'package:book_talk/src/feature/booking/bloc/booking_bloc.dart';
import 'package:book_talk/src/feature/booking/widget/booking_calendar.dart';
import 'package:book_talk/src/feature/booking/widget/booking_scope.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final Room room = AppScope.of(context)
        .roomsBloc
        .state
        .rooms!
        .firstWhereOrNull((room) => room.id == roomId)!;

    return BookingScope(
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          leading: Theme.of(context)
              .actionIconTheme!
              .backButtonIconBuilder!(context),
          middle: UiText.titleMedium(
            room.name,
            textAlign: TextAlign.center,
          ),
        ),
        body: const _BookingDays(),
      ),
    );
  }
}

/// {@template booking_screen}
/// _BookingDays widget.
/// {@endtemplate}
class _BookingDays extends StatelessWidget {
  /// {@macro booking_screen}
  const _BookingDays({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<BookingBloc, BookingState>(
        bloc: BookingScope.of(context),
        builder: (context, state) {
          return state.$map(
            idle: ({required bookingDays}) {
              // TODO(Mikhailov): remove ! operator and handle null. If null just show
              // empty screen or smth
              return BookingCalendar(bookingDays: bookingDays!);
            },
            processing: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: ({required bookingDays, required message}) => Text(message),
          );
        },
      );
}
