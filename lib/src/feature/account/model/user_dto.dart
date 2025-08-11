import 'package:book_talk/src/feature/account/model/user.dart';

class UserDto {
  const UserDto._({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.theme,
  });

  factory UserDto.fromJson(Map<String, Object?> json) => UserDto._(
    email: json['email']! as String,
    firstName: json['firstName']?.toString(),
    lastName: json['lastName']?.toString(),
    theme: json['theme']?.toString(),
  );

  final String email;
  final String? firstName;
  final String? lastName;
  final String? theme;

  User toEntity() => User(
    email: email,
    firstName: firstName ?? '',
    lastName: lastName ?? '',
    theme: switch (theme) {
      'Light' => UserTheme.light,
      'System' => UserTheme.system,
      _ => UserTheme.dark,
    },
  );
}
