// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

// 🌎 Project imports:
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/shared/validators/shared_validators.dart';

/// Represents the state of the user registration form.
///
/// This immutable class holds the validation status and values of the form fields,
/// as well as flags to track the form's submission process.
class UserRegistrationFormState {
  /// A flag indicating if the form is currently being submitted.
  final bool isPosting;

  /// A flag indicating if the form has been submitted at least once.
  final bool isFormPosted;

  /// A flag indicating if the entire form is valid.
  final bool isValid;

  /// The form validator for the user's name.
  final TextFormzValidator name;

  /// The form validator for the user's years.
  final IntegerFormzValidator years;

  /// Creates a [UserRegistrationFormState] instance with default values.
  const UserRegistrationFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const TextFormzValidator.pure(),
    this.years = const IntegerFormzValidator.pure(),
  });

  /// Creates a new [UserRegistrationFormState] by copying and potentially
  /// overriding existing values.
  ///
  /// This method is crucial for immutable state management, ensuring that
  /// a new state object is created with each update.
  UserRegistrationFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    TextFormzValidator? name,
    IntegerFormzValidator? years,
  }) =>
      UserRegistrationFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        name: name ?? this.name,
        years: years ?? this.years,
      );
}

/// A type definition for a callback function that updates user data.
typedef UpdateUserCallBack = Future<bool> Function(UserEntity);

/// Manages the state and logic for the user registration form.
///
/// This `StateNotifier` handles form input changes, validation, and submission.
/// It uses a `UpdateUserCallBack` to delegate the actual data update logic to a
/// higher-level provider (`UserDataNotifier`), decoupling the form from data
/// persistence.
class UserRegistrationFormNotifier extends StateNotifier<UserRegistrationFormState> {
  /// The callback function used to update user data.
  final UpdateUserCallBack updateUserCallBack;

  /// Creates a [UserRegistrationFormNotifier] instance.
  ///
  /// It requires an `updateUserCallBack` to be passed during initialization,
  /// which allows it to trigger the data update process.
  UserRegistrationFormNotifier({
    required this.updateUserCallBack,
  }) : super(const UserRegistrationFormState());

  /// Handles changes to the name field.
  ///
  /// This method creates a new `TextFormzValidator` from the input `value` and
  /// updates the state. It also re-validates the entire form after the change.
  onNameChanged(String value) {
    final newName = TextFormzValidator.dirty(value.trim());
    state = state.copyWith(
      name: newName,
      isValid: Formz.validate([newName, state.years]),
    );
  }

  /// Handles changes to the years field.
  ///
  /// This method creates a new `IntegerFormzValidator` from the input `value`
  /// and updates the state. It also re-validates the entire form after the change.
  onYearsChanged(String value) {
    final newYears = IntegerFormzValidator.dirty(value.trim());
    state = state.copyWith(
      years: newYears,
      isValid: Formz.validate([state.name, newYears]),
    );
  }

  /// Handles the form submission logic.
  ///
  /// It first triggers `_touchEveryField` to validate all fields and then,
  /// if the form is valid, it calls the `updateUserCallBack` to save the data.
  /// It manages the `isPosting` state to indicate the submission process.
  onFormSubmit() async {
    // Validate all fields before submission.
    _touchEveryField();

    if (!state.isValid) return;

    // Set `isPosting` to true to show a loading indicator.
    state = state.copyWith(
      isPosting: true,
    );

    // Call the provided callback function to update the user data.
    await updateUserCallBack(
      UserEntity(
        name: state.name.value,
        years: int.parse(state.years.value),
      ),
    );

    // Set `isPosting` back to false after the operation is complete.
    state = state.copyWith(
      isPosting: false,
    );
  }

  /// Validates all form fields and marks them as "dirty".
  ///
  /// This helper method is called on submission to ensure that all fields
  /// display their validation errors (if any) to the user.
  _touchEveryField() {
    final name = TextFormzValidator.dirty(state.name.value.trim());
    final years = IntegerFormzValidator.dirty(state.years.value.trim());

    state = state.copyWith(
      isFormPosted: true,
      name: name,
      years: years,
      isValid: Formz.validate([name, years]),
    );
  }
}

/// A Riverpod provider for the `UserRegistrationFormNotifier`.
///
/// This provider uses `StateNotifierProvider.autoDispose` to automatically
/// dispose of the notifier when it's no longer being watched, which is
/// useful for forms to prevent memory leaks. It also uses `ref.watch` to get
/// the `updateUserData` method from the `userDataProvider`, providing a
/// clean way to inject the necessary dependency.
final userRegistrationFormProvider =
    StateNotifierProvider.autoDispose<UserRegistrationFormNotifier, UserRegistrationFormState>((ref) {
  // Get the `updateUserData` function from the `UserDataNotifier`.
  final updateUserCallBack = ref.watch(userDataProvider.notifier).updateUserData;

  // Create and return the `UserRegistrationFormNotifier`.
  return UserRegistrationFormNotifier(
    updateUserCallBack: updateUserCallBack,
  );
});
