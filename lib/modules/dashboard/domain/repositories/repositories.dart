// 📦 Package imports:
import 'package:isar/isar.dart';

// 🌎 Project imports:
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';

/// An abstract class that defines the contract for all repositories.
///
/// This class acts as an abstraction layer between the application's business
/// logic and the data sources. Its purpose is to encapsulate the logic for
/// fetching and updating data, regardless of where the data originates
/// (e.g., a local database, a remote API, or a cache). By adhering to this
/// interface, the application's use cases and services remain independent of
/// the underlying data implementation details.
abstract class Repositories {
  /// Retrieves the user's data.
  ///
  /// This method coordinates with a data source to fetch the user's information
  /// and returns it as a [UserEntity].
  Future<UserEntity> getUserData();

  /// Updates the user's data.
  ///
  /// This method handles the logic for persisting changes to a user's data.
  /// It takes a [UserEntity] and returns a `Future<bool>` indicating whether
  /// the update was successful.
  Future<bool> updateUserData(UserEntity user);

  /// Retrieves a list of vital signs records.
  ///
  /// This method fetches a collection of vital signs data and provides it
  /// as a list of [VitalSignsEntity] objects.
  Future<List<VitalSignsEntity>> getVitalSignsRecords();

  /// Updates a single vital signs record.
  ///
  /// This method takes a [VitalSignsEntity] object and updates the record
  /// in the data layer. It returns a `Future<bool>` indicating the success
  /// of the operation.
  Future<bool> updateVitalSigns(VitalSignsEntity vitalSign);

  /// Deletes a vital signs record by its unique ID.
  ///
  /// This method takes an `Id` (Isar's primary key type) and removes the
  /// corresponding vital signs record from the data source. It returns
  /// `Future<bool>` indicating whether the deletion was successful.
  Future<bool> deleteVitalSigns(Id vitalSignId);
}
