import 'package:animations/animations.dart';
import 'package:book_talk/common.dart';
import 'package:book_talk/src/feature/booking/model/booking_days.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:book_talk_ui/book_talk_ui.dart';

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
  final DateTime _now = DateTime.now();
  late final DateTime _previousDay =
      DateTime(_now.year, _now.month, _now.day - 1);
  late List<DateTime> _dates;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _buildDates();
  }

  @override
  void didUpdateWidget(covariant BookingCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bookingDays != widget.bookingDays) {
      _buildDates();
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
    final BookingDays bookingDays = widget.bookingDays;
    final DateTime now = DateTime.now();
    bookingDays.days.sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(_monthFormatter.format(now)),
        _MonthBuilder(
          scrollController: _scrollController,
          dates: _dates,
        ),
        SizedBox(
          height: 70,
          child: ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.only(left: 12, right: 12),
            scrollDirection: Axis.horizontal,
            itemCount: _dates.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text(index.toString()),
                  _DayCard(dateTime: _dates[index]),
                ],
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

  /// Builds the list of dates for the calendar.
  ///
  /// This method sorts the dates from the [BookingDays] and filters out the dates
  /// that are before the [_previousDay].
  void _buildDates() {
    // Sort the dates from the BookingDays
    widget.bookingDays.days.sort((a, b) => a.compareTo(b));

    // Filter out the dates that are before the previous day
    _dates = widget.bookingDays.days
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
    super.key, // ignore: unused_element
  });

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    final _dayFormatter =
        DateFormat('EEE', Localizations.localeOf(context).languageCode);

    return SizedBox(
      width: _DayCard.width,
      child: DecoratedBox(
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
      ),
    );
  }

  static double get width => 50;
}

/// {@template booking_calendar}
/// _MonthBuilder widget.
/// {@endtemplate}
class _MonthBuilder extends StatefulWidget {
  /// {@macro booking_calendar}
  const _MonthBuilder({
    required this.scrollController,
    required this.dates,
    super.key, // ignore: unused_element
  });

  final ScrollController scrollController;
  final List<DateTime> dates;

  @override
  State<_MonthBuilder> createState() => __MonthBuilderState();
}

/// State for widget _MonthBuilder.
class __MonthBuilderState extends State<_MonthBuilder> {
  late final ScrollController _scrollController = widget.scrollController;
  int _index = 0;
  late DateTime _dateTime;
  final double cardWidth = _DayCard.width + 10;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _dateTime = widget.dates[_index];
    _scrollController.addListener(_calculateDayCardIndex);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_calculateDayCardIndex);
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) {
    final String currentMonth = _monthFormatter.format(_dateTime);
    final String? next = nextMonth(_dateTime);
    final String? previous = previousMonth(_dateTime);

    final String keyValue = currentMonth + (next ?? '') + (previous ?? '');

    return _MonthSwitcher(
      child: Row(
        key: ValueKey(keyValue),
        children: [
          if (previous != null) UiText.titleMedium(previous),
          UiText.titleMedium(currentMonth),
          if (next != null) UiText.titleMedium(next),
        ],
      ),
    );
  }

  void _calculateDayCardIndex() {
    final ScrollPosition scrollPosition = _scrollController.position;
    final int cardsOnScreen = context.widthPx ~/ cardWidth;
    final double pixels = scrollPosition.pixels.clamp(
      0,
      scrollPosition.maxScrollExtent,
    );
    final int newIndex = (pixels / cardWidth).floor() + (cardsOnScreen ~/ 2);

    if (newIndex != _index) {
      setState(() {
        _index = newIndex;
        _dateTime = widget.dates[_index];
      });
    }
  }

  String? previousMonth(DateTime dateTime) {
    final prevMonth = dateTime.subtract(const Duration(days: 5));

    if (prevMonth.month < dateTime.month) {
      return _monthFormatter.format(prevMonth);
    } else {
      return null;
    }
  }

  String? nextMonth(DateTime dateTime) {
    final nextMonth = dateTime.add(const Duration(days: 5));

    if (nextMonth.month > dateTime.month) {
      return _monthFormatter.format(nextMonth);
    } else {
      return null;
    }
  }

  late final _monthFormatter = DateFormat(
    'MMMM',
    Localizations.localeOf(context).languageCode,
  );
}

/// {@template booking_calendar}
/// _MonthSwitcher widget.
/// {@endtemplate}
class _MonthSwitcher extends StatelessWidget {
  /// {@macro booking_calendar}
  const _MonthSwitcher({
    required this.child,
    super.key, // ignore: unused_element
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => PageTransitionSwitcher(
        duration: const Duration(milliseconds: 1000),
        layoutBuilder: (entries) => Stack(
          alignment: Alignment.centerLeft,
          children: entries,
        ),
        transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
        ) =>
            SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          fillColor: Colors.transparent,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        ),
        child: child,
      );
}
