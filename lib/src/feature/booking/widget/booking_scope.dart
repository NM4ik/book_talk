import 'package:book_talk/common.dart';
import 'package:book_talk/src/feature/booking/bloc/booking_bloc.dart';
import 'package:book_talk/src/feature/booking/data/booking_datasource.dart';
import 'package:book_talk/src/feature/booking/data/booking_repository.dart';
import 'package:flutter/widgets.dart';

/// {@template booking_scope}
/// BookingScope widget.
/// {@endtemplate}
class BookingScope extends StatefulWidget {
  /// {@macro booking_scope}
  const BookingScope({
    required this.child,
    super.key, // ignore: unused_element
  });

  final Widget child;

  static BookingBloc of(BuildContext context) =>
      context.inheritedOf<_InheritedBookingScope>().bookingBloc;

  @override
  State<BookingScope> createState() => _BookingScopeState();
}

/// State for widget BookingScope.
class _BookingScopeState extends State<BookingScope> {
  late final BookingBloc _bookingBloc;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _bookingBloc = BookingBloc(
      bookingRepository: BookingRepositoryImpl(
        bookingDataSource: BookingDatasourceImpl(),
      ),
    )..add(const BookingEvent.load());
  }

  @override
  void dispose() {
    _bookingBloc.close();
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => _InheritedBookingScope(
        bookingBloc: _bookingBloc,
        child: widget.child,
      );
}

/// {@template booking_scope}
/// _InheritedBookingScope widget.
/// {@endtemplate}
class _InheritedBookingScope extends InheritedWidget {
  /// {@macro booking_scope}
  const _InheritedBookingScope({
    required super.child,
    required this.bookingBloc, // ignore: unused_element
  });

  final BookingBloc bookingBloc;

  @override
  bool updateShouldNotify(covariant _InheritedBookingScope oldWidget) => false;
}
