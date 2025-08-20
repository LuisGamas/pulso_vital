import 'package:isar/isar.dart';

part 'user_entity.g.dart';

@collection
class UserEntity {
  Id isarId = Isar.autoIncrement;
  final String name;
  final int years;

  UserEntity({
    required this.name,
    required this.years,
  });
}