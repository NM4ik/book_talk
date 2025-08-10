import 'package:book_talk/src/feature/booking/model/booking_days.dart';
import 'package:book_talk/src/feature/booking/widget/booking_days_picker.dart';
import 'package:book_talk/src/feature/booking/widget/booking_month_builder.dart';
import 'package:flutter/material.dart';

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
  late List<DayInfo> _bookingDays;
  static const double _cardWidth = 60;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _bookingDays = widget.bookingDays.getSortedUpcomingDays(_previousDay);
  }

  @override
  void didUpdateWidget(covariant BookingCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bookingDays != widget.bookingDays) {
      _bookingDays = widget.bookingDays.getSortedUpcomingDays(_previousDay);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookingCalendarMonthTitleWidget(
          scrollController: _scrollController,
          bookingDays: _bookingDays,
          cardWidth: _cardWidth,
        ),
        BookingDaysPickerWidget(
          bookingDays: _bookingDays,
          scrollController: _scrollController,
        ),

        // SizedBox(
        //   height: 100,
        //   child: ListView.separated(
        //     controller: _scrollController,
        //     padding: const EdgeInsets.only(left: 12, right: 12),
        //     scrollDirection: Axis.horizontal,
        //     itemCount: _bookingDays.length,
        //     itemBuilder: (context, index) {
        //       return BookingDaysPickerWidget(bookingDays: _bookingDays);
        //     },
        //     separatorBuilder: (BuildContext context, int index) =>
        //         const SizedBox(width: 10),
        //   ),
        // ),
      ],
    );
}
