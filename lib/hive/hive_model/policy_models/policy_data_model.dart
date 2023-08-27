import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_model/hive/hive_model/policy_models/fd_model.dart';
import 'package:health_model/hive/hive_model/policy_models/policy_model.dart';
import 'package:health_model/shared/const.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'generic_investment_data.dart';
import 'life_model.dart';

part 'policy_data_model.g.dart';

@HiveType(typeId: 3)
class PolicyDataHiveModel extends HiveObject {
  @HiveField(0)
  GenericInvestmentHiveData? data;

  factory PolicyDataHiveModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();

    if (map['type'] == AppConsts.fd) {
      return PolicyDataHiveModel(data: FdHiveModel.fromMap(map));
    } else if (map['type'] == AppConsts.health) {
      return PolicyDataHiveModel(data: PolicyHiveModel.fromMap(map));
    } else if (map['type'] == AppConsts.life) {
      return PolicyDataHiveModel(data: LifeHiveModel.fromMap(map));
    } else {
      return PolicyDataHiveModel(data: null);
    }
  }

  PolicyDataHiveModel({required this.data});
}
