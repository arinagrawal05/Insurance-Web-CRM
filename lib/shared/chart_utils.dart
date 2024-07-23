import 'package:health_model/shared/exports.dart';

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final int y;
}

class ItemLabeling {
  int value1 = 0;
  int value2 = 0;
  int value3 = 0;
  int value4 = 0;

  final String? label1;
  final String? label2;
  final String? label3;
  final String? label4;

  ItemLabeling({this.label1, this.label2, this.label3, this.label4});
}

num? Function(ChartData, int)? yValueMapper = (ChartData data, _) => data.y;
Widget customChart(
    {List<ChartData>? dataSource, TooltipBehavior? tooltipBehavior}) {
  return SfCircularChart(
    title: ChartTitle(text: 'Documents', textStyle: GoogleFonts.nunito()),
    legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
    tooltipBehavior: tooltipBehavior,
    series: <CircularSeries>[
      PieSeries<ChartData, String>(
        dataSource: dataSource,
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: yValueMapper,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        enableTooltip: true,
      )
    ],
  );
}
