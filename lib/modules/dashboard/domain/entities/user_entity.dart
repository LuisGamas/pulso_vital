// 📦 Package imports:
import 'package:isar/isar.dart';

part 'user_entity.g.dart';

/// Represents a user entity for local data storage using the Isar database.
///
/// This class is a data model that corresponds to a collection in the Isar
/// database. It includes fields for the user's name and years, along with
/// an automatically incrementing ID for database management.
///
/// The `@collection` annotation marks this class as an Isar collection,
/// and the `part` directive links it to the generated code for database
/// operations.
@collection
class UserEntity {
  /// The unique identifier for this user entity in the Isar database.
  ///
  /// `Isar.autoIncrement` ensures that the ID is automatically generated and
  /// incremented for each new user record, making it a reliable primary key.
  Id isarId = Isar.autoIncrement;

  /// The name of the user.
  final String name;

  /// The age of the user in years.
  final int years;

  /// Creates a new [UserEntity] instance.
  ///
  /// Requires the user's [name] and [years] to be provided.
  UserEntity({
    required this.name,
    required this.years,
  });
}
