// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get roomsTitle => 'Rooms';

  @override
  String get noRoomsForBooking => 'There are no rooms for booking yet';

  @override
  String get roomCapacityNumber => 'Room capacity';

  @override
  String get title => 'Title';

  @override
  String get roomIsActiveStatus => 'Room is active';

  @override
  String get roomEditTitle => 'Edit Room';

  @override
  String get roomCreateTitle => 'Create Room';

  @override
  String get roomSelectImage => 'Select image';

  @override
  String get roomNotFound => 'Room not found';

  @override
  String get bookingSheduleError => 'Couldn\'t get a schedule';

  @override
  String get retryOrLater => 'Try again or come back later';

  @override
  String get tryAgain => 'Try again';

  @override
  String get errorSomethingWentWrong => 'Something went wrong';
}
