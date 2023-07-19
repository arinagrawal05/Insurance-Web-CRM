import 'package:health_model/hive/hive_helpers/commission_hive_helper.dart';
import 'package:health_model/hive/hive_helpers/user_hive_helper.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static void init() async {
    await Hive.initFlutter();
    UserHiveHelper.init();
    CommissionHiveHelper.init();
  }
}
