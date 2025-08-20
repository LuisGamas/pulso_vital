import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';

abstract class DataSources {
  Future<UserEntity> getUserData();
  Future<bool> updateUserData(UserEntity user);
}