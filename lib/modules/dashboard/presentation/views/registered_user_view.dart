// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:pulso_vital/config/config.dart';
import 'package:pulso_vital/modules/dashboard/domain/dashboard_domain.dart';
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
        const _AnimatedVitalSignsList(),

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
          child: child,
        ),
      ),
    );
  }
}

/// Custom widget that handles animations for the list of vital signs.
///
/// This widget encapsulates a `SliverAnimatedList` and automatically handles the
/// animations for inserting and removing items. It maintains its own
/// internal state synchronized with the Riverpod provider to ensure
/// smooth and consistent animations.
class _AnimatedVitalSignsList extends ConsumerStatefulWidget {
  /// Create an instance of [_AnimatedVitalSignsList].
  const _AnimatedVitalSignsList();

  @override
  ConsumerState<_AnimatedVitalSignsList> createState() => _AnimatedVitalSignsListState();
}

/// Status of the [_AnimatedVitalSignsList] widget.
///
/// Handles animation logic, synchronization with the data provider,
/// and operations for inserting/deleting items in the animated list.
class _AnimatedVitalSignsListState extends ConsumerState<_AnimatedVitalSignsList> {
  /// Global key to control the state of the [SliverAnimatedList].
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();

  /// Local list that maintains the current state of the elements.
  /// It synchronizes with the data provider but allows direct control
  /// over animations.
  List<VitalSignsEntity> _localList = [];

  /// Flag indicating whether the list has been initialized.
  /// Prevents unnecessary animations during the first data load.
  bool _isInitialized = false;

  @override
  Widget build(BuildContext context) {
    
    final vitalSignsRecords = ref.watch(vitalSignsRecordProvider);
    
    // Synchronize the local list with the provider's data
    _syncWithProvider(vitalSignsRecords.vitalSignsEntity);
    
    return SliverAnimatedList(
      key: _listKey,
      initialItemCount: _localList.length,
      itemBuilder: (context, index, animation) {
        if (index >= _localList.length) return const SizedBox.shrink();
        
        final vitalSignRecord = _localList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: VitalSignsRecordsWidget(
            vitalSignsEntity: vitalSignRecord,
            animation: animation,
            onDelete: () => _deleteItem(index),
          ),
        );
      },
    );
  }

  /// Synchronizes the local list with the provider's data.
  ///
  /// This method automatically detects changes in the provider's data list
  /// and applies the corresponding animations (insertion or deletion).
  /// 
  /// [newList] - The new data list from the provider.
  void _syncWithProvider(List<VitalSignsEntity> newList) {
    if (!_isInitialized) {
      // First load - initialize without animation
      _localList = List.from(newList);
      _isInitialized = true;
      return;
    }

    // Detect new elements (inserted at the beginning)
    if (newList.length > _localList.length) {
      final newItems = newList.take(newList.length - _localList.length).toList();
      for (int i = 0; i < newItems.length; i++) {
        _localList.insert(i, newItems[i]);
        _listKey.currentState?.insertItem(
          i, 
          duration: const Duration(milliseconds: 500)
        );
      }
    }
    
    // Detect deleted elements
    else if (newList.length < _localList.length) {
      // In this case, the element has already been removed with animation.
      // We just need to synchronize the local list.
      _localList = List.from(newList);
    }
  }

  /// Deletes an item from the list with animation.
  ///
  /// This method handles the entire removal process:
  /// 1. Runs the removal animation
  /// 2. Immediately updates the local list
  /// 3. Calls the notifier method to remove from the database
  ///
  /// [index] - The index of the item to be removed from the local list.
  void _deleteItem(int index) async {
    if (index >= _localList.length) return;
    
    final vitalSignRecord = _localList[index];
    
    // Animate removal with vertical shrink effect
    _listKey.currentState?.removeItem(index, (context, animation) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: VitalSignsRecordsWidget(
        vitalSignsEntity: vitalSignRecord,
        animation: animation,
        onDelete: () {}, // Empty Callback during animation
      )),
      duration: const Duration(milliseconds: 500),
    );

    // Update local list immediately
    _localList.removeAt(index);

    // Call the notifier method
    await ref.read(vitalSignsRecordProvider.notifier)
        .deleteVitalSigns(vitalSignRecord.isarId);
  }
}
