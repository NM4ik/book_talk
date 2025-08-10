class Token {
  const Token({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;

  @override
  String toString() =>
      'Token(accessToken: $accessToken, refreshToken: $refreshToken)';
}
