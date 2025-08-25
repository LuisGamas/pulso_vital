// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

// 🌎 Project imports:
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';

/// Represents the state of vital signs records.
///
/// This immutable class holds a list of vital signs entities, the loading status,
/// and any associated messages. It provides a structured and safe way to manage
/// the state of the vital signs data.
class VitalSignsRecordsState {
  /// The list of vital signs records.
  final List<VitalSignsEntity> vitalSignsEntity;

  /// A flag indicating if data is currently being loaded.
  final bool isLoading;

  /// A message related to the state, such as an error or a success message.
  final String message;

  /// Creates a [VitalSignsRecordsState] instance.
  ///
  /// The [vitalSignsEntity] list is required, while other parameters have
  /// default values.
  VitalSignsRecordsState({
    required this.vitalSignsEntity,
    this.isLoading = true,
    this.message = '',
  });

  /// Creates a new [VitalSignsRecordsState] by copying and potentially
  /// overriding existing values.
  ///
  /// This method is essential for immutable state management, ensuring that
  /// a new state object is created with each update.
  VitalSignsRecordsState copyWith({
    List<VitalSignsEntity>? vitalSignsEntity,
    bool? isLoading,
    String? message,
  }) =>
      VitalSignsRecordsState(
        vitalSignsEntity: vitalSignsEntity ?? this.vitalSignsEntity,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
      );
}

/// Manages the state and logic for vital signs records.
///
/// This `StateNotifier` handles the business logic for fetching and updating
/// vital signs data. It uses a `Repositories` instance to interact with the
/// data layer and updates its state accordingly.
class ViatlSignsRecordsNotifier extends StateNotifier<VitalSignsRecordsState> {
  /// The repository instance used to interact with the data layer.
  final Repositories repositories;

  /// Creates a [ViatlSignsRecordsNotifier] instance.
  ///
  /// It requires a `repositories` object to be provided. The initial state is
  /// set with an empty list of vital signs, and `_initialize` is called
  /// to fetch the records from the local data source.
  ViatlSignsRecordsNotifier({
    required this.repositories,
  }) : super(VitalSignsRecordsState(vitalSignsEntity: [])) {
    _initialize();
  }

  /// Initializes the state by fetching vital signs records if the state is in a loading state.
  void _initialize() {
    if (!state.isLoading) return;
    getVitalSignsRecords();
  }

  /// Fetches vital signs data from the local data source.
  ///
  /// This method updates the state to indicate a loading process, fetches the
  /// vital signs records from the repository, and then updates the state with
  /// the fetched data and a success message.
  Future<void> getVitalSignsRecords() async {
    try {
      state = state.copyWith(isLoading: true);
      final vitalSigns = await repositories.getVitalSignsRecords();
      state = state.copyWith(
        isLoading: false,
        vitalSignsEntity: vitalSigns,
        message: 'Vital signs history successfully retrieved!',
      );
    } catch (e) {
      errorFunction('Error retrieving user\'s vital signs');
    }
  }

  /// Updates a vital signs record in the local data source.
  ///
  /// This method attempts to update a vital signs record via the repository.
  /// It returns `true` on success, updates the state with the new record (at
  /// the beginning of the list for display), and provides a success message.
  /// On failure, it returns `false` and updates the state with an error message.
  Future<bool> updateVitalSigns(VitalSignsEntity vitalSign) async {
    try {
      state = state.copyWith(isLoading: true);
      final success = await repositories.updateVitalSigns(vitalSign);
      if (success) {
        state = state.copyWith(
          isLoading: false,
          vitalSignsEntity: [vitalSign, ...state.vitalSignsEntity],
          message: 'Vital signs successfully updated!',
        );
        return true;
      } else {
        errorFunction('Error updating user\'s vital signs');
        return false;
      }
    } catch (e) {
      errorFunction('Error updating user\'s vital signs');
      return false;
    }
  }


  /// Deletes a vital signs record by its ID.
  ///
  /// This method uses the repository to delete a record, updates the state
  /// by removing the deleted record from the list, and provides a success
  /// message. If the deletion fails, it updates the state with an error.
  Future<bool> deleteVitalSigns(Id vitalSignId) async {
    try {
      final vitalSignsRecords = state.vitalSignsEntity;
      final index = vitalSignsRecords.indexWhere((record) => record.isarId == vitalSignId);

      if (index != -1) {
        final success = await repositories.deleteVitalSigns(vitalSignId);
        
        if (success) {
          final updatedList = List<VitalSignsEntity>.from(vitalSignsRecords)
            ..removeAt(index);
          state = state.copyWith(
            vitalSignsEntity: updatedList,
            message: 'Vital signs record successfully deleted!',
          );
          return true;
        } else {
          errorFunction('Error deleting vital signs record');
          return false;
        }
      }
      return false;
    } catch (e) {
      errorFunction('Error deleting vital signs record');
      return false;
    }
  }

  /// Sets the state to an error condition.
  ///
  /// This helper method is called when an operation fails. It sets `isLoading`
  /// to `false`, clears the vital signs list, and provides an error `message`.
  void errorFunction(String message) {
    state = state.copyWith(
      isLoading: false,
      vitalSignsEntity: [],
      message: message,
    );
  }
}

/// A Riverpod provider for `ViatlSignsRecordsNotifier`.
///
/// This provider creates an instance of `ViatlSignsRecordsNotifier` and provides
/// it to the application's widgets. It watches `dashRepositoriesProvider` to
/// obtain the necessary repository dependency.
final vitalSignsRecordProvider =
    StateNotifierProvider<ViatlSignsRecordsNotifier, VitalSignsRecordsState>((ref) {
  final repositories = ref.watch(dashRepositoriesProvider);
  return ViatlSignsRecordsNotifier(
    repositories: repositories,
  );
});
