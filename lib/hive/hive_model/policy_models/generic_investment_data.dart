import 'package:hive/hive.dart';

part 'generic_investment_data.g.dart';

@HiveType(typeId: 2)
class GenericInvestmentHiveData extends HiveObject {
  @HiveField(0)
  String type;

  @HiveField(1)
  String name;

  @HiveField(2)
  String address;

  @HiveField(3)
  String phone;

  @HiveField(4)
  String email;

  @HiveField(5)
  bool isMale;

  @HiveField(6)
  DateTime dob;

  @HiveField(7)
  String userid;

  @HiveField(8)
  String companyName;

  @HiveField(9)
  String companyLogo;

  @HiveField(10)
  String companyID;

  @HiveField(11)
  String bankDetails;

  @HiveField(12)
  String payMode;

  @HiveField(13)
  DateTime renewalDate;
  GenericInvestmentHiveData({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.isMale,
    required this.dob,
    required this.userid,
    required this.type,
    required this.companyName,
    required this.companyID,
    required this.companyLogo,
    required this.bankDetails,
    required this.payMode,
    required this.renewalDate,
  });
}
