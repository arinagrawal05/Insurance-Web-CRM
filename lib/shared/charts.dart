import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'exports.dart';

Widget policyCountCircularChart(
    String d, BuildContext context, TooltipBehavior? tooltipBehavior) {
  return GetBuilder<GeneralStatsProvider>(builder: (statsProvider) {
    if (statsProvider.policyDistributionChartData.isEmpty) {
      return Container();
    }
    return Container(
      decoration: dashBoxDex(context),
      // width: 400,
      // height: 250,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: SfCircularChart(
        title:
            ChartTitle(text: 'Distribution', textStyle: GoogleFonts.nunito()),
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
  });
}

Widget policyCircularChart(
    String dashName, BuildContext context, TooltipBehavior? tooltipBehavior) {
  final statsProvider = Get.find<GeneralStatsProvider>();

  return Container(
    decoration: dashBoxDex(context),
    // width: 400,
    // height: 250,
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: SfCircularChart(
      title: ChartTitle(
          text: '${getWord(dashName)} Distribution',
          textStyle: GoogleFonts.nunito()),
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

Widget companyChart(TooltipBehavior tooaltip, BuildContext context,
    FlipCardController flipController) {
  TooltipBehavior tooltip = TooltipBehavior(
    animationDuration: 1,
    color: Colors.black,
    elevation: 1,
  );
  // List<_ChartData> data
  final statsProvider = Get.find<GeneralStatsProvider>();

  return FlipCard(
      rotateSide: RotateSide.left,
      onTapFlipping: true,
      axis: FlipAxis.vertical,
      controller: flipController,
      frontWidget: Container(
        margin: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
        decoration: dashBoxDex(context),
        // height: 400,
        // width: 300,
        child: SfCartesianChart(
            onChartTouchInteractionUp: (d) {
              flipController.flipcard();
            },
            backgroundColor: Colors.transparent,
            borderColor: Colors.transparent,
            enableAxisAnimation: true,
            title: ChartTitle(
                text: "Companies List", textStyle: GoogleFonts.nunito()),
            borderWidth: 0,

            // annotations: [CartesianChartAnnotation()],
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
              minimum: 0,
            ),
            tooltipBehavior: tooltip,
            series: <ChartSeries<CompanyChartData, String>>[
              ColumnSeries<CompanyChartData, String>(
                  dataSource: statsProvider.chartCompanyData,
                  xValueMapper: (CompanyChartData data, _) => data.x,
                  yValueMapper: (CompanyChartData data, _) => data.y,
                  name: 'Bussiness',
                  color: primaryColor)
            ]),
      ),
      backWidget: Container(
        margin: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
        // flex: 1,
        // height: double.infinity,
        width: double.infinity,
        height: 500,
        decoration: dashBoxDex(context),
        child: ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
            // shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) {
              // return Text("data");
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    productTileText(
                        statsProvider.chartCompanyData[index].x.toString(), 22),
                    productTileText(
                        statsProvider.chartCompanyData[index].y.toString(), 22),
                  ],
                ),
              );
            }),
      ));
}

class CompanyChartData {
  CompanyChartData(this.x, this.y);

  final String x;
  final int y;
}
