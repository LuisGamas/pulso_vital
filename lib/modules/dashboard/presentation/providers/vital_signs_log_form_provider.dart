// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

// 🌎 Project imports:
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/shared/validators/shared_validators.dart';

/// Represents the state of the vital signs logging form.
///
/// This immutable class encapsulates all data and status flags for the vital signs
/// form, including the validation status of each field and the overall form.
class VitalSignsLogFormState {
  /// A flag indicating if the form is currently being submitted.
  final bool isPosting;

  /// A flag indicating if the form has been submitted at least once.
  final bool isFormPosted;

  /// A flag indicating if the entire form is valid.
  final bool isValid;

  /// A flag indicating if the dialog containing the form can be closed.
  final bool canCloseDialog;

  /// The form validator for the temperature field.
  final DoubleFormzValidator temperature;

  /// The form validator for the systolic blood pressure field.
  final IntegerFormzValidator bpSystolic;

  /// The form validator for the diastolic blood pressure field.
  final IntegerFormzValidator bpDiastolic;

  /// The form validator for the heart rate field.
  final IntegerFormzValidator heartRate;

  /// Creates a [VitalSignsLogFormState] instance with default values.
  const VitalSignsLogFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.canCloseDialog = false,
    this.temperature = const DoubleFormzValidator.pure(),
    this.bpSystolic = const IntegerFormzValidator.pure(),
    this.bpDiastolic = const IntegerFormzValidator.pure(),
    this.heartRate = const IntegerFormzValidator.pure(),
  });

  /// Creates a new [VitalSignsLogFormState] with updated values.
  ///
  /// This method enables immutable state management by returning a new instance
  /// of [VitalSignsLogFormState] with specified properties changed.
  VitalSignsLogFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    bool? canCloseDialog,
    DoubleFormzValidator? temperature,
    IntegerFormzValidator? bpSystolic,
    IntegerFormzValidator? bpDiastolic,
    IntegerFormzValidator? heartRate,
  }) =>
      VitalSignsLogFormState(
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

/// A type definition for a callback function that updates vital signs data.
typedef UpdateVitalSignsCallback = Future<bool> Function(VitalSignsEntity);

/// Manages the state and logic for the vital signs logging form.
///
/// This `StateNotifier` handles the form's input changes, validation, and submission.
/// It uses an `UpdateVitalSignsCallback` to delegate the data update logic to a
/// higher-level provider, separating the form's concerns from data persistence.
class VitalSignsLogFormNotifier extends StateNotifier<VitalSignsLogFormState> {
  /// The callback function used to update vital signs data.
  final UpdateVitalSignsCallback updateVitalSignsCallback;

  /// Creates a [VitalSignsLogFormNotifier] instance.
  ///
  /// It requires an `updateVitalSignsCallback` to be provided, which is used
  /// to save the form data.
  VitalSignsLogFormNotifier({
    required this.updateVitalSignsCallback,
  }) : super(const VitalSignsLogFormState());

  /// Handles changes to the temperature field.
  ///
  /// This method updates the state with the new temperature value and
  /// re-validates the entire form.
  onTemperatureChanged(String value) {
    final newTemperature = DoubleFormzValidator.dirty(value.trim());
    state = state.copyWith(
      temperature: newTemperature,
      isValid: Formz.validate([
        newTemperature,
        state.bpSystolic,
        state.bpDiastolic,
        state.heartRate,
      ]),
    );
  }

  /// Handles changes to the systolic blood pressure field.
  ///
  /// Updates the state and re-validates the form based on the new input.
  onBpSystolicChanged(String value) {
    final newBpSystolic = IntegerFormzValidator.dirty(value.trim());
    state = state.copyWith(
      bpSystolic: newBpSystolic,
      isValid: Formz.validate([
        state.temperature,
        newBpSystolic,
        state.bpDiastolic,
        state.heartRate,
      ]),
    );
  }

  /// Handles changes to the diastolic blood pressure field.
  ///
  /// Updates the state and re-validates the form based on the new input.
  onBpDiastolicChanged(String value) {
    final newBpDiastolic = IntegerFormzValidator.dirty(value.trim());
    state = state.copyWith(
      bpDiastolic: newBpDiastolic,
      isValid: Formz.validate([
        state.temperature,
        state.bpSystolic,
        newBpDiastolic,
        state.heartRate,
      ]),
    );
  }

  /// Handles changes to the heart rate field.
  ///
  /// Updates the state and re-validates the form based on the new input.
  onHeartRateChanged(String value) {
    final newHeartRate = IntegerFormzValidator.dirty(value.trim());
    state = state.copyWith(
      heartRate: newHeartRate,
      isValid: Formz.validate([
        state.temperature,
        state.bpSystolic,
        state.bpDiastolic,
        newHeartRate,
      ]),
    );
  }

  /// Submits the vital signs form.
  ///
  /// This method validates all form fields, sets the `isPosting` state to
  /// `true`, calls the `updateVitalSignsCallback` to save the data, and then
  /// updates the state to indicate completion and allow the dialog to be closed.
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
      ),
    );

    state = state.copyWith(
      isPosting: false,
      canCloseDialog: true,
    );
  }

  /// Validates all form fields and marks them as "dirty".
  ///
  /// This helper method is called on submission to ensure that all fields
  /// display their validation errors to the user.
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
      isValid: Formz.validate([temperature, bpSystolic, bpDiastolic, heartRate]),
    );
  }
}

/// A Riverpod provider for the `VitalSignsLogFormNotifier`.
///
/// This provider uses `StateNotifierProvider.autoDispose` for automatic disposal
/// and injects the `updateVitalSigns` method from the `vitalSignsRecordProvider`
/// as a dependency.
final vitalSignsLogFormProvider =
    StateNotifierProvider.autoDispose<VitalSignsLogFormNotifier, VitalSignsLogFormState>((ref) {
  final updateVitalSignsCallback = ref.watch(vitalSignsRecordProvider.notifier).updateVitalSigns;

  return VitalSignsLogFormNotifier(
    updateVitalSignsCallback: updateVitalSignsCallback,
  );
});
