import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/shared/validators/shared_validators.dart';

class VitalSignsLogFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final bool canCloseDialog;
  final DoubleFormzValidator temperature;
  final IntegerFormzValidator bpSystolic;
  final IntegerFormzValidator bpDiastolic;
  final IntegerFormzValidator heartRate;

  VitalSignsLogFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.canCloseDialog = false,
    this.temperature = const DoubleFormzValidator.pure(),
    this.bpSystolic = const IntegerFormzValidator.pure(),
    this.bpDiastolic = const IntegerFormzValidator.pure(),
    this.heartRate = const IntegerFormzValidator.pure(),
  });

  VitalSignsLogFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    bool? canCloseDialog,
    DoubleFormzValidator? temperature,
    IntegerFormzValidator? bpSystolic,
    IntegerFormzValidator? bpDiastolic,
    IntegerFormzValidator? heartRate,
  }) => VitalSignsLogFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    canCloseDialog: canCloseDialog ?? this.canCloseDialog,
    temperature: temperature ?? this.temperature,
    bpSystolic: bpSystolic ?? this.bpSystolic,
    bpDiastolic: bpDiastolic ?? this.bpDiastolic,
    heartRate: heartRate ?? this.heartRate,
  );
}

typedef UpdateVitalSignsCallback = Future<bool> Function(VitalSignsEntity);

class VitalSignsLogFormNotifier extends StateNotifier<VitalSignsLogFormState> {
  final UpdateVitalSignsCallback updateVitalSignsCallback;

  VitalSignsLogFormNotifier({
    required this.updateVitalSignsCallback,
  }) : super(VitalSignsLogFormState());

  onTemperatureChanged(String value) {
    final newTemperature = DoubleFormzValidator.dirty(value.trim());
    state = state.copyWith(
      temperature: newTemperature,
      isValid: Formz.validate([
        newTemperature,
        state.bpSystolic,
        state.bpDiastolic,
        state.heartRate,
      ])
    );
  }

  onBpSystolicChanged(String value) {
    final newBpSystolic = IntegerFormzValidator.dirty(value.trim());
    state = state.copyWith(
      bpSystolic: newBpSystolic,
      isValid: Formz.validate([
        state.temperature,
        newBpSystolic,
        state.bpDiastolic,
        state.heartRate,
      ])
    );
  }

  onBpDiastolicChanged(String value) {
    final newBpDiastolic = IntegerFormzValidator.dirty(value.trim());
    state = state.copyWith(
      bpDiastolic: newBpDiastolic,
      isValid: Formz.validate([
        state.temperature,
        state.bpSystolic,
        newBpDiastolic,
        state.heartRate,
      ])
    );
  }

  onHeartRateChanged(String value) {
    final newHeartRate = IntegerFormzValidator.dirty(value.trim());
    state = state.copyWith(
      heartRate: newHeartRate,
      isValid: Formz.validate([
        state.temperature,
        state.bpSystolic,
        state.bpDiastolic,
        newHeartRate,
      ])
    );
  }

  onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);

    await updateVitalSignsCallback(
      VitalSignsEntity(
        createdAt: DateTime.now(),
        tempC: double.parse(state.temperature.value),
        bpSys: int.parse(state.bpSystolic.value),
        bpDia: int.parse(state.bpDiastolic.value),
        heartRate: int.parse(state.heartRate.value),
      )
    );

    state = state.copyWith(
      isPosting: false,
      canCloseDialog: true,
    );
  }

  _touchEveryField() {
    final temperature = DoubleFormzValidator.dirty(state.temperature.value.trim());
    final bpSystolic = IntegerFormzValidator.dirty(state.bpSystolic.value.trim());
    final bpDiastolic = IntegerFormzValidator.dirty(state.bpDiastolic.value.trim());
    final heartRate = IntegerFormzValidator.dirty(state.heartRate.value.trim());

    state = state.copyWith(
      isFormPosted: true,
      temperature: temperature,
      bpSystolic: bpSystolic,
      bpDiastolic: bpDiastolic,
      heartRate: heartRate,
      isValid: Formz.validate([temperature, bpSystolic, bpDiastolic, heartRate])
    );
  }
}

final vitalSignsLogFormProvider = StateNotifierProvider.autoDispose<VitalSignsLogFormNotifier, VitalSignsLogFormState>((ref) {
  final updateVitalSignsCallback = ref.watch(vitalSignsRecordProvider.notifier).updateVitalSigns;

  return VitalSignsLogFormNotifier(
    updateVitalSignsCallback: updateVitalSignsCallback,
  );
});