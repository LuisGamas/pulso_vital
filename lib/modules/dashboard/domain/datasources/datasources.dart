// 🌎 Project imports:
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';

/// An abstract class that defines the contract for all data sources.
///
/// This class acts as a blueprint for implementing different data access
/// layers, such as local databases, remote APIs, or mock data. It ensures
/// that all data sources provide a consistent set of methods for interacting
/// with user and vital signs data. This abstraction allows the repository
/// layer to be independent of the specific data source implementation.
abstract class DataSources {
  /// Retrieves the user's data.
  ///
  /// This method fetches and returns a [UserEntity] object from the data
  /// source.
  Future<UserEntity> getUserData();

  /// Updates the user's data.
  ///
  /// This method takes a [UserEntity] object and updates the corresponding
  /// data in the data source. It returns a `Future<bool>` indicating whether
  /// the update was successful.
  Future<bool> updateUserData(UserEntity user);

  /// Retrieves a list of vital signs records.
  ///
  /// This method fetches and returns a list of [VitalSignsEntity] objects from
  /// the data source.
  Future<List<VitalSignsEntity>> getVitalSignsRecords();

  /// Updates a single vital signs record.
  ///
  /// This method takes a [VitalSignsEntity] object and updates the
  /// corresponding record in the data source. It returns a `Future<bool>`
  /// indicating whether the update was successful.
  Future<bool> updateVitalSigns(VitalSignsEntity vitalSign);
}
