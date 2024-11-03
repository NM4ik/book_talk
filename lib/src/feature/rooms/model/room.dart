class Room {
  const Room({
    required this.id,
    required this.capacity,
    required this.openTime,
    required this.closeTime,
    required this.avatar,
    required this.name,
  });

  final int id;
  final int capacity;
  final String openTime;
  final String closeTime;
  final String avatar;
  final String name;

  String get startToEndTime => '$openTime - $closeTime';
}
