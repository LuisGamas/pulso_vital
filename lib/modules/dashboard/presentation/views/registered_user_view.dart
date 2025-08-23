import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/shared/widgets/shared_widgets.dart';

class RegisteredUserView extends ConsumerWidget {
  const RegisteredUserView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vitalSignsRecords = ref.watch(vitalSignsRecordProvider);
    final textStyles = Theme.of(context).textTheme;

    return SliverMainAxisGroup(
      slivers: [

        // Show a loading indicator while vital signs records are being fetched
        if (vitalSignsRecords.isLoading)
        const SliverToBoxAdapter(
          child: LinearProgressIndicator(),
        ),

        const SliverGap(16),

        SliverToBoxAdapter(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                // Display a different message based on whether there are records
                vitalSignsRecords.vitalSignsEntity.isEmpty
                    ? 'No hay historial de signos vitales'
                    : 'Historial de signos vitales',
                style: textStyles.titleMedium,
              ),
            ),
          ),
        ),

        // A sliver list to build and display the list of vital signs records
        SliverList.builder(
          itemCount: vitalSignsRecords.vitalSignsEntity.length,
          itemBuilder: (context, index) {
            final vitalSignRecord = vitalSignsRecords.vitalSignsEntity[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: VitalSignsRecordsWidget(
                vitalSignsEntity: vitalSignRecord,
              ),
            );
          },
        ),

        const SliverGap(16),
      ],
    );
  }
}