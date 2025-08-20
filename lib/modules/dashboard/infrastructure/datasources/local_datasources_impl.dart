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
        [UserEntitySchema],
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
      if (user != null) {
        return (user);
      } else {
        return (
          UserEntity(
            name: 'Unknown User',
            years: 0
          )
        );
      }
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
}