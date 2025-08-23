import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';

class LocalRepositoriesImpl extends Repositories {
  final DataSources dataSources;

  LocalRepositoriesImpl({required this.dataSources});

  @override
  Future<UserEntity> getUserData() {
    return dataSources.getUserData();
  }

  @override
  Future<bool> updateUserData(UserEntity user) {
    return dataSources.updateUserData(user);
  }
  
  @override
  Future<List<VitalSignsEntity>> getVitalSignsRecords() {
    return dataSources.getVitalSignsRecords();
  }
  
  @override
  Future<bool> updateVitalSigns(VitalSignsEntity vitalSign) {
    return dataSources.updateVitalSigns(vitalSign);
  }

}