class UserEntity {
  final String id;
  final String name;
  final String email;
  final int petCount;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.petCount,
  });

  static const mock = UserEntity(
    id: '1',
    name: 'Alexandra',
    email: 'alex@example.com',
    petCount: 2,
  );
}
