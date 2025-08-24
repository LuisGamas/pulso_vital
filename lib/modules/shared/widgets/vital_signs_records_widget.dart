// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:pulso_vital/config/config.dart';
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/shared/utils/shared_utils.dart';

/// A widget to display a single vital signs record in a structured format.
///
/// This widget takes a [VitalSignsEntity] and presents its data, including
/// the date, time, and values for blood pressure, heart rate, and temperature,
/// within a `Card` for clear visual separation.
class VitalSignsRecordsWidget extends ConsumerWidget {
  /// The entity containing the user's vital signs data.
  final VitalSignsEntity vitalSignsEntity;

  /// Creates a [VitalSignsRecordsWidget] instance.
  const VitalSignsRecordsWidget({
    super.key,
    required this.vitalSignsEntity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    // A Card widget to visually encapsulate the vital signs record.
    return Card(
      color: colors.surfaceContainer,
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Displays the formatted date of the record.
                Text(
                  AppHelpers.getFormattedDate(vitalSignsEntity.createdAt),
                  style: textStyles.titleSmall,
                ),
                // Displays the formatted time of the record.
                Text(
                  AppHelpers.getFormattedTime(vitalSignsEntity.createdAt),
                  style: textStyles.bodySmall,
                ),
                // Botón para eliminar el registro o tarjeta
                Material(
                  color: colors.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    splashColor: colors.errorContainer,
                    child: SizedBox(
                      height: 36,
                      width: 36,
                      child: Icon(
                        RippleIcons.trashOutline,
                        color: colors.error,
                      ),
                    ),
                    onTap: () => ref.read(vitalSignsRecordProvider.notifier).deleteVitalSigns(vitalSignsEntity.isarId),
                  )
                ),
              ],
            ),
            // A divider to separate the date/time from the vital signs data.
            Divider(
              color: colors.outlineVariant,
              // The `radius` property doesn't exist on `Divider`. This line should be changed to use `indent` and `endIndent`.
              // For example: `indent: 10, endIndent: 10`
            ),
            // A row to display the vital signs records side-by-side.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Widget for displaying blood pressure.
                _SignRecord(
                  signName: 'Presión',
                  signRecord: '${vitalSignsEntity.bpSys}/${vitalSignsEntity.bpDia}',
                  signSub: 'mmHg',
                ),
                // Widget for displaying heart rate.
                _SignRecord(
                  signName: 'Ritmo',
                  signRecord: '${vitalSignsEntity.heartRate}',
                  signSub: 'bpm',
                ),
                // Widget for displaying temperature.
                _SignRecord(
                  signName: 'Temp.',
                  signRecord: '${vitalSignsEntity.tempC}',
                  signSub: '°C',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A private helper widget to display a single vital sign value.
///
/// This widget structures the name, value, and unit of a single vital sign
/// within a `Column` for easy reuse within the main `VitalSignsRecordsWidget`.
class _SignRecord extends StatelessWidget {
  /// The name of the vital sign (e.g., 'Presión').
  final String signName;

  /// The recorded value of the vital sign.
  final String signRecord;

  /// The unit of measurement for the vital sign (e.g., 'mmHg').
  final String signSub;

  /// Creates a [_SignRecord] instance.
  const _SignRecord({
    required this.signName,
    required this.signRecord,
    required this.signSub,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Displays the name of the vital sign.
        Text(signName, style: textStyles.bodySmall),
        // Displays the recorded value.
        Text(signRecord, style: textStyles.titleMedium),
        // Displays the unit of measurement.
        Text(signSub, style: textStyles.labelSmall),
      ],
    );
  }
}
