// 📦 Package imports:
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// 🌎 Project imports:
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';

/// An implementation of the [DataSources] abstract class for local data storage.
///
/// This class uses the **Isar database** to handle local data operations. It
/// provides concrete implementations for fetching and updating user data and
/// vital signs records, ensuring data persistence on the device.
class LocalDataSourcesImpl extends DataSources {
  /// A late-initialized `Future` that holds the instance of the Isar database.
  ///
  /// This field ensures that the database is opened asynchronously and only once,
  /// with the instance being ready when needed for read/write operations.
  late Future<Isar> localDb;

  /// Constructs an instance of [LocalDataSourcesImpl] and initializes the database.
  LocalDataSourcesImpl() {
    localDb = openDB();
  }

  /// Opens the Isar database and returns a `Future` with the instance.
  ///
  /// This method checks if an instance of the database already exists. If not,
  /// it opens a new one with the specified schemas and directory. Otherwise,
  /// it returns the existing instance to prevent multiple database connections.
  /// It's a critical step for managing the database lifecycle.
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    // Check if an Isar instance is already open.
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        // Define the database schemas to be used.
        [UserEntitySchema, VitalSignsEntitySchema],
        // Enable the Isar inspector for debugging.
        inspector: true,
        // Set the directory for the database files.
        directory: dir.path,
      );
    }
    // Return the existing instance if available.
    return Future.value(Isar.getInstance());
  }

  @override
  Future<UserEntity> getUserData() async {
    try {
      final isarDb = await localDb;
      // Find the first user record in the database.
      final user = await isarDb.userEntitys.where().findFirst();
      // Return the found user or a default "Unknown User" if none exists.
      return user ??
          UserEntity(
            name: 'Unknown User',
            years: 0,
          );
    } catch (e) {
      // Re-throw the exception with a specific error message for clarity.
      throw Exception('Error getting user data');
    }
  }

  @override
  Future<bool> updateUserData(UserEntity user) async {
    try {
      final isarDb = await localDb;
      // Use a write transaction to safely add or update the user record.
      await isarDb.writeTxn(() async => isarDb.userEntitys.put(user));
      return true;
    } catch (e) {
      // Return `false` on failure to indicate that the update did not succeed.
      // The commented `throw` can be used for more detailed error handling.
      // throw Exception('Error updating user data');
      return false;
    }
  }

  @override
  Future<List<VitalSignsEntity>> getVitalSignsRecords() async {
    try {
      final isarDb = await localDb;
      // Retrieve all vital signs records and sort them in descending order.
      return await isarDb.vitalSignsEntitys.where().sortByCreatedAtDesc().findAll();
    } catch (e) {
      // Return an empty list on failure to prevent app crashes.
      // The commented `throw` can be used for more detailed error handling.
      // throw Exception('Error retrieving vital signs records: $e');
      return [];
    }
  }

  @override
  Future<bool> updateVitalSigns(VitalSignsEntity vitalSign) async {
    try {
      final isarDb = await localDb;
      // Use a write transaction to safely add or update a vital signs record.
      await isarDb.writeTxn(() async => isarDb.vitalSignsEntitys.put(vitalSign));
      return true;
    } catch (e) {
      // Return `false` on failure to indicate that the update did not succeed.
      // The commented `throw` can be used for more detailed error handling.
      // throw Exception('Error retrieving user\'s vital signs');
      return false;
    }
  }

  @override
  Future<bool> deleteVitalSigns(Id vitalSignId) async {
    try {
      final isarDb = await localDb;
      // Use a write transaction to safely delete the vital signs record.
      final success = await isarDb.writeTxn(() async {
        return await isarDb.vitalSignsEntitys.delete(vitalSignId);
      });
      return success;
    } catch (e) {
      // Return `false` on failure.
      return false;
    }
  }
}
