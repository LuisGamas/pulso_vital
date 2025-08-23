import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulso_vital/config/config.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/shared/widgets/shared_widgets.dart';

class VitalSignsLogDialog extends ConsumerWidget {
  const VitalSignsLogDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final vitalSignsForm = ref.watch(vitalSignsLogFormProvider);
    final appRouter = ref.watch(goRouterProvider);

    // Listen to know when to close the dialog
    ref.listen(vitalSignsLogFormProvider, (previous, next) {
      if (next.canCloseDialog) {
        appRouter.pop();
      }
    });

    return AlertDialog(
      scrollable: true,
      backgroundColor: colors.surfaceContainer,
      title: const Text('Registrar Signos Vitales'),
      titleTextStyle: textStyles.titleLarge,
      actions: [
        // CTA for recording vital signs
        FilledButton(
          onPressed: vitalSignsForm.isPosting
              ? null
              : () => ref.read(vitalSignsLogFormProvider.notifier).onFormSubmit(),
          child: const Text('Registrar'),
        ),
      ],
      // Fields aligned to record vital signs by type
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Field for temperature
          CustomFormField(
            label: 'Temperatura (°C)',
            hint: 'Ej. 36.5',
            leftIcon: RippleIcons.dropOutline,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: ref.read(vitalSignsLogFormProvider.notifier).onTemperatureChanged,
            errorMessage: vitalSignsForm.isFormPosted
                ? vitalSignsForm.temperature.errorMessage
                : null,
          ),

          const SizedBox(height: 15),

          Text('Presión Arterial (mm/Hg)', style: textStyles.bodyLarge),

          const SizedBox(height: 5),

          // Fields for blood pressure
          Row(
            children: [

              Expanded(
                child: CustomFormField(
                  label: 'Sistólica',
                  hint: 'Ej. 120',
                  leftIcon: RippleIcons.heartOutline,
                  keyboardType: TextInputType.number,
                  onChanged: ref.read(vitalSignsLogFormProvider.notifier).onBpSystolicChanged,
                  errorMessage: vitalSignsForm.isFormPosted
                      ? vitalSignsForm.bpSystolic.errorMessage
                      : null,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: CustomFormField(
                  label: 'Diastólica',
                  hint: 'Ej. 80',
                  leftIcon: RippleIcons.heartOutline,
                  keyboardType: TextInputType.number,
                  onChanged: ref.read(vitalSignsLogFormProvider.notifier).onBpDiastolicChanged,
                  errorMessage: vitalSignsForm.isFormPosted
                      ? vitalSignsForm.bpDiastolic.errorMessage
                      : null,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Heart rate field
          CustomFormField(
            label: 'Frecuencia Cardíaca (bpm)',
            hint: 'Ej. 75',
            leftIcon: RippleIcons.pulseOutline,
            keyboardType: TextInputType.number,
            onChanged: ref.read(vitalSignsLogFormProvider.notifier).onHeartRateChanged,
            errorMessage: vitalSignsForm.isFormPosted
                ? vitalSignsForm.heartRate.errorMessage
                : null,
          ),
        ],
      ),
    );
  }
}