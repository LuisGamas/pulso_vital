import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/shared/validators/shared_validators.dart';

class UserRegistrationFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final NameValidator name;
  final YearsValidator years;

  UserRegistrationFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const NameValidator.pure(),
    this.years = const YearsValidator.pure(),
  });

  UserRegistrationFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    NameValidator? name,
    YearsValidator? years,
  }) => UserRegistrationFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    name: name ?? this.name,
    years: years ?? this.years,
  );
}

typedef UpdateUserCallBack = Future<bool> Function(UserEntity);

class UserRegistrationFormNotifier extends StateNotifier<UserRegistrationFormState> {
  final UpdateUserCallBack updateUserCallBack;

  UserRegistrationFormNotifier({
    required this.updateUserCallBack,
  }) : super(UserRegistrationFormState());

  onNameChanged(String value) {
    final newName = NameValidator.dirty(value.trim());
    state = state.copyWith(
      name: newName,
      isValid: Formz.validate([newName, state.years])
    );
  }

  onYearsChanged(String value) {
    final newYears = YearsValidator.dirty(value.trim());
    state = state.copyWith(
      years: newYears,
      isValid: Formz.validate([state.name, newYears])
    );
  }

  onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    state = state.copyWith(
      isPosting: true,
    );

    await updateUserCallBack(
      UserEntity(
        name: state.name.value,
        years: int.parse(state.years.value),
      )
    );

    state = state.copyWith(
      isPosting: false,
    );


  }

  _touchEveryField() {
    final name = NameValidator.dirty(state.name.value.trim());
    final years = YearsValidator.dirty(state.years.value.trim());

    state = state.copyWith(
      isFormPosted: true,
      name: name,
      years: years,
      isValid: Formz.validate([name, years])
    );
  }

}

final userRegistrationFormProvider = StateNotifierProvider.autoDispose<UserRegistrationFormNotifier, UserRegistrationFormState>((ref) {
  final updateUserCallBack = ref.watch(userDataProvider.notifier).updateUserData;

  return UserRegistrationFormNotifier(
    updateUserCallBack: updateUserCallBack,
  );  
});