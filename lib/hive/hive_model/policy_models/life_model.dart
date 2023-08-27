import 'package:hive/hive.dart';
import 'generic_investment_data.dart';
part 'life_model.g.dart';

@HiveType(typeId: 6)
class LifeHiveModel extends GenericInvestmentHiveData {
  @HiveField(13)
  String lifeID;

  @HiveField(14)
  String lifeStatus;

  @HiveField(15)
  String lifeNo;

  @HiveField(17)
  int premuimAmt;

  @HiveField(18)
  int sumAssured;

  @HiveField(19)
  int payingTerm;

  @HiveField(20)
  DateTime commitmentDate;

  @HiveField(21)
  DateTime maturityDate;

  @HiveField(22)
  DateTime renewalDate;

  @HiveField(23)
  String planName;

  @HiveField(24)
  String planID;

  @HiveField(25)
  String advisorName;

  @HiveField(26)
  String nomineeName;

  @HiveField(27)
  DateTime nomineeDob;
  @HiveField(28)
  String nomineeRelation;
  @HiveField(29)
  String headName;
  @HiveField(30)
  DateTime statusDate;

  LifeHiveModel({
    required String type,
    required String name,
    required String address,
    required String phone,
    required String email,
    required String userid,
    required bool isMale,
    required DateTime dob,
    required String companyName,
    required String companyID,
    required String companyLogo,
    required String bankDetails,
    required String payMode,
    required this.lifeID,
    required this.lifeNo,
    required this.lifeStatus,
    required this.premuimAmt,
    required this.payingTerm,
    required this.sumAssured,
    required this.commitmentDate,
    required this.renewalDate,
    required this.planID,
    required this.planName,
    required this.advisorName,
    required this.nomineeName,
    required this.nomineeDob,
    required this.nomineeRelation,
    required this.statusDate,
    required this.maturityDate,
    required this.headName,
  }) : super(
          type: type,
          address: address,
          dob: dob,
          email: email,
          isMale: isMale,
          name: name,
          phone: phone,
          userid: userid,
          companyName: companyName,
          companyID: companyID,
          companyLogo: companyLogo,
          bankDetails: bankDetails,
          payMode: payMode,
        );
  Map<String, dynamic> toMap() {
    return {
      "company_name": companyName,
      "company_logo": companyLogo,
      "company_id": companyID,
      "plan_name": planName,
      "plan_id": planID,
      "policy_id": lifeID,
      "uid": userid,
      "dob": dob,
      "name": name,
      "address": address,
      "isMale": isMale,
      "phone": phone,
      "email": email,
      "renewal_date": renewalDate,
      "policy_no": lifeNo,
      "issued_date": commitmentDate,
      "policy_status": lifeStatus,
      "sum_assured": sumAssured,
      "premium_amt": premuimAmt,
      "paying_term": payingTerm,
      "nominee_name": nomineeName,
      "advisor_name": advisorName,
      "payMode": payMode,
      "status_date": statusDate,
      "inception_date": maturityDate,
    };
  }

  factory LifeHiveModel.fromMap(Map data) {
    return LifeHiveModel(
      companyLogo: data['company_logo'] ?? "NA",
      companyName: data['company_name'] ?? "NA",
      companyID: data['company_id'] ?? "NA",
      lifeNo: data['life_no'] ?? "NA",
      lifeID: data['life_id'] ?? "NA",
      headName: data['head_name'] ?? "NA",
      name: data['name'] ?? "NA",
      userid: data['uid'] ?? "NA",
      dob: data['dob'].toDate(),
      address: data['address'] ?? "NA",
      isMale: data['isMale'] ?? false,
      phone: data['phone'] ?? "NA",
      email: data['email'] ?? "NA",
      commitmentDate: data['commitment_date'].toDate(),
      maturityDate: data['maturity_date'].toDate(),
      lifeStatus: data['life_status'] ?? "NA",
      premuimAmt: data['premuim_amt'] ?? 0,
      type: data['type'] ?? "NA",
      advisorName: data['type'] ?? "NA",
      planID: data['type'] ?? "NA",
      planName: data['type'] ?? "NA",
      renewalDate: data['renewal_date'].toDate() ?? DateTime.now(),
      sumAssured: data['sum_assured'] ?? 0,
      payingTerm: data['paying_term'] ?? "NA",
      nomineeName: data['nominee_name'] ?? "NA",
      nomineeRelation: data['nominee_relation'] ?? "NA",
      nomineeDob: data['nominee_dob'].toDate(),
      payMode: data['payMode'] ?? "NA",
      bankDetails: data['bank_details'] ?? "NA",
      statusDate: data['status_date'].toDate(),
    );
  }
}
