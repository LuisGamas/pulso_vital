import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dash_repositories_provider.dart';

class UserDataState {
  final UserEntity userEntity;
  final bool isLoading;
  final String message;

  UserDataState({
    required this.userEntity,
    this.isLoading = true,
    this.message = '',
  });

  UserDataState copyWith({
    UserEntity? userEntity,
    bool? isLoading,
    String? message,
  }) {
    return UserDataState(
      userEntity: userEntity ?? this.userEntity,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
    );
  }
}

class UserDataNotifier extends StateNotifier<UserDataState> {
  final Repositories repositories;

  UserDataNotifier({
    required this.repositories,
  }) : super(UserDataState(
    userEntity: UserEntity(
      name: 'Usuario anónimo',
      years: 00,
    )
  )) {
    _initialize();
  }

  // Initialize the state if needed
  void _initialize() {
    if(!state.isLoading) return;
    getLocalUserData();
  }

  // Fetch user data from local data source
  Future<void> getLocalUserData() async {
    try {
      state = state.copyWith(isLoading: true);
      // Fetch user data from the repository
      final user = await repositories.getUserData();
      state = state.copyWith(
        userEntity: user,
        isLoading: false,
      );
      
    } catch (e) {
      errorFunction('Error getting user data');
    }
  }

  // Update user data in local data source
  Future<bool> updateUserData(UserEntity user) async {
    try {
      state = state.copyWith(isLoading: true);
      final success = await repositories.updateUserData(user);
      if (success) {
        state = state.copyWith(
          userEntity: user,
          isLoading: false,
          message: 'User data updated successfully',
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

  // Handle error state
  void errorFunction(String message) {
    state = state.copyWith(
      isLoading: false,
      message: message,
    );
  }
}

final userDataProvider = StateNotifierProvider<UserDataNotifier, UserDataState>((ref) {
  final repositories = ref.watch(dashRepositoriesProvider);
  
  return UserDataNotifier(
    repositories: repositories,
  );
});