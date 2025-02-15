import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animations/animations.dart';
import 'package:book_talk/src/common/utils/extensions/build_context_extension.dart';
import 'package:book_talk_ui/book_talk_ui.dart';

/// {@template booking_calendar}
/// _MonthBuilder widget.
/// {@endtemplate}
class BookingCalendarMonthTitleWidget extends StatefulWidget {
  /// {@macro booking_calendar}
  const BookingCalendarMonthTitleWidget({
    required this.scrollController,
    required this.bookingDays,
    required this.cardWidth,
    super.key, // ignore: unused_element
  });

  final ScrollController scrollController;
  final List<DateTime> bookingDays;
  final double cardWidth;

  @override
  State<BookingCalendarMonthTitleWidget> createState() =>
      _BookingCalendarMonthTitleWidgetState();
}

/// State for widget _MonthBuilder.
class _BookingCalendarMonthTitleWidgetState
    extends State<BookingCalendarMonthTitleWidget> {
  late final ScrollController _scrollController;
  late final double _cardWidth;
  late DateTime _dateTime;

  int _cardIndex = 0;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController;
    _cardWidth = widget.cardWidth + 10;
    _dateTime = widget.bookingDays[_cardIndex];
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) {
    final String currentMonth = _monthFormatter.format(_dateTime);
    final String? next = nextMonth(_dateTime);
    final String? previous = previousMonth(_dateTime);
    final String monthKey = currentMonth + (next ?? '') + (previous ?? '');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: _MonthSwitcher(
        child: Row(
          key: ValueKey(monthKey),
          children: [
            if (previous != null) UiText.titleMedium(previous),
            UiText.titleMedium(currentMonth),
            if (next != null) UiText.titleMedium(next),
          ],
        ),
      ),
    );
  }

  void _scrollListener() {
    final newIndex = _calculateIndex();
    _updateIndex(newIndex);
  }

  /// Calculates index of the month.
  ///
  /// Calculates the index of the month based on the [_scrollController]'s position.
  /// - `cardsOnScreen` is the number of cards that fit on the screen.
  /// - `scrollExtent` is the scroll position of the [_scrollController].
  int _calculateIndex() {
    final ScrollPosition scrollPosition = _scrollController.position;
    final int cardsOnScreen = context.widthPx ~/ _cardWidth;
    final double scrollExtent = scrollPosition.pixels.clamp(
      0,
      scrollPosition.maxScrollExtent,
    );
    final int extent = cardsOnScreen ~/ 2;
    return extent + (scrollExtent / _cardWidth).floor();
  }

  void _updateIndex(int index) {
    if (index == _cardIndex || !mounted) return;
    setState(() {
      _cardIndex = index;
      _dateTime = widget.bookingDays[index];
    });
  }

  String? previousMonth(DateTime dateTime) {
    final previousDate = dateTime.subtract(const Duration(days: 5));

    if (previousDate.month < dateTime.month) {
      return _monthFormatter.format(previousDate);
    } else {
      return null;
    }
  }

  String? nextMonth(DateTime dateTime) {
    final nextDate = dateTime.add(const Duration(days: 5));

    if (nextDate.month > dateTime.month) {
      return _monthFormatter.format(nextDate);
    } else {
      return null;
    }
  }

  DateFormat get _monthFormatter => DateFormat(
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
