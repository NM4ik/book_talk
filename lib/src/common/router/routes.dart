import 'package:book_talk/src/feature/account/widget/account_screen.dart';
import 'package:book_talk/src/feature/auth/widget/login_screen.dart';
import 'package:book_talk/src/feature/booking/widget/booking_screen.dart';
import 'package:book_talk/src/feature/room_detail/widget/room_detail_screen.dart';
import 'package:book_talk/src/feature/rooms/widget/rooms_screen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octopus/octopus.dart';

/// Enum representing navigable routes within the app.
///
/// This enum helps manage and centralize route definitions for consistent
/// navigation handling across the app.
enum Routes with OctopusRoute {
  signin('signin', title: 'SignIn'),
  rooms('rooms', title: 'Rooms'),
  roomDetail('roomDetail', title: 'Room Detaul'),
  account('account', title: 'Account'),
  booking('booking', title: 'Booking');

  const Routes(this.name, {this.title});

  @override
  final String name;

  @override
  final String? title;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) =>
      switch (this) {
        Routes.signin => const LoginScreen(),
        Routes.rooms => const RoomsScreen(),
        Routes.account => const AccountScreen(),
        Routes.roomDetail => RoomDetailScreen(
            id: node.arguments['id'],
          ),
        Routes.booking => BookingScreen(
            roomId: int.parse(node.arguments['room-id'] as String),
          )
      };
}
