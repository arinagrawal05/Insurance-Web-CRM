import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:health_model/shared/chart_utils.dart';
import 'exports.dart';

Widget policyCountCircularChart(
    String d, BuildContext context, TooltipBehavior? tooltipBehavior) {
  return GetBuilder<GeneralStatsProvider>(
      tag: AppUtils.getStatsControllerTag(),
      builder: (statsProvider) {
        // if (statsProvider.policyDistributionChartData.isEmpty) {
        //   return Container();
        // }
        return Container(
          decoration: dashBoxDex(context),
          // width: 400,
          // height: 250,
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: SfCircularChart(
            title: ChartTitle(
                text: 'Distribution', textStyle: GoogleFonts.nunito()),
            legend: Legend(
                isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
            tooltipBehavior: tooltipBehavior,
            series: <CircularSeries>[
              PieSeries<ChartData, String>(
                dataSource: statsProvider.policyDistributionChartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                // innerRadius: "50",
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                enableTooltip: true,

                //  pointColorMapper: (PolicyDistributionChartData data, _) {
                //    final List<Color> blueShades = [
                //     Colors.blue[300]!,
                //     Colors.blue[400]!,
                //     Colors.blue[500]!,
                //     Colors.blue[600]!,
                //     Colors.blue[700]!,
                //   ];
                //    int index =
                //       statsProvider.policyDistributionChartData.indexOf(data);
                //    return blueShades[index % blueShades.length];
                // },
              ),
            ],
          ),
        );
      });
}

Widget policyCircularChart(
    String dashName, BuildContext context, TooltipBehavior? tooltipBehavior) {
  final statsProvider = Get.find<GeneralStatsProvider>(
    tag: AppUtils.getStatsControllerTag(),
  );

  return Container(
    decoration: dashBoxDex(context),
    // width: 400,
    // height: 250,
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: SfCircularChart(
      title: ChartTitle(
          text: '${dashName} Distribution', textStyle: GoogleFonts.nunito()),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: tooltipBehavior,
      series: <CircularSeries>[
        DoughnutSeries<ChartData, String>(
          dataSource: statsProvider.policyStatusChartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          innerRadius: "50",
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          enableTooltip: true,
          // maximumValue: 40000
        )
      ],
    ),
  );
}

Widget companyChart(TooltipBehavior tooaltip, BuildContext context,
    FlipCardController flipController) {
  TooltipBehavior tooltip = TooltipBehavior(
    animationDuration: 1,
    color: Colors.black,
    elevation: 1,
  );
  // List<_ChartData> data
  final statsProvider = Get.find<GeneralStatsProvider>(
    tag: AppUtils.getStatsControllerTag(),
  );

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
            series: <CartesianSeries<ChartData, String>>[
              ColumnSeries<ChartData, String>(
                  dataSource: statsProvider.chartCompanyData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
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
            itemCount: statsProvider.chartCompanyData.length,
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
                        "₹ ${AppUtils.formatAmount(statsProvider.chartCompanyData[index].y)}",
                        22),
                  ],
                ),
              );
            }),
      ));
}

Widget membersCircularChart(DashProvider statsProvider, BuildContext context,
    TooltipBehavior? tooltipBehavior) {
  return Container(
    // decoration: dashBoxDex(context),
    width: 600,
    height: 600,
    // margin: const EdgeInsets.symmetric(vertical: 5),
    child: SfCircularChart(
      // title: ChartTitle(text: 'Members', textStyle: GoogleFonts.nunito()),
      // legend:
      //     Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: tooltipBehavior,
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataSource: statsProvider.memberChartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          enableTooltip: true,
          // maximumValue: 40000
        )
      ],
    ),
  );
}

Widget documentsCircularChart(DashProvider statsProvider, BuildContext context,
    TooltipBehavior? tooltipBehavior) {
  return Container(
    // decoration: dashBoxDex(context),
    // width: 400,
    // height: 250,
    // margin: const EdgeInsets.symmetric(vertical: 5),
    child: SfCircularChart(
      // title: ChartTitle(text: 'Documents', textStyle: GoogleFonts.nunito()),
      // legend:
      //     Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: tooltipBehavior,
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataSource: statsProvider.docChartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          enableTooltip: true,
        )
      ],
    ),
  );
}
