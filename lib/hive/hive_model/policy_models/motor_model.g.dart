// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'motor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MotorHiveModelAdapter extends TypeAdapter<MotorHiveModel> {
  @override
  final int typeId = 7;

  @override
  MotorHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MotorHiveModel(
      type: fields[0] as String,
      name: fields[1] as String,
      address: fields[2] as String,
      phone: fields[3] as String,
      email: fields[4] as String,
      userid: fields[7] as String,
      isMale: fields[5] as bool,
      dob: fields[6] as DateTime,
      renewalDate: fields[13] as DateTime,
      companyName: fields[8] as String,
      companyID: fields[10] as String,
      companyLogo: fields[9] as String,
      bankDetails: fields[11] as String,
      payMode: fields[12] as String,
      motorStatus: fields[16] as String,
      initialDate: fields[19] as DateTime,
      nomineeName: fields[21] as String,
      nomineeDOB: fields[22] as DateTime,
      sumAssured: fields[23] as int,
      vCompanyName: fields[24] as String,
      vType: fields[25] as String,
      vMake: fields[26] as String,
      vChesis: fields[27] as String,
      vCC: fields[28] as String,
      vYOM: fields[29] as String,
      vEngine: fields[30] as String,
      vRegistrationNo: fields[31] as String,
      vModel: fields[32] as String,
      premiumAmt: fields[17] as int,
      motorID: fields[14] as String,
      motorNo: fields[20] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MotorHiveModel obj) {
    writer
      ..writeByte(31)
      ..writeByte(20)
      ..write(obj.motorNo)
      ..writeByte(14)
      ..write(obj.motorID)
      ..writeByte(16)
      ..write(obj.motorStatus)
      ..writeByte(17)
      ..write(obj.premiumAmt)
      ..writeByte(19)
      ..write(obj.initialDate)
      ..writeByte(21)
      ..write(obj.nomineeName)
      ..writeByte(22)
      ..write(obj.nomineeDOB)
      ..writeByte(23)
      ..write(obj.sumAssured)
      ..writeByte(24)
      ..write(obj.vCompanyName)
      ..writeByte(25)
      ..write(obj.vType)
      ..writeByte(26)
      ..write(obj.vMake)
      ..writeByte(27)
      ..write(obj.vChesis)
      ..writeByte(28)
      ..write(obj.vCC)
      ..writeByte(29)
      ..write(obj.vYOM)
      ..writeByte(30)
      ..write(obj.vEngine)
      ..writeByte(31)
      ..write(obj.vRegistrationNo)
      ..writeByte(32)
      ..write(obj.vModel)
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
      ..write(obj.payMode)
      ..writeByte(13)
      ..write(obj.renewalDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MotorHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
