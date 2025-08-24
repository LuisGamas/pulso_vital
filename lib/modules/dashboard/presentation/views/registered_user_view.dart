// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:pulso_vital/config/config.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/shared/widgets/shared_widgets.dart';

/// A widget that displays the user's vital signs records.
///
/// This `ConsumerWidget` watches the `vitalSignsRecordProvider` to retrieve
/// and display a list of vital signs records. It shows a loading indicator while
/// the data is being fetched and a message if there are no records.
class RegisteredUserView extends ConsumerWidget {
  /// Creates a [RegisteredUserView] instance.
  const RegisteredUserView({super.key});

  /// Builds the vital signs records view.
  ///
  /// This method uses a `SliverMainAxisGroup` to organize the widgets in a
  /// vertical list. It conditionally renders a `LinearProgressIndicator`
  /// during data loading and displays a list of `VitalSignsRecordsWidget`
  /// widgets once the data is available.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the `vitalSignsRecordProvider` to get the current state of vital signs.
    final vitalSignsRecords = ref.watch(vitalSignsRecordProvider);
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return SliverMainAxisGroup(
      slivers: [
        // Show a loading indicator while vital signs records are being fetched.
        if (vitalSignsRecords.isLoading)
          const SliverToBoxAdapter(
            child: LinearProgressIndicator(),
          ),

        const SliverGap(16),

        _boxWidget(
          Text(
            'Tendencias de tus signos vitales',
            style: textStyles.titleMedium,
          ),
        ),

        const SliverGap(8),

        // Display vital sign trends if information is available
        SliverToBoxAdapter(
          child: Container(
            height: 240,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: colors.surfaceContainer,
            ),
            // Checks for vital sign information and, depending on the case,
            // displays a scrollable widget containing graphs of the last 5 
            // vital signs saved.
            child: vitalSignsRecords.vitalSignsEntity.isEmpty
              ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      RippleIcons.faceSadOutline,
                      color: colors.tertiary,
                      size: 60,
                    ),
                    Text(
                      'No hay datos para visualizar la tendencia',
                      style: textStyles.bodyMedium,
                    )
                  ],
                ),
              )
              // Custom slider widget with graphs
              : const VitalSignsChartsSlider(),
          )
        ),

        const SliverGap(16),

        _boxWidget(
          Text(
            // Display a different message based on whether there are records.
            vitalSignsRecords.vitalSignsEntity.isEmpty
                ? 'No hay historial de signos vitales'
                : 'Historial de signos vitales',
            style: textStyles.titleMedium,
          ),
        ),

        const SliverGap(8),

        // A sliver list to build and display the list of vital signs records.
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

  // Create a space compatible with CustomScrollView and thus render any other widget that is not a sliver
  SliverToBoxAdapter _boxWidget(Widget child) {
    return SliverToBoxAdapter(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: child
          ),
        ),
      );
  }
}
