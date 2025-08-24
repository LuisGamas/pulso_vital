// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/shared/widgets/shared_widgets.dart';

/// A widget that displays vital signs charts in a carousel slider.
///
/// This `ConsumerWidget` uses the `carousel_slider` package to provide
/// a swipeable interface for viewing the different vital signs charts
/// (blood pressure, heart rate, and temperature). It watches the
/// `vitalSignsChartProvider` to get the chart data.
class VitalSignsChartsSlider extends ConsumerWidget {
  /// Creates a [VitalSignsChartsSlider] instance.
  const VitalSignsChartsSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final vitalSignsCharts = ref.watch(vitalSignsChartProvider(colors));

    final chartsList = [
      VitalSignsChart(series: vitalSignsCharts.bloodPressureSeries),
      VitalSignsChart(series: vitalSignsCharts.heartRateSeries),
      VitalSignsChart(series: vitalSignsCharts.tempSeries)
    ];

    return CarouselSlider(
      items: chartsList,
      options: CarouselOptions(
        enableInfiniteScroll: true,
        height: 240,
        scrollDirection: Axis.horizontal,
        viewportFraction: 1,
        autoPlay: true,
        pauseAutoPlayOnManualNavigate: true
      )
    );
  }
}
