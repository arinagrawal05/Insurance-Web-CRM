// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PolicyHiveModelAdapter extends TypeAdapter<PolicyHiveModel> {
  @override
  final int typeId = 4;

  @override
  PolicyHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PolicyHiveModel(
      type: fields[0] as String,
      name: fields[1] as String,
      address: fields[2] as String,
      phone: fields[3] as String,
      email: fields[4] as String,
      userid: fields[7] as String,
      isMale: fields[5] as bool,
      dob: fields[6] as DateTime,
      companyName: fields[8] as String,
      companyID: fields[10] as String,
      companyLogo: fields[9] as String,
      bankDetails: fields[11] as String,
      payMode: fields[12] as String,
      membersCount: fields[16] as int,
      policyID: fields[13] as String,
      policyNo: fields[15] as String,
      policyStatus: fields[14] as String,
      premuimAmt: fields[17] as int,
      premiumTerm: fields[19] as int,
      sumAssured: fields[18] as int,
      issuedDate: fields[20] as DateTime,
      renewalDate: fields[22] as DateTime,
      planID: fields[24] as String,
      planName: fields[23] as String,
      advisorName: fields[25] as String,
      nomineeName: fields[26] as String,
      isFresh: fields[27] as bool,
      portCompanyName: fields[28] as String,
      portPolicyNo: fields[29] as String,
      portIssueDate: fields[31] as DateTime,
      portSumAssured: fields[30] as String,
      statusDate: fields[32] as DateTime,
      inceptionDate: fields[21] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PolicyHiveModel obj) {
    writer
      ..writeByte(33)
      ..writeByte(13)
      ..write(obj.policyID)
      ..writeByte(14)
      ..write(obj.policyStatus)
      ..writeByte(15)
      ..write(obj.policyNo)
      ..writeByte(16)
      ..write(obj.membersCount)
      ..writeByte(17)
      ..write(obj.premuimAmt)
      ..writeByte(18)
      ..write(obj.sumAssured)
      ..writeByte(19)
      ..write(obj.premiumTerm)
      ..writeByte(20)
      ..write(obj.issuedDate)
      ..writeByte(21)
      ..write(obj.inceptionDate)
      ..writeByte(22)
      ..write(obj.renewalDate)
      ..writeByte(23)
      ..write(obj.planName)
      ..writeByte(24)
      ..write(obj.planID)
      ..writeByte(25)
      ..write(obj.advisorName)
      ..writeByte(26)
      ..write(obj.nomineeName)
      ..writeByte(27)
      ..write(obj.isFresh)
      ..writeByte(28)
      ..write(obj.portCompanyName)
      ..writeByte(29)
      ..write(obj.portPolicyNo)
      ..writeByte(30)
      ..write(obj.portSumAssured)
      ..writeByte(31)
      ..write(obj.portIssueDate)
      ..writeByte(32)
      ..write(obj.statusDate)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.isMale)
      ..writeByte(6)
      ..write(obj.dob)
      ..writeByte(7)
      ..write(obj.userid)
      ..writeByte(8)
      ..write(obj.companyName)
      ..writeByte(9)
      ..write(obj.companyLogo)
      ..writeByte(10)
      ..write(obj.companyID)
      ..writeByte(11)
      ..write(obj.bankDetails)
      ..writeByte(12)
      ..write(obj.payMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PolicyHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
