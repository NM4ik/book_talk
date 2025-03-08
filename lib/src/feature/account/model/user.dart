class User {
  const User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.theme,
  });

  final String email;
  final String firstName;
  final String lastName;
  final UserTheme theme;

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.firstName == firstName &&
        other.theme == theme &&
        other.lastName == lastName;
  }

  @override
  int get hashCode => Object.hashAll([email, firstName, theme, lastName]);

  @override
  String toString() =>
      'User(email: $email, firstName: $firstName, lastName: $lastName, theme: $theme)';
}

enum UserTheme {
  light,
  dark,
  system,
}
