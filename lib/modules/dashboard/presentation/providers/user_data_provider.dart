// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dash_repositories_provider.dart';

/// Represents the state of the user data.
///
/// This class encapsulates all relevant data and status flags related to the user,
/// such as the user's entity, loading status, registration status, and any
/// associated messages. It provides an immutable way to manage state changes.
class UserDataState {
  /// The user's data entity.
  final UserEntity userEntity;

  /// A flag indicating if data is currently being loaded.
  final bool isLoading;

  /// A flag indicating if the user is registered.
  final bool isRegistered;

  /// A message related to the state, such as an error or success message.
  final String message;

  /// Creates a [UserDataState] instance.
  ///
  /// The [userEntity] is required, while other parameters have default values.
  UserDataState({
    required this.userEntity,
    this.isLoading = true,
    this.isRegistered = false,
    this.message = '',
  });

  /// Creates a new [UserDataState] with updated values.
  ///
  /// This method enables immutable state management by returning a new instance
  /// of [UserDataState] with some or all of its properties changed.
  UserDataState copyWith({
    UserEntity? userEntity,
    bool? isLoading,
    bool? isRegistered,
    String? message,
  }) {
    return UserDataState(
      userEntity: userEntity ?? this.userEntity,
      isLoading: isLoading ?? this.isLoading,
      isRegistered: isRegistered ?? this.isRegistered,
      message: message ?? this.message,
    );
  }
}

/// Manages the state for user data.
///
/// `UserDataNotifier` is a `StateNotifier` that handles the business logic
/// for fetching, updating, and managing the user's data. It communicates with
/// the repository layer to perform data operations and updates its state
/// accordingly.
class UserDataNotifier extends StateNotifier<UserDataState> {
  /// The repository instance used to interact with the data layer.
  final Repositories repositories;

  /// Creates a [UserDataNotifier] instance.
  ///
  /// The `repositories` object is provided via dependency injection. The initial
  /// state is set to a default anonymous user, and `_initialize` is called
  /// to fetch the user's data from the local source.
  UserDataNotifier({
    required this.repositories,
  }) : super(UserDataState(
          userEntity: UserEntity(
            name: 'Usuario anónimo',
            years: 0,
          ),
        )) {
    _initialize();
  }

  /// Initializes the state by fetching local user data if the user is not yet registered.
  void _initialize() {
    if (state.isRegistered) return;
    getLocalUserData();
  }

  /// Fetches user data from the local data source.
  ///
  /// This method updates the state to indicate a loading process, fetches the
  /// user entity from the repository, and then updates the state with the
  /// fetched data and registration status.
  Future<void> getLocalUserData() async {
    try {
      state = state.copyWith(isLoading: true);
      final user = await repositories.getUserData();
      state = state.copyWith(
        userEntity: user,
        isLoading: false,
        isRegistered: user.years != 0,
      );
    } catch (e) {
      errorFunction('Error getting user data');
    }
  }

  /// Updates user data in the local data source.
  ///
  /// This method attempts to update the user's information via the repository.
  /// It returns `true` on success and updates the state with the new user data
  /// and a success message. On failure, it returns `false` and updates the
  /// state with an error message.
  Future<bool> updateUserData(UserEntity user) async {
    try {
      state = state.copyWith(isLoading: true);
      final success = await repositories.updateUserData(user);
      if (success) {
        state = state.copyWith(
          userEntity: user,
          isLoading: false,
          message: 'User data updated successfully',
          isRegistered: user.years != 0,
        );
        return true;
      } else {
        errorFunction('Error updating user data');
        return false;
      }
    } catch (e) {
      errorFunction('Error updating user data');
      return false;
    }
  }

  /// Sets the state to an error condition.
  ///
  /// This helper method is called when an operation fails. It sets `isLoading`
  /// to false, provides an error `message`, and sets `isRegistered` to false.
  void errorFunction(String message) {
    state = state.copyWith(
      isLoading: false,
      message: message,
      isRegistered: false,
    );
  }
}

/// A Riverpod provider for `UserDataNotifier`.
///
/// This provider creates an instance of `UserDataNotifier` and provides it
/// to the application's widgets. It watches `dashRepositoriesProvider` to
/// obtain the necessary repository dependency.
final userDataProvider = StateNotifierProvider<UserDataNotifier, UserDataState>((ref) {
  final repositories = ref.watch(dashRepositoriesProvider);
  return UserDataNotifier(
    repositories: repositories,
  );
});
