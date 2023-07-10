import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_model/shared/colors.dart';
import 'package:health_model/shared/style.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../providers/health_stats_provider.dart';

Widget policyCountCircularChart(
    BuildContext context, TooltipBehavior? tooltipBehavior) {
  final statsProvider = Provider.of<HealthStatsProvider>(context, listen: true);

  return Container(
    decoration: dashBoxDex(context),
    // width: 400,
    // height: 250,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: SfCircularChart(
      title: ChartTitle(
          text: 'Policies Distribution', textStyle: GoogleFonts.nunito()),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: tooltipBehavior,
      series: <CircularSeries>[
        PieSeries<PolicyDistributionChartData, String>(
          dataSource: statsProvider.policyDistributionChartData,
          xValueMapper: (PolicyDistributionChartData data, _) => data.x,
          yValueMapper: (PolicyDistributionChartData data, _) => data.y,
          // innerRadius: "50",
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          enableTooltip: true,
          // maximumValue: 40000
        )
      ],
    ),
  );
}

Widget policyCircularChart(
    BuildContext context, TooltipBehavior? tooltipBehavior) {
  final statsProvider = Provider.of<HealthStatsProvider>(context, listen: true);

  return Container(
    decoration: dashBoxDex(context),
    // width: 400,
    // height: 250,
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: SfCircularChart(
      title: ChartTitle(
          text: 'Policies Distribution', textStyle: GoogleFonts.nunito()),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: tooltipBehavior,
      series: <CircularSeries>[
        DoughnutSeries<PolicyStatusChartData, String>(
          dataSource: statsProvider.policyStatusChartData,
          xValueMapper: (PolicyStatusChartData data, _) => data.x,
          yValueMapper: (PolicyStatusChartData data, _) => data.y,
          innerRadius: "50",
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          enableTooltip: true,
          // maximumValue: 40000
        )
      ],
    ),
  );
}

class PolicyStatusChartData {
  PolicyStatusChartData(this.x, this.y);

  final String x;
  final int y;
}

class PolicyDistributionChartData {
  PolicyDistributionChartData(this.x, this.y);

  final String x;
  final int y;
}

Widget companyChart(TooltipBehavior tooaltip, BuildContext context) {
  TooltipBehavior tooltip = TooltipBehavior(
    animationDuration: 1,
    color: Colors.black,
    elevation: 1,
  );
  // List<_ChartData> data
  final statsProvider = Provider.of<HealthStatsProvider>(context, listen: true);

  return Container(
    margin: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
    decoration: dashBoxDex(context),
    // height: 400,
    // width: 300,
    child: SfCartesianChart(
        backgroundColor: Colors.transparent,
        borderColor: Colors.transparent,
        enableAxisAnimation: true,
        title:
            ChartTitle(text: "Companies List", textStyle: GoogleFonts.nunito()),
        borderWidth: 0,

        // annotations: [CartesianChartAnnotation()],
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          minimum: 0,
        ),
        tooltipBehavior: tooltip,
        series: <ChartSeries<CompanyChartData, String>>[
          ColumnSeries<CompanyChartData, String>(
              dataSource: statsProvider.chartData,
              xValueMapper: (CompanyChartData data, _) => data.x,
              yValueMapper: (CompanyChartData data, _) => data.y,
              name: 'Bussiness',
              color: primaryColor)
        ]),
  );
}

class CompanyChartData {
  CompanyChartData(this.x, this.y);

  final String x;
  final int y;
}
