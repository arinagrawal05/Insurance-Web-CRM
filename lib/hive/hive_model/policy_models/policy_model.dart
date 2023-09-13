import 'package:hive/hive.dart';
import 'generic_investment_data.dart';

part 'policy_model.g.dart';

@HiveType(typeId: 4)
class PolicyHiveModel extends GenericInvestmentHiveData {
  @HiveField(22)
  String policyID;

  @HiveField(14)
  String policyStatus;

  @HiveField(15)
  String policyNo;

  @HiveField(16)
  int membersCount;

  @HiveField(17)
  int premuimAmt;

  @HiveField(18)
  int sumAssured;

  @HiveField(19)
  int premiumTerm;

  @HiveField(20)
  DateTime issuedDate;

  @HiveField(21)
  DateTime inceptionDate;

  // @HiveField(22)
  // DateTime renewalDate;

  @HiveField(23)
  String planName;

  @HiveField(24)
  String planID;

  @HiveField(25)
  String advisorName;

  @HiveField(26)
  String nomineeName;

  @HiveField(27)
  bool isFresh;

  @HiveField(28)
  String portCompanyName;

  @HiveField(29)
  String portPolicyNo;

  @HiveField(30)
  String portSumAssured;

  @HiveField(31)
  DateTime portIssueDate;

  @HiveField(32)
  DateTime statusDate;

  PolicyHiveModel({
    required String type,
    required String name,
    required String address,
    required String phone,
    required String email,
    required String userid,
    required bool isMale,
    required DateTime dob,
    required DateTime renewalDate,
    required String companyName,
    required String companyID,
    required String companyLogo,
    required String bankDetails,
    required String payMode,
    required this.membersCount,
    required this.policyID,
    required this.policyNo,
    required this.policyStatus,
    required this.premuimAmt,
    required this.premiumTerm,
    required this.sumAssured,
    required this.issuedDate,
    // required this.renewalDate,
    required this.planID,
    required this.planName,
    required this.advisorName,
    required this.nomineeName,
    required this.isFresh,
    required this.portCompanyName,
    required this.portPolicyNo,
    required this.portIssueDate,
    required this.portSumAssured,
    required this.statusDate,
    required this.inceptionDate,
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
            renewalDate: renewalDate);
  Map<String, dynamic> toMap() {
    return {
      "company_name": companyName,
      "company_logo": companyLogo,
      "company_id": companyID,
      "plan_name": planName,
      "plan_id": planID,
      "policy_id": policyID,
      "uid": userid,
      "dob": dob,
      "members_count": membersCount,
      "name": name,
      "address": address,
      "isMale": isMale,
      "phone": phone,
      "email": email,
      "renewal_date": renewalDate,
      "policy_no": policyNo,
      "issued_date": issuedDate,
      "policy_status": policyStatus,
      "sum_assured": sumAssured,
      "premium_amt": premuimAmt,
      "premium_term": premiumTerm,
      "nominee_name": nomineeName,
      "advisor_name": advisorName,
      "isFress": isFresh,
      "payMode": payMode,
      "port_company_name": portCompanyName,
      "port_policy_no": portPolicyNo,
      "port_issue_date": portIssueDate,
      "port_sum_assured": portSumAssured,
      "status_date": statusDate,
      "inception_date": inceptionDate,
    };
  }

  factory PolicyHiveModel.fromMap(Map map) {
    return PolicyHiveModel(
      name: map['name'] ?? map['policy_id'] ?? "NA",
      phone: map['phone'] ?? 'NA',
      email: map['email'] ?? 'NA',
      address: map['address'] ?? 'NA',
      userid: map['uid'] ?? 'NA',
      isMale: map['isMale'] ?? 'NA',
      dob: map['dob'].toDate() ?? DateTime.now(),
      membersCount: map['members_count'] ?? 0,
      premiumTerm: map['premium_term'] ?? 0,
      policyID: map['policy_id'] ?? "NA",
      issuedDate: map['issued_date'].toDate() ?? DateTime.now(),
      policyNo: map['policy_no'] ?? "NA",
      policyStatus: map['policy_status'] ?? "NA",
      premuimAmt: map['premium_amt'] ?? 0,
      renewalDate: map['renewal_date'].toDate() ?? DateTime.now(),
      sumAssured: map['sum_assured'] ?? 0,
      companyName: map['company_name'] ?? "NA",
      companyLogo: map['company_logo'] ?? "NA",
      companyID: map['company_id'] ?? "NA",
      bankDetails: map['bank_details'] ?? "NA",
      planID: map['plan_id'] ?? "NA",
      planName: map['plan_name'] ?? "NA",
      nomineeName: map['nominee_name'] ?? "NA",
      advisorName: map['advisor_name'] ?? "NA",
      isFresh: map['isFress'] ?? "NA",
      payMode: map['payMode'] ?? "NA",
      portCompanyName: map['port_company_name'] ?? "NA",
      portPolicyNo: map['port_policy_no'] ?? "NA",
      portSumAssured: map['port_sum_assured'] ?? "NA",
      portIssueDate: map['port_issue_date'].toDate() ?? DateTime.now(),
      statusDate: map['status_date'].toDate() ?? DateTime.now(),
      inceptionDate: map['inception_date'].toDate() ?? DateTime.now(),
      type: map['type'] ?? "NA",
    );
  }
}
