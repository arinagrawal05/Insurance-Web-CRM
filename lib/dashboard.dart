import '../../shared/exports.dart';

// ignore: must_be_immutable
class DashboardPage extends StatelessWidget {
  final ProductType type;

  DashboardPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);
    // final statsProvider = Get.find<HealthStatsProvider>();

    // final dashProvider = Get.find<DashProvider>();

    return GetBuilder<GeneralStatsProvider>(
        // init: GeneralStatsProvider(
        //   type: type,
        // ),/
        // init: AppUtils.getStatsController(),
        tag: AppUtils.getStatsControllerTag(),
        builder: (statsProvider) {
          return renderScaffold(context, statsProvider);
          // GestureDetector(
          //     onTap: () {
          //       statsProvider.calculatePolicyStatsFromHive();
          //     },
          //     child: Text("data"));

          // renderScaffold(
          //     EnumUtils.convertTypeToKey(type), context, statsProvider);
        });
  }

  Widget renderScaffold(
      BuildContext context, GeneralStatsProvider statsProvider) {
    final ScrollController scrollController = ScrollController();
    late TooltipBehavior tooltip = TooltipBehavior();

    final FocusNode _focusNode = FocusNode();
    final FlipCardController cardFlipController = FlipCardController();

    // late TooltipBehavior tooltip = TooltipBehavior();
    if (getmobile) {
      return mobileDashboardBody(
        type,
        context,
        statsProvider,
        cardFlipController,
        tooltip,
      );
    } else {
      return webDashboardBody(type, context, statsProvider, _focusNode,
          cardFlipController, tooltip, scrollController);
    }
  }
}
