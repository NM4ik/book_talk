// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Rooms`
  String get roomsTitle {
    return Intl.message('Rooms', name: 'roomsTitle', desc: '', args: []);
  }

  /// `There are no rooms for booking yet`
  String get noRoomsForBooking {
    return Intl.message(
      'There are no rooms for booking yet',
      name: 'noRoomsForBooking',
      desc: '',
      args: [],
    );
  }

  /// `Room capacity`
  String get roomCapacityNumber {
    return Intl.message(
      'Room capacity',
      name: 'roomCapacityNumber',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message('Title', name: 'title', desc: '', args: []);
  }

  /// `Room is active`
  String get roomIsActiveStatus {
    return Intl.message(
      'Room is active',
      name: 'roomIsActiveStatus',
      desc: '',
      args: [],
    );
  }

  /// `Edit Room`
  String get roomEditTitle {
    return Intl.message('Edit Room', name: 'roomEditTitle', desc: '', args: []);
  }

  /// `Create Room`
  String get roomCreateTitle {
    return Intl.message(
      'Create Room',
      name: 'roomCreateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select image`
  String get roomSelectImage {
    return Intl.message(
      'Select image',
      name: 'roomSelectImage',
      desc: '',
      args: [],
    );
  }

  /// `Room not found`
  String get roomNotFound {
    return Intl.message(
      'Room not found',
      name: 'roomNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't get a schedule`
  String get bookingSheduleError {
    return Intl.message(
      'Couldn\'t get a schedule',
      name: 'bookingSheduleError',
      desc: '',
      args: [],
    );
  }

  /// `Try again or come back later`
  String get retryOrLater {
    return Intl.message(
      'Try again or come back later',
      name: 'retryOrLater',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message('Try again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Something went wrong`
  String get errorSomethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'errorSomethingWentWrong',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
