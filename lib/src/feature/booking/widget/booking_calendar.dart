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

    // Generate dates starts with current day
    final dates = List.generate(
      daysInMonth - now.day,
      (index) => DateTime(now.year, now.month, index + now.day),
    );

    final dayFormatter = DateFormat(
      'EEE',
      Localizations.localeOf(context).languageCode,
    );
    final monthFormatter = DateFormat(
      'MMMM',
      Localizations.localeOf(context).languageCode,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          monthFormatter.format(now),
        ),
        SizedBox(
          height: 70,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 12, right: 12),
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dayFormatter.format(dates[index]),
                      ),
                      Text(
                        dates[index].day.toString(),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(width: 10),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    for (int i = 0; i < 24; i++) ...[
                      Text(
                        DateTime(now.year)
                                .add(Duration(hours: i))
                                .hour
                                .toString() +
                            ":" +
                            DateTime(now.year)
                                .add(Duration(hours: i))
                                .minute
                                .toString(),
                      ),
                      Text(
                        DateTime(now.year)
                                .add(Duration(hours: i, minutes: 30))
                                .hour
                                .toString() +
                            ":" +
                            DateTime(now.year)
                                .add(Duration(hours: i, minutes: 30))
                                .minute
                                .toString(),
                      ),
                    ]
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

