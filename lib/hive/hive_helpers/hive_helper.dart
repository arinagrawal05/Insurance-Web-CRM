import 'package:health_model/shared/exports.dart';

class HiveHelper {
  static void init() async {
    await Hive.initFlutter();
    UserHiveHelper.init();
    CommissionHiveHelper.init();
    PolicyHiveHelper.init();
  }
}
