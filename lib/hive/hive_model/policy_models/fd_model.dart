import 'package:hive/hive.dart';
import 'generic_investment_data.dart';

part 'fd_model.g.dart';

@HiveType(typeId: 5)
class FdHiveModel extends GenericInvestmentHiveData {
  @HiveField(15)
  String fdId;

  @HiveField(14)
  String fdStatus;

  // @HiveField(15)
  // DateTime maturityDate;

  @HiveField(16)
  DateTime initialDate;

  @HiveField(17)
  DateTime certificateTakenDate;

  @HiveField(18)
  DateTime certificateGivenDate;

  @HiveField(19)
  int fDterm;

  @HiveField(20)
  int investedAmt;

  @HiveField(21)
  String fdNomineeName;

  @HiveField(22)
  String portCompanyName;

  @HiveField(23)
  String portFdNo;

  @HiveField(24)
  String portMaturityAmt;

  @HiveField(25)
  DateTime portMaturityDate;

  @HiveField(26)
  bool isCummulative;

  @HiveField(27)
  String fdNo;

  @HiveField(28)
  String cummulativeTerm;

  @HiveField(29)
  String nomineeRelation;

  @HiveField(30)
  DateTime nomineeDob;

  @HiveField(31)
  DateTime statusDate;
  @HiveField(32)
  String headName;

  @HiveField(33)
  bool isFresh;

  @HiveField(34)
  int maturityAmt;

  @HiveField(35)
  String folioNo;
  FdHiveModel({
    required String type,
    required String name,
    required String address,
    required String phone,
    required String email,
    required String userid,
    required String companyName,
    required String companyLogo,
    required String companyID,
    required bool isMale,
    required DateTime dob,
    required DateTime maturityDate,
    required String bankDetails,
    required String payMode,
    required this.fdId,
    required this.fdStatus,
    // required this.maturityDate,
    required this.maturityAmt,
    required this.fdNomineeName,
    required this.initialDate,
    required this.investedAmt,
    required this.portCompanyName,
    required this.portFdNo,
    required this.portMaturityAmt,
    required this.portMaturityDate,
    required this.fDterm,
    required this.certificateGivenDate,
    required this.certificateTakenDate,
    required this.isCummulative,
    required this.fdNo,
    required this.cummulativeTerm,
    required this.nomineeDob,
    required this.nomineeRelation,
    required this.headName,
    required this.statusDate,
    required this.isFresh,
    required this.folioNo,
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
          renewalDate: maturityDate,
        );
  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "uid": userid,
      "dob": dob,
      "name": name,
      "address": address,
      "isMale": isMale,
      "phone": phone,
      "email": email,
      "fd_id": fdId,
      "fd_status": fdStatus,
      "maturity_date": renewalDate,
      "maturity_amt": maturityAmt,
      "initial_date": initialDate,
      "invested_amt": investedAmt,
      "premium_term": fDterm,
      "nominee_name": fdNomineeName,
      "nominee_relation": nomineeRelation,
      "nominee_dob": nomineeDob,
      "fd_taken_date": certificateTakenDate,
      "fd_given_date": certificateGivenDate,
      "port_company_name": portCompanyName,
      "port_fd_no": portFdNo,
      "port_maturity_date": portMaturityDate,
      "port_maturity_amt": portMaturityAmt,
      "payMode": payMode,
      "isCummulative": isCummulative,
      "fd_no": fdNo,
      "cummulative_term": cummulativeTerm,
      "status_date": cummulativeTerm,
      "head_name": headName,
      "isFresh": isFresh,
      "folio_no": folioNo,
    };
  }

  factory FdHiveModel.fromMap(Map map) {
    return FdHiveModel(
      name: map['name'] ?? 'NA',
      phone: map['phone'] ?? "NA",
      email: map['email'] ?? "NA",
      address: map['address'] ?? "NA",
      userid: map['uid'] ?? "NA",
      headName: map['head_name'] ?? "NA",
      isMale: map['isMale'] ?? "NA",
      dob: map['dob'].toDate() ?? DateTime.now(),
      type: map['type'] ?? "NA",
      fdId: map['fd_id'] ?? "NA",
      companyName: map['company_name'] ?? "NA",
      companyID: map['company_id'] ?? "NA",
      companyLogo: map['company_logo'] ?? "NA",
      fdStatus: map['fd_status'] ?? 'NA',
      maturityDate: map['maturity_date'].toDate() ?? DateTime.now(),
      maturityAmt: map['maturity_amt'] ?? 0,
      initialDate: map['initial_date'].toDate() ?? DateTime.now(),
      fDterm: map['premium_term'] ?? 0,
      investedAmt: map['invested_amt'] ?? 0,
      fdNomineeName: map['nominee_name'] ?? "NA",
      nomineeRelation: map['nominee_relation'] ?? "NA",
      nomineeDob: map['nominee_dob'].toDate() ?? DateTime.now(),
      certificateTakenDate: map['fd_taken_date'].toDate() ?? DateTime.now(),
      certificateGivenDate: map['fd_given_date'].toDate() ?? DateTime.now(),
      statusDate: DateTime.now(),
      portCompanyName: map['port_company_name'] ?? "NA",
      portFdNo: map['port_fd_no'] ?? "NA",
      portMaturityDate: map['port_maturity_date'].toDate() ?? DateTime.now(),
      portMaturityAmt: map['port_maturity_amt'] ?? "NA",
      payMode: map['payMode'] ?? "NA",
      isCummulative: map['isCummulative'] ?? "NA",
      fdNo: map['fd_no'] ?? "NA",
      cummulativeTerm: map['cummulative_term'] ?? "NA",
      bankDetails: map['bank_details'] ?? "NA",
      isFresh: map['isFresh'] ?? true,
      folioNo: map['folio_no'] ?? "NA",
    );
  }
}
