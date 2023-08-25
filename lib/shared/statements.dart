import 'package:health_model/hive/hive_model/policy_models/fd_model.dart';
import 'package:health_model/shared/enum_utils.dart';
import 'package:health_model/shared/exports.dart';

import '../hive/hive_model/user_hive_model.dart';

class Statements {
  static String removeClient = "Do You Really Want to Remove this Client";
  static String removeHealth = "Do You Really Want to Remove this Policy";
  static String removeFD = "Do You Really Want to Remove this FD";
  static String removePlan = "Do You Really Want to Remove this Plan";
  static String removeCompany = "Do You Really Want to Remove this Company";
  static String removeMember = "Do You Really Want to Remove this Member";

  static String handoverFD = "Do You Really Want to Handover this FD to Client";
  static String redeemFD = "Do You Really Want to Redeem this FD";
}
