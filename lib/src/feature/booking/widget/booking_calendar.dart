import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

/// {@template booking_calendar}
/// BookingCalendar widget.
/// {@endtemplate}
class BookingCalendar extends StatefulWidget {
  /// {@macro booking_calendar}
  const BookingCalendar({
    super.key, // ignore: unused_element
  });

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _BookingCalendarState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<_BookingCalendarState>();

  @override
  State<BookingCalendar> createState() => _BookingCalendarState();
}

/// State for widget BookingCalendar.
class _BookingCalendarState extends State<BookingCalendar> {
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant BookingCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    // Получаем количество дней в месяце

    /// month + 1 and day == 0 is the last day of the current month
    /// DateTime(2024, 3, 0) returns 2024-02-29 (the last day of February).
    /// DateTime(2023, 3, 0) returns 2023-02-28 (the last day of February in a non-leap year).
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    print('daysInMonth - $daysInMonth');
    print('now.month - ${now.month + 1}');

    // Генерируем список дат
    final dates = List.generate(
      daysInMonth,
      (index) => DateTime(now.year, now.month, index + 1),
    );

    final dateFormatter = DateFormat.EEEE(
      Localizations.localeOf(context).languageCode,
    );

    return SizedBox(
      height: 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          return Container(
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            color: Colors.blue,
            child: Center(
              child: Text(
                dateFormatter.format(dates[index]),
              ),
            ),
          );
        },
      ),
    );

    // return Column(
    //   children: [
    //     Row(
    //       children: [
    //         Text(now.day.toString()),
    //         Text(DateTime.january.toString()),
    //       ],
    //     ),
    //     for (final day in dates) Text('day: $day'),
    //   ],
    // );
  }
}
