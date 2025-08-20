import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';
import 'package:pulso_vital/modules/dashboard/infrastructure/dashboard_infrastructure.dart';

final dashRepositoriesProvider = Provider<Repositories>((ref) {
  return LocalRepositoriesImpl(dataSources: LocalDataSourcesImpl());
});