// 🌎 Project imports:
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';

/// A concrete implementation of the [Repositories] abstract class.
///
/// This class acts as a data access layer, specifically for a local data source.
/// It implements the repository contract by delegating all method calls directly
/// to an instance of a [DataSources]. This separation of concerns ensures that
/// the business logic remains independent of the data source's implementation
/// details.
class LocalRepositoriesImpl extends Repositories {
  /// The local data source used by this repository.
  ///
  /// This field holds a reference to the data source, allowing the repository
  /// to fetch and update data.
  final DataSources dataSources;

  /// Creates an instance of [LocalRepositoriesImpl].
  ///
  /// Requires a [dataSources] object to be provided, which is used to
  /// handle the actual data operations.
  LocalRepositoriesImpl({required this.dataSources});

  /// Retrieves the user's data from the local data source.
  ///
  /// This method simply forwards the request to the `getUserData` method of
  /// the injected [dataSources] instance.
  @override
  Future<UserEntity> getUserData() {
    return dataSources.getUserData();
  }

  /// Updates the user's data in the local data source.
  ///
  /// This method forwards the user data update request to the `updateUserData`
  /// method of the injected [dataSources] instance.
  @override
  Future<bool> updateUserData(UserEntity user) {
    return dataSources.updateUserData(user);
  }

  /// Retrieves a list of vital signs records from the local data source.
  ///
  /// This method forwards the request to the `getVitalSignsRecords` method of
  /// the injected [dataSources] instance.
  @override
  Future<List<VitalSignsEntity>> getVitalSignsRecords() {
    return dataSources.getVitalSignsRecords();
  }

  /// Updates a single vital signs record in the local data source.
  ///
  /// This method forwards the vital sign update request to the `updateVitalSigns`
  /// method of the injected [dataSources] instance.
  @override
  Future<bool> updateVitalSigns(VitalSignsEntity vitalSign) {
    return dataSources.updateVitalSigns(vitalSign);
  }
}
