import 'package:book_talk/l10n/app_localizations.dart';
import 'package:book_talk/src/feature/room_detail/bloc/room_detail_bloc.dart';
import 'package:book_talk/src/feature/room_detail/widget/room_detail_scope.dart';
import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomCapacitySelector extends StatefulWidget {
  const RoomCapacitySelector({super.key});

  @override
  State<RoomCapacitySelector> createState() => _RoomCapacitySelectorState();
}

class _RoomCapacitySelectorState extends State<RoomCapacitySelector> {
  final _capacityTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _capacityTextEditingController.text =
        RoomDetailScope.of(context, listen: false)
            .state
            .room
            .capacity
            .toString();
  }

  @override
  void dispose() {
    _capacityTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final roomDetailBloc = RoomDetailScope.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiText.labelMedium(AppLocalizations.of(context)!.roomCapacityNumber),
        UiDivider(margin: const EdgeInsets.only(bottom: 5)),
        BlocBuilder<RoomDetailBloc, RoomDetailState>(
          bloc: roomDetailBloc,
          buildWhen: (previous, current) {
            if (previous.room.capacity != current.room.capacity) {
              _capacityTextEditingController.text =
                  current.room.capacity.toString();

              return true;
            }

            return false;
          },
          builder: (context, state) {
            final capacity = state.room.capacity;

            return Row(
              children: [
                UiButton.filledDesctructive(
                  onPressed: () => _changeCapacity(
                    roomDetailBloc,
                    capacity - 1,
                  ),
                  label: const Icon(Icons.remove),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 50,
                    child: UiTextField.standart(
                      controller: _capacityTextEditingController,
                      edgeInsets: const EdgeInsets.symmetric(vertical: 18),
                      maxLength: 4,
                      textAlign: TextAlign.center,
                      onChanged: (value) => _changeCapacity(
                          roomDetailBloc, int.tryParse(value) ?? 0),
                      buildCounter: (
                        p0, {
                        required currentLength,
                        required isFocused,
                        required maxLength,
                      }) =>
                          const SizedBox.shrink(),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
                UiButton.filledPrimary(
                  onPressed: () =>
                      _changeCapacity(roomDetailBloc, capacity + 1),
                  label: const Icon(Icons.add),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _changeCapacity(RoomDetailBloc roomDetailBloc, int capacity) {
    roomDetailBloc.add(RoomDetailEvent.changeCapacity(count: capacity));
  }
}
