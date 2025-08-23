import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';

class LocalDataSourcesImpl extends DataSources {
  late Future<Isar> localDb;

  LocalDataSourcesImpl() {
    localDb = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [UserEntitySchema, VitalSignsEntitySchema],
        inspector: true,
        directory: dir.path,
      );
    } 
    return Future.value(Isar.getInstance());
  }
  
  @override
  Future<UserEntity> getUserData() async {
    try {
      final isarDb = await localDb;
      final user = await isarDb.userEntitys.where().findFirst();
      return user ?? UserEntity(
        name: 'Unknown User',
        years: 0
      );
    } catch (e) {
      throw Exception('Error getting user data');
    }
  }

  @override
  Future<bool> updateUserData(UserEntity user) async {
    try {
      final isarDb = await localDb;
      await isarDb.writeTxn(() async => isarDb.userEntitys.put(user));
      return true;
    } catch (e) {
      // throw Exception('Error updating user data');
      return false;
    }
  }
  
  @override
  Future<List<VitalSignsEntity>> getVitalSignsRecords() async {
    try {
      final isarDb = await localDb;
      return await isarDb.vitalSignsEntitys.where(sort: Sort.desc).findAll();      
    } catch (e) {
      // throw Exception('Error retrieving vital signs records: $e');
      return [];
    }
  }
  
  @override
  Future<bool> updateVitalSigns(VitalSignsEntity vitalSign) async {
    try {
      final isarDb = await localDb;
      await isarDb.writeTxn(() async => isarDb.vitalSignsEntitys.put(vitalSign));
      return true;
    } catch (e) {
      // throw Exception('Error retrieving user\'s vital signs');
      return false;
    }
  }
}