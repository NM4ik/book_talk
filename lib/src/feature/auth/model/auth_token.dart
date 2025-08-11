class AuthToken {
  const AuthToken({required this.accessToken, required this.refreshToken});

  factory AuthToken.fromJson(Map<String, dynamic> json) => AuthToken(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
  );

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
