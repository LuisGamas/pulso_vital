// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:pulso_vital/config/config.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/shared/widgets/shared_widgets.dart';

/// A dialog widget for logging vital signs.
///
/// This dialog provides a form for the user to input their temperature,
/// blood pressure (systolic and diastolic), and heart rate. It is a
/// [ConsumerWidget] that interacts with Riverpod providers to manage the
/// form state and submit the data.
class VitalSignsLogDialog extends ConsumerWidget {
  /// Creates a [VitalSignsLogDialog] instance.
  const VitalSignsLogDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    // Watch the vital signs form provider to get the current form state.
    final vitalSignsForm = ref.watch(vitalSignsLogFormProvider);
    // Watch the GoRouter provider to handle navigation.
    final appRouter = ref.watch(goRouterProvider);

    // Listen for state changes in the form provider to determine when to close the dialog.
    ref.listen(vitalSignsLogFormProvider, (previous, next) {
      if (next.canCloseDialog) {
        // Pop the current dialog from the navigation stack.
        appRouter.pop();
      }
    });

    return AlertDialog(
      scrollable: true,
      backgroundColor: colors.surfaceContainer,
      title: const Text('Registrar Signos Vitales'),
      titleTextStyle: textStyles.titleLarge,
      actions: [
        // The "Register" button to submit the form.
        FilledButton(
          // Disable the button while the form is being submitted.
          onPressed: vitalSignsForm.isPosting
              ? null
              : () => ref.read(vitalSignsLogFormProvider.notifier).onFormSubmit(),
          child: const Text('Registrar'),
        ),
      ],
      // The content of the dialog, containing the form fields.
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Field for temperature.
          CustomFormField(
            label: 'Temperatura (°C)',
            hint: 'Ej. 36.5',
            leftIcon: RippleIcons.dropOutline,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            // Provide the notifier's method to the onChanged callback.
            onChanged: ref.read(vitalSignsLogFormProvider.notifier).onTemperatureChanged,
            // Display an error message if the form has been posted and there's a validation error.
            errorMessage: vitalSignsForm.isFormPosted ? vitalSignsForm.temperature.errorMessage : null,
          ),

          const Gap(15),

          Text('Presión Arterial (mm/Hg)', style: textStyles.bodyLarge),

          const Gap(5),

          // Fields for blood pressure.
          Row(
            children: [
              Expanded(
                child: CustomFormField(
                  label: 'Sistólica',
                  hint: 'Ej. 120',
                  leftIcon: RippleIcons.heartOutline,
                  keyboardType: TextInputType.number,
                  // Provide the notifier's method to the onChanged callback.
                  onChanged: ref.read(vitalSignsLogFormProvider.notifier).onBpSystolicChanged,
                  // Display an error message if the form has been posted and there's a validation error.
                  errorMessage: vitalSignsForm.isFormPosted ? vitalSignsForm.bpSystolic.errorMessage : null,
                ),
              ),
              const Gap(10),
              Expanded(
                child: CustomFormField(
                  label: 'Diastólica',
                  hint: 'Ej. 80',
                  leftIcon: RippleIcons.heartOutline,
                  keyboardType: TextInputType.number,
                  // Provide the notifier's method to the onChanged callback.
                  onChanged: ref.read(vitalSignsLogFormProvider.notifier).onBpDiastolicChanged,
                  // Display an error message if the form has been posted and there's a validation error.
                  errorMessage: vitalSignsForm.isFormPosted ? vitalSignsForm.bpDiastolic.errorMessage : null,
                ),
              ),
            ],
          ),

          const Gap(15),

          // Heart rate field.
          CustomFormField(
            label: 'Frecuencia Cardíaca (bpm)',
            hint: 'Ej. 75',
            leftIcon: RippleIcons.pulseOutline,
            keyboardType: TextInputType.number,
            // Provide the notifier's method to the onChanged callback.
            onChanged: ref.read(vitalSignsLogFormProvider.notifier).onHeartRateChanged,
            // Display an error message if the form has been posted and there's a validation error.
            errorMessage: vitalSignsForm.isFormPosted ? vitalSignsForm.heartRate.errorMessage : null,
          ),
        ],
      ),
    );
  }
}
