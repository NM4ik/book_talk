class User {
  const User({
    required this.id,
    required this.name,
    required this.avatar,
  });
  final String id;
  final String name;
  final String avatar;

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.avatar == avatar;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ avatar.hashCode;

  @override
  String toString() => 'User(id: $id, name: $name, avatar: $avatar)';
}
