import 'package:book_talk/src/feature/booking/model/booking_days.dart';
import 'package:book_talk/src/feature/booking/widget/month_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// {@template booking_calendar}
/// BookingCalendar widget.
/// {@endtemplate}
class BookingCalendar extends StatefulWidget {
  /// {@macro booking_calendar}
  const BookingCalendar({
    required this.bookingDays,
    super.key, // ignore: unused_element
  });

  final BookingDays bookingDays;

  @override
  State<BookingCalendar> createState() => _BookingCalendarState();
}

/// State for widget BookingCalendar.
class _BookingCalendarState extends State<BookingCalendar> {
  final ScrollController _scrollController = ScrollController();
  final DateTime _previousDay =
      DateTime.now().subtract(const Duration(days: 1));
  late List<DateTime> _bookingDays;
  static const double _cardWidth = 50;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _bookingDays = _sortBookingDays();
  }

  @override
  void didUpdateWidget(covariant BookingCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bookingDays != widget.bookingDays) {
      _bookingDays = _sortBookingDays();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookingCalendarMonthTitleWidget(
          scrollController: _scrollController,
          bookingDays: _bookingDays,
          cardWidth: _cardWidth,
        ),
        SizedBox(
          height: 70,
          child: ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.only(left: 12, right: 12),
            scrollDirection: Axis.horizontal,
            itemCount: _bookingDays.length,
            itemBuilder: (context, index) => SizedBox(
              width: _cardWidth,
              child: _DayCard(
                dateTime: _bookingDays[index],
                index: index,
              ),
            ),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(width: 10),
          ),
        ),
      ],
    );
  }

  List<DateTime> _sortBookingDays() {
    widget.bookingDays.days.sort();
    return widget.bookingDays.days
        .where((date) => date.isAfter(_previousDay))
        .toList();
  }
}

/// {@template booking_calendar}
/// _DayCard widget.
/// {@endtemplate}
class _DayCard extends StatelessWidget {
  /// {@macro booking_calendar}
  const _DayCard({
    required this.dateTime,
    required this.index,
    super.key, // ignore: unused_element
  });

  final DateTime dateTime;
  final int index;

  @override
  Widget build(BuildContext context) {
    final _dayFormatter =
        DateFormat('EEE', Localizations.localeOf(context).languageCode);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_dayFormatter.format(dateTime)),
          Text(dateTime.day.toString()),
        ],
      ),
    );
  }
}
