class AuthToken {
  const AuthToken({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  final String accessToken;
  final String refreshToken;

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };

  @override
  String toString() =>
      'AuthToken(accessToken: $accessToken, refreshToken: $refreshToken)';
}
