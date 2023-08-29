import 'package:health_model/shared/exports.dart';

part 'commission_hive_model.g.dart';

@HiveType(typeId: 1)
class CommissionHiveModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String policyID;

  @HiveField(2)
  String policyNo;

  @HiveField(3)
  DateTime issuedDate;

  @HiveField(4)
  DateTime commissionDate;

  @HiveField(5)
  bool isPending;

  @HiveField(6)
  int premiumAmt;

  @HiveField(7)
  int commissionAmt;

  @HiveField(8)
  String companyName;

  @HiveField(9)
  String commissionType;

  @HiveField(10)
  String commissionId;

  CommissionHiveModel({
    required this.name,
    required this.commissionAmt,
    required this.commissionDate,
    required this.isPending,
    required this.premiumAmt,
    required this.policyID,
    required this.policyNo,
    required this.issuedDate,
    required this.commissionId,
    required this.companyName,
    required this.commissionType,
  });

  Map<String, dynamic> toMap() {
    return {
      "policy_id": policyID,
      "name": name,
      "commission_date": commissionDate,
      "policy_no": policyNo,
      "issued_date": issuedDate,
      "isPending": isPending,
      "premium_amt": premiumAmt,
      "commission_amt": commissionAmt,
      "commission_id": commissionId,
      "company_name": companyName,
      "commission_type": commissionType,
    };
  }

  factory CommissionHiveModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();

    return CommissionHiveModel(
      name: map['name'],
      policyID: map['policy_id'],
      issuedDate: map['issued_date'].toDate(),
      policyNo: map['policy_no'],
      isPending: map['isPending'],
      premiumAmt: map['premium_amt'],
      commissionDate: map['commission_date'].toDate(),
      commissionAmt: map['commission_amt'],
      companyName: map['company_name'],
      commissionId: map['commission_id'],
      commissionType: map['commission_type'],
    );
  }
}
