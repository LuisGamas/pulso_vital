// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_charts/material_charts.dart';

// 🌎 Project imports:
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/shared/utils/shared_utils.dart';

/// Represents the state for vital signs chart data.
///
/// This immutable class holds the data points for three separate charts:
/// blood pressure, heart rate, and temperature.
class VitalSignsChartState {
  /// The list of data series for the blood pressure chart.
  final List<ChartSeries> bloodPressureSeries;

  /// The list of data series for the heart rate chart.
  final List<ChartSeries> heartRateSeries;

  /// The list of data series for the temperature chart.
  final List<ChartSeries> tempSeries;

  /// Creates a [VitalSignsChartState] instance with the required chart data.
  VitalSignsChartState({
    required this.bloodPressureSeries,
    required this.heartRateSeries,
    required this.tempSeries,
  });

  /// Creates a new [VitalSignsChartState] by copying and potentially
  /// overriding existing values.
  VitalSignsChartState copyWith({
    List<ChartSeries>? bloodPressureSeries,
    List<ChartSeries>? heartRateSeries,
    List<ChartSeries>? tempSeries,
  }) {
    return VitalSignsChartState(
      bloodPressureSeries: bloodPressureSeries ?? this.bloodPressureSeries,
      heartRateSeries: heartRateSeries ?? this.heartRateSeries,
      tempSeries: tempSeries ?? this.tempSeries,
    );
  }
}

/// Manages the state and logic for generating vital signs chart data.
///
/// This `StateNotifier` processes raw vital signs records and transforms them
/// into a structured format suitable for display in charts. It depends on
/// `VitalSignsRecordsState` to access the list of vital signs.
class VitalSignsChartNotifier extends StateNotifier<VitalSignsChartState> {
  /// The state containing the raw vital signs records.
  final VitalSignsRecordsState vitalSignsRecords;

  /// The color scheme used for styling the chart series.
  final ColorScheme colorScheme;

  /// Creates a [VitalSignsChartNotifier] instance.
  ///
  /// It requires the current vital signs records state and the app's color scheme
  /// to generate the chart data.
  VitalSignsChartNotifier({
    required this.vitalSignsRecords,
    required this.colorScheme,
  }) : super(
          VitalSignsChartState(
            bloodPressureSeries: [],
            heartRateSeries: [],
            tempSeries: [],
          ),
        ) {
    _generateChartSeries();
  }

  /// Generates chart series data from the vital signs records.
  ///
  /// This method filters the last 5 records, extracts the required data points,
  /// and organizes them into `ChartSeries` objects for each vital sign type.
  void _generateChartSeries() {
    // Takes the first 5 vital signs records from the ordered list.
    final vitalSigns = vitalSignsRecords.vitalSignsEntity.take(5).toList();

    // Guards against empty data to prevent errors.
    if (vitalSigns.isEmpty) {
      state = state.copyWith(
        bloodPressureSeries: [],
        heartRateSeries: [],
        tempSeries: [],
      );
      return;
    }

    // Mapps the data for each vital sign into a list of `ChartDataPoint`.
    final List<ChartDataPoint> bpSysData = [];
    final List<ChartDataPoint> bpDiaData = [];
    final List<ChartDataPoint> heartRateData = [];
    final List<ChartDataPoint> tempCData = [];

    for (final vitalSign in vitalSigns) {
      final label = AppHelpers.getChartDateLabel(vitalSign.createdAt);
      bpSysData.add(ChartDataPoint(value: vitalSign.bpSys.toDouble(), label: label));
      bpDiaData.add(ChartDataPoint(value: vitalSign.bpDia.toDouble(), label: label));
      heartRateData.add(ChartDataPoint(value: vitalSign.heartRate.toDouble(), label: label));
      tempCData.add(ChartDataPoint(value: vitalSign.tempC, label: label));
    }

    // Creates the final `ChartSeries` objects with data and styling.
    final List<ChartSeries> bloodPressureSeries = [
      ChartSeries(
        name: 'Presión Sistólica',
        dataPoints: bpSysData,
        color: colorScheme.primary,
      ),
      ChartSeries(
        name: 'Presión Diastólica',
        dataPoints: bpDiaData,
        color: colorScheme.tertiary,
      ),
    ];

    final List<ChartSeries> heartRateSeries = [
      ChartSeries(
        name: 'Ritmo Cardiaco',
        dataPoints: heartRateData,
        color: colorScheme.primary,
      ),
    ];

    final List<ChartSeries> tempSeries = [
      ChartSeries(
        name: 'Temperatura',
        dataPoints: tempCData,
        color: colorScheme.tertiary,
      ),
    ];

    // Updates the state with the newly generated chart series.
    state = state.copyWith(
      bloodPressureSeries: bloodPressureSeries,
      heartRateSeries: heartRateSeries,
      tempSeries: tempSeries,
    );
  }
}
// ---
/// A Riverpod provider for `VitalSignsChartNotifier`.
///
/// This family provider creates a `VitalSignsChartNotifier` instance,
/// taking a `ColorScheme` as an argument to allow for dynamic theming
/// of the chart series. It watches the `vitalSignsRecordProvider`
/// for changes in the data.
final vitalSignsChartProvider = StateNotifierProvider.family<VitalSignsChartNotifier, VitalSignsChartState, ColorScheme>((ref, colorScheme) {
  final vitalSignsRecords = ref.watch(vitalSignsRecordProvider);
  return VitalSignsChartNotifier(
    vitalSignsRecords: vitalSignsRecords,
    colorScheme: colorScheme,
  );
});
