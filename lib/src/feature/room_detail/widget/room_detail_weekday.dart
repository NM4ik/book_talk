import 'package:book_talk/src/common/model/room/room_day_setting.dart';
import 'package:book_talk/src/common/widgets/overlay_popup.dart';
import 'package:book_talk/src/feature/room_detail/bloc/room_detail_bloc.dart';
import 'package:book_talk/src/feature/room_detail/widget/room_detail_scope.dart';
import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomDetailWeekdayWidget extends StatelessWidget {
  const RoomDetailWeekdayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final roomDetailBloc = RoomDetailScope.of(context);

    return BlocBuilder<RoomDetailBloc, RoomDetailState>(
      bloc: roomDetailBloc,
      buildWhen: (previous, current) =>
          previous.room.roomWeekSettings != current.room.roomWeekSettings,
      builder: (context, state) {
        final weekSettings = state.room.roomWeekSettings;

        return Column(
          children: [
            for (final day in weekSettings.days)
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: _RoomWeekdayCard(key: ValueKey(day.day), day: day),
              ),
          ],
        );
      },
    );
  }
}

class _RoomWeekdayCard extends StatelessWidget {
  const _RoomWeekdayCard({required this.day, super.key});

  final RoomWeekdaySetting day;

  @override
  Widget build(BuildContext context) {
    final roomDetailBloc = RoomDetailScope.of(context);
    final isActive = day.isActive;
    final dayName = day.day;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isActive
                  ? UiText.labelMedium(key: ValueKey(isActive), dayName)
                  : UiText.labelMedium(
                      dayName,
                      color: Theme.of(context).colorPalette?.muted,
                    ),
            ),
            const SizedBox(width: 5),
            _DayActiveCheckbox(
              isActive: isActive,
              onTap: ({value}) =>
                  _onActiveChange(roomDetailBloc: roomDetailBloc, value: value),
            ),
          ],
        ),
        const SizedBox(height: 5),
        AbsorbPointer(
          absorbing: !isActive,
          child: Row(
            children: [
              _DayTimeButton(
                onTimeChanged: (time) {
                  _onTimeChange(
                    time: time,
                    roomDetailBloc: roomDetailBloc,
                    isStartTimeChange: true,
                  );
                },
                timeOfDay: day.startTime,
                isEndDay: false,
              ),
              const SizedBox(width: 10),
              _DayTimeButton(
                onTimeChanged: (time) {
                  _onTimeChange(time: time, roomDetailBloc: roomDetailBloc);
                },
                timeOfDay: day.endTime,
                isEndDay: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onTimeChange({
    required TimeOfDay time,
    required RoomDetailBloc roomDetailBloc,
    bool isStartTimeChange = false,
  }) {
    roomDetailBloc.add(
      RoomDetailEvent.changeTime(
        day: day,
        hour: time.hour,
        minute: time.minute,
        isStartTimeChange: isStartTimeChange,
      ),
    );
  }

  void _onActiveChange({
    required bool? value,
    required RoomDetailBloc roomDetailBloc,
  }) {
    roomDetailBloc.add(
      RoomDetailEvent.changeDayActive(day: day, value: value ?? false),
    );
  }
}

class _DayTimeButton extends StatefulWidget {
  const _DayTimeButton({
    required this.onTimeChanged,
    required this.timeOfDay,
    required this.isEndDay,
  });

  final void Function(TimeOfDay) onTimeChanged;
  final TimeOfDay timeOfDay;
  final bool isEndDay;

  @override
  State<_DayTimeButton> createState() => _DayTimeButtonState();
}

class _DayTimeButtonState extends State<_DayTimeButton> {
  final _overlayPopup = OverlayPopup();

  @override
  void dispose() {
    _overlayPopup.removeHighlightOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => UiButton.negativePrimary(
    onPressed: () {
      _overlayPopup.createCalendarOverlay(
        context,
        child: _DayTimePicker(
          onTap: (time) {
            _overlayPopup.removeHighlightOverlay();
            widget.onTimeChanged(time);
          },
        ),
      );
    },
    innerPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
    label: Row(
      children: [
        Icon(
          Icons.access_time_rounded,
          size: 18,
          color: Theme.of(context).colorPalette?.muted,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiText.labelSmall(widget.isEndDay ? 'End with' : 'Start with'),
              const SizedBox(height: 2),
              UiText.labelMedium(widget.timeOfDay.format(context)),
            ],
          ),
        ),
        Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 18,
          color: Theme.of(context).colorPalette?.muted,
        ),
      ],
    ),
  );
}

class _DayActiveCheckbox extends StatelessWidget {
  const _DayActiveCheckbox({required this.isActive, required this.onTap});
  final bool isActive;
  final void Function({bool? value}) onTap;

  @override
  Widget build(BuildContext context) => Checkbox(
    value: isActive,
    onChanged: (value) => onTap(value: value),
  );
}

class _DayTimePicker extends StatelessWidget {
  const _DayTimePicker({required this.onTap});

  final void Function(TimeOfDay time) onTap;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: Theme.of(context).colorPalette?.secondary ?? Colors.transparent,
    child: ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 3),
      itemCount: 48,
      itemBuilder: (context, index) {
        final hour = index ~/ 2;
        final minutes = (index % 2) * 30;
        final timeText =
            '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: UiButton.filledPrimary(
            innerPadding: EdgeInsets.zero,
            onPressed: () => onTap(TimeOfDay(hour: hour, minute: minutes)),
            label: UiText.bodyMedium(timeText),
          ),
        );
      },
    ),
  );
}
