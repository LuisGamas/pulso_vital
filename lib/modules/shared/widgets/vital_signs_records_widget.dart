import 'package:flutter/material.dart';
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';
import 'package:pulso_vital/modules/shared/utils/shared_utils.dart';

class VitalSignsRecordsWidget extends StatelessWidget {
  // Entity containing the user's vital signs
  final VitalSignsEntity vitalSignsEntity;

  const VitalSignsRecordsWidget({
    super.key,
    required this.vitalSignsEntity,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    // Widget displaying the record of saved vital signs
    return Card(
      color: colors.surfaceContainer,
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Registration date with a custom style
                Text(
                  AppHelpers.getFormattedDate(vitalSignsEntity.createdAt),
                  style: textStyles.titleSmall,
                ),
                // Check-in time with a personalized style
                Text(
                  AppHelpers.getFormattedTime(vitalSignsEntity.createdAt),
                  style: textStyles.bodySmall,
                ),
              ],
            ),

            Divider(
              color: colors.outlineVariant,
              radius: BorderRadius.circular(10),
            ),

            // Vital signs aligned and formatted
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SignRecord(
                  signName: 'Presión',
                  signRecord: '${vitalSignsEntity.bpSys}/${vitalSignsEntity.bpDia}',
                  signSub: 'mmHg'
                ),
                _SignRecord(
                  signName: 'Ritmo',
                  signRecord: '${vitalSignsEntity.heartRate}',
                  signSub: 'bpm'
                ),
                _SignRecord(
                  signName: 'Temp.',
                  signRecord: '${vitalSignsEntity.tempC}',
                  signSub: '°C'
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _SignRecord extends StatelessWidget {
  final String signName;
  final String signRecord;
  final String signSub;

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

        Text(signName, style: textStyles.bodySmall),
        Text(signRecord, style: textStyles.titleMedium),
        Text(signSub, style: textStyles.labelSmall),

      ],
    );
  }
}