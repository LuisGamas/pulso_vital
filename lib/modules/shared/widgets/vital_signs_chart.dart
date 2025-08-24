// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:material_charts/material_charts.dart';

/// A reusable widget for creating a line chart of vital signs.
///
/// This stateless widget takes a list of `ChartSeries` to display data points
/// on a `MultiLineChart`. It applies a consistent style using the app's
/// `Theme` for colors and text styles.
class VitalSignsChart extends StatelessWidget {
  /// The list of data series to be plotted on the chart.
  final List<ChartSeries> series;

  /// Creates a [VitalSignsChart] instance with the required series data.
  const VitalSignsChart({
    super.key,
    required this.series,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    // Custom style graphic compatible with the app theme
    return MultiLineChart(
      series: series,
      height: 240,
      style: MultiLineChartStyle(
        padding: const EdgeInsets.only(
          top: 16,
          right: 16,
          bottom: 8,
          left: 44,
        ),
        colors: [],
        smoothLines: true,
        backgroundColor: Colors.transparent,
        gridColor: colors.outlineVariant,
        labelStyle: textStyles.labelSmall,
        legendStyle: textStyles.labelSmall,
      ),
    );
  }
}
