// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:pulso_vital/config/config.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/shared/widgets/shared_widgets.dart';

/// A dialog widget to prompt the user for registration.
///
/// This dialog is shown when the application detects that the user's data
/// is not yet registered. It contains a form for the user to input their name
/// and age. It is a [ConsumerWidget] to listen for state changes from a
/// Riverpod provider.
class RequestRegistrationDialog extends ConsumerWidget {
  /// Creates a [RequestRegistrationDialog] instance.
  const RequestRegistrationDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    // Watch the state of the user registration form provider to get form values and validation.
    final userRegistrationForm = ref.watch(userRegistrationFormProvider);
    // Watch the GoRouter provider to handle navigation.
    final appRouter = ref.watch(goRouterProvider);

    // Listen to the user data provider to automatically close the dialog when registration is successful.
    ref.listen(userDataProvider, (previous, next) {
      if (next.isRegistered) {
        // Pop the current dialog from the navigation stack.
        appRouter.pop();
      }
    });

    return AlertDialog(
      scrollable: true,
      backgroundColor: colors.surfaceContainer,
      title: const Text('¡Regístrate para continuar!'),
      titleTextStyle: textStyles.titleLarge,
      actions: [
        // The "Register" button to submit the form.
        FilledButton(
          onPressed: () {
            // Read the notifier and call the onFormSubmit method to process the form.
            ref.read(userRegistrationFormProvider.notifier).onFormSubmit();
          },
          child: const Text('Registrar')
        ),
      ],
      // The content of the dialog, containing the form fields.
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          // Informational message for the user.
          Text(
            'Parece que aún no estás registrado. Por favor, completa tu registro para acceder a todas las funciones.',
            style: textStyles.bodySmall,
          ),
          // Form field for the user's name.
          CustomFormField(
            label: 'Ingresa tu nombre',
            hint: 'Ej. Luis Donaldo Gamas',
            leftIcon: RippleIcons.userOutline,
            // Provide the notifier's method to the onChanged callback.
            onChanged: ref.read(userRegistrationFormProvider.notifier).onNameChanged,
            // Display an error message if the form has been posted and there's a name validation error.
            errorMessage: userRegistrationForm.isFormPosted ? userRegistrationForm.name.errorMessage : null,
          ),
          // Form field for the user's age.
          CustomFormField(
            label: 'Ingresa tu edad',
            hint: 'Ej. 30',
            leftIcon: RippleIcons.userOutline,
            // Provide the notifier's method to the onChanged callback.
            onChanged: ref.read(userRegistrationFormProvider.notifier).onYearsChanged,
            // Display an error message if the form has been posted and there's an age validation error.
            errorMessage: userRegistrationForm.isFormPosted ? userRegistrationForm.years.errorMessage : null,
          ),
        ],
      ),
    );
  }
}
