import 'package:book_talk/src/feature/booking/model/booking_days.dart';
import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// {@template booking_days_picker}
/// BookingDaysPickerWidget widget.
/// {@endtemplate}
class BookingDaysPickerWidget extends StatefulWidget {
  /// {@macro booking_days_picker}
  const BookingDaysPickerWidget({
    required this.bookingDays,
    required this.scrollController,
    super.key, // ignore: unused_element
  });

  final List<DayInfo> bookingDays;
  final ScrollController scrollController;

  @override
  State<BookingDaysPickerWidget> createState() =>
      _BookingDaysPickerWidgetState();
}

class _BookingDaysPickerWidgetState extends State<BookingDaysPickerWidget> {
  int? _selectedIndex;
  @override
  void initState() {
    super.initState();

    // _controller.update(WidgetState.disabled, true);
    // log('States after disabled: ${_controller.value}');
  }

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 100,
      child: ListView.separated(
        controller: widget.scrollController,
        padding: const EdgeInsets.only(left: 12, right: 12),
        scrollDirection: Axis.horizontal,
        itemCount: widget.bookingDays.length,
        itemBuilder: (context, index) => SizedBox(
            width: 65,
            child: ButtonTest(
              onPressed: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              isSelected: index == _selectedIndex,
              child: _DayCard(dayInfo: widget.bookingDays[index], index: index),
            ),
          ),
        separatorBuilder: (context, index) =>
            const SizedBox(width: 10),
      ),
    );
}

/// {@template booking_calendar}
/// _DayCard widget.
/// {@endtemplate}
class _DayCard extends StatelessWidget {
  /// {@macro booking_calendar}
  const _DayCard({
    required this.dayInfo,
    required this.index, // ignore: unused_element
  });

  final DayInfo dayInfo;
  final int index;

  @override
  Widget build(BuildContext context) {
    final dayFormatter =
        DateFormat('EEE', Localizations.localeOf(context).languageCode);

    final int slots = dayInfo.slots.clamp(0, 10);
    final Color slotColor = switch (slots) {
      > 5 => Colors.green,
      >= 3 => Colors.orange,
      _ => Colors.red,
    };

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 15),
        UiText.bodyMedium(
          dayFormatter.format(dayInfo.date),
          color: const Color(0xFf9485BB),
        ),
        UiText.bodyLarge(
          dayInfo.date.day.toString(),
          color: const Color(0xFf9485BB),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 8,
              height: 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: slotColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 3),
            UiText.bodySmall(
              '$slots sl.',
              color: const Color(0xFf9485BB),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}

class ButtonTest extends ButtonStyleButton {
  const ButtonTest({required this.isSelected, required super.onPressed, required super.child, super.key,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus = false,
    super.clipBehavior,
  });

  final bool isSelected;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) => BaseButtonStyle(
      colorPalette: Theme.of(context).colorPalette!,
      isSelected: isSelected,
    );

  @override
  ButtonStyle? themeStyleOf(BuildContext context) => null;
}

class BaseButtonStyle extends ButtonStyle {
  const BaseButtonStyle({
    required this.colorPalette,
    required this.isSelected,
  });

  final bool isSelected;
  final ColorPalette colorPalette;

  @override
  WidgetStateProperty<EdgeInsetsGeometry?>? get padding =>
      const WidgetStatePropertyAll(EdgeInsets.zero);

  @override
  WidgetStateProperty<Color?>? get backgroundColor => WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      } else if (isSelected) {
        return const Color(0xFF463976);
      } else {
        return const Color(0xFF302C3E);
      }
    });

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape =>
      const WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))));

  @override
  WidgetStateProperty<BorderSide?>? get side => WidgetStateProperty.resolveWith((states) => BorderSide(
        color: colorPalette.primary.withAlpha(
          states.contains(WidgetState.disabled) ? 50 : 255,
        ),
        width: 1.5,
      ));

  @override
  WidgetStateProperty<Color?>? get overlayColor => WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return colorPalette.secondary;
      }
      return null;
    });

  @override
  Duration? get animationDuration => const Duration(milliseconds: 200);

  @override
  AlignmentGeometry? get alignment => Alignment.center;

  @override
  MaterialTapTargetSize? get tapTargetSize => MaterialTapTargetSize.shrinkWrap;

  @override
  WidgetStateProperty<Size?>? get minimumSize =>
      const WidgetStatePropertyAll(Size(60, 40));

  @override
  WidgetStateProperty<Size?>? get maximumSize =>
      const WidgetStatePropertyAll(Size.infinite);

  @override
  VisualDensity? get visualDensity => VisualDensity.adaptivePlatformDensity;

  @override
  WidgetStateProperty<MouseCursor?>? get mouseCursor =>
      WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      });

  @override
  WidgetStateProperty<double>? get elevation => const WidgetStatePropertyAll(0);
}
