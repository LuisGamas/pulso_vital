import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';

class VitalSignsRecordsState {
  final List<VitalSignsEntity> vitalSignsEntity;
  final bool isLoading;
  final String message;

  VitalSignsRecordsState({
    required this.vitalSignsEntity,
    this.isLoading = true,
    this.message = '',
  });

  VitalSignsRecordsState copyWith({
    List<VitalSignsEntity>? vitalSignsEntity,
    bool? isLoading,
    String? message,
  }) => VitalSignsRecordsState(
    vitalSignsEntity: vitalSignsEntity ?? this.vitalSignsEntity,
    isLoading: isLoading ?? this.isLoading,
    message: message ?? this.message,
  );
}

class ViatlSignsRecordsNotifier extends StateNotifier<VitalSignsRecordsState> {
  final Repositories repositories;
  
  ViatlSignsRecordsNotifier({
    required this.repositories,
  }) : super(VitalSignsRecordsState(vitalSignsEntity: [])) {
    _initialize();
  }

  // Initialize the state if needed
  void _initialize() {
    if(!state.isLoading) return;
    getVitalSignsRecords();
  }

  // Fetch vital signs data from local data source
  Future<void> getVitalSignsRecords() async {
    try {
      state = state.copyWith(isLoading: true);
      // Fetch vital signs data from the repository
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

  // Update vital signs data in local data base
  Future<bool> updateVitalSigns(VitalSignsEntity vitalSign) async {
    try {
      state = state.copyWith(isLoading: true);
      // Update vital signs data in local data base
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

  // Handle error state
  void errorFunction(String message) {
    state = state.copyWith(
      isLoading: false,
      vitalSignsEntity: [],
      message: message,
    );
  }
}

final vitalSignsRecordProvider = StateNotifierProvider<ViatlSignsRecordsNotifier, VitalSignsRecordsState>((ref) {
  final repositories = ref.watch(dashRepositoriesProvider);
  
  return ViatlSignsRecordsNotifier(
    repositories: repositories,
  );
});