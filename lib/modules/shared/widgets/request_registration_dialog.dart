import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulso_vital/config/config.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/shared/widgets/shared_widgets.dart';

class RequestRegistrationDialog extends ConsumerWidget {
  const RequestRegistrationDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final userRegistrationForm = ref.watch(userRegistrationFormProvider);
    final appRouter = ref.watch(goRouterProvider);

    // Listen to know when to close the dialog
    ref.listen(userDataProvider, (previous, next) {
      if (next.isRegistered) {
        appRouter.pop();
      }
    });

    return AlertDialog(
      scrollable: true,
      backgroundColor: colors.surfaceContainer,
      title: const Text('¡Regístrate para continuar!'),
      titleTextStyle: textStyles.titleLarge,
      actions: [
        // CTA to request login with registration
        FilledButton(
          onPressed: () {
            ref.read(userRegistrationFormProvider.notifier).onFormSubmit();
          },
          child: const Text('Registrar')
        ),
      ],
      // Fields for entering user data for registration
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [

          Text(
            'Parece que aún no estás registrado. Por favor, completa tu registro para acceder a todas las funciones.',
            style: textStyles.bodySmall,
          ),

          // Name
          CustomFormField(
            label: 'Ingresa tu nombre',
            hint: 'Ej. Luis Donaldo Gamas',
            leftIcon: RippleIcons.userOutline,
            onChanged: ref.read(userRegistrationFormProvider.notifier).onNameChanged,
            errorMessage: userRegistrationForm.isFormPosted
              ? userRegistrationForm.name.errorMessage
              : null,
          ),

          // Years
          CustomFormField(
            label: 'Ingresa tu edad',
            hint: 'Ej. 30',
            leftIcon: RippleIcons.userOutline,
            onChanged: ref.read(userRegistrationFormProvider.notifier).onYearsChanged,
            errorMessage: userRegistrationForm.isFormPosted
              ? userRegistrationForm.years.errorMessage
              : null,
          ),
        ],
      ),
    );
  }
}