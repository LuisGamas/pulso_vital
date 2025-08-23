// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';
import 'package:pulso_vital/modules/dashboard/infrastructure/dashboard_infrastructure.dart';

/// A Riverpod provider that creates and provides an instance of [Repositories].
///
/// This provider is configured to use the [LocalRepositoriesImpl] which, in
/// turn, uses the [LocalDataSourcesImpl]. This setup demonstrates the use of
/// dependency injection to manage the application's data layer. By providing
/// the repository and its data source through Riverpod, the application's
/// business logic can easily access and interact with the data without needing
/// to know the underlying implementation details.
final dashRepositoriesProvider = Provider<Repositories>((ref) {
  // Returns a new instance of `LocalRepositoriesImpl`.
  // The `LocalDataSourcesImpl` is passed as a dependency, completing the
  // dependency injection chain.
  return LocalRepositoriesImpl(dataSources: LocalDataSourcesImpl());
});
