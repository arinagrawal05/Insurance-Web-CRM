import 'generic_investment_data.dart';
import 'package:health_model/shared/exports.dart';

part 'motor_model.g.dart';

@HiveType(typeId: 7)
class MotorHiveModel extends GenericInvestmentHiveData {
  @HiveField(13)
  String motorNo;

  @HiveField(14)
  String motorID;

  @HiveField(16)
  String motorStatus;

  @HiveField(17)
  int premiumAmt;

  @HiveField(19)
  DateTime initialDate;

  @HiveField(20)
  DateTime renewalDate;

  @HiveField(21)
  String nomineeName;

  @HiveField(22)
  DateTime nomineeDOB;

  @HiveField(23)
  int sumAssured;

  @HiveField(24)
  String vCompanyName;

  @HiveField(25)
  String vType;

  @HiveField(26)
  String vMake;

  @HiveField(27)
  String vChesis;

  @HiveField(28)
  String vCC;

  @HiveField(29)
  String vYOM;

  @HiveField(30)
  String vEngine;

  @HiveField(31)
  String vRegistrationNo;

  @HiveField(32)
  String vModel;

  MotorHiveModel({
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
    required this.motorStatus,
    required this.initialDate,
    required this.renewalDate,
    required this.nomineeName,
    required this.nomineeDOB,
    required this.sumAssured,
    required this.vCompanyName,
    required this.vType,
    required this.vMake,
    required this.vChesis,
    required this.vCC,
    required this.vYOM,
    required this.vEngine,
    required this.vRegistrationNo,
    required this.vModel,
    required this.premiumAmt,
    required this.motorID,
    required this.motorNo,
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
      "_id": motorID,
      "uid": userid,
      "dob": dob,
      "name": name,
      "address": address,
      "isMale": isMale,
      "phone": phone,
      "email": email,
      "motor_no": motorNo,
      "motor_status": motorStatus,
      "sum_assured": sumAssured,
    };
  }

  factory MotorHiveModel.fromMap(Map data) {
    return MotorHiveModel(
      companyLogo: data['company_logo'] ?? "NA",
      companyName: data['company_name'] ?? "NA",
      companyID: data['company_id'] ?? "NA",
      name: data['name'] ?? "NA",
      dob: data['dob'].toDate(),
      address: data['address'] ?? "NA",
      isMale: data['isMale'] ?? false,
      phone: data['phone'] ?? "NA",
      email: data['email'] ?? "NA",
      motorStatus: data['motor_status'] ?? "NA",
      type: data['type'] ?? "NA",
      initialDate: data['initial_date'].toDate(),
      renewalDate: data['renewal_date'].toDate(),
      nomineeName: data['nominee_name'] ?? "NA",
      nomineeDOB: data['nominee_dob'].toDate(),
      sumAssured: data['sum_assured'] ?? "NA",
      vCompanyName: data['v_company_name'] ?? "NA",
      vType: data['v_type'] ?? "NA",
      vMake: data['v_make'] ?? "NA",
      vChesis: data['v_chesis'] ?? "NA",
      vCC: data['v_cc'] ?? "NA",
      vYOM: data['v_yom'] ?? "NA",
      vEngine: data['v_engine'] ?? "NA",
      vRegistrationNo: data['v_regstration_no'] ?? "NA",
      vModel: data['v_model'] ?? "NA",
      payMode: data['payMode'] ?? "NA",
      bankDetails: data['bank_details'] ?? "NA",
      motorID: data['motor_id'] ?? "NA",
      motorNo: data['motor_no'] ?? "NA",
      premiumAmt: data['premium_amt'] ?? 0,
      userid: data['uid'] ?? "NA",
    );
  }
}
