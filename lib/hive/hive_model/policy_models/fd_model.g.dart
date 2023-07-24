// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fd_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FdHiveModelAdapter extends TypeAdapter<FdHiveModel> {
  @override
  final int typeId = 5;

  @override
  FdHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FdHiveModel(
      type: fields[0] as String,
      name: fields[1] as String,
      address: fields[2] as String,
      phone: fields[3] as String,
      email: fields[4] as String,
      userid: fields[7] as String,
      companyName: fields[8] as String,
      companyLogo: fields[9] as String,
      companyID: fields[10] as String,
      isMale: fields[5] as bool,
      dob: fields[6] as DateTime,
      bankDetails: fields[11] as String,
      payMode: fields[12] as String,
      fdId: fields[13] as String,
      fdStatus: fields[14] as String,
      maturityDate: fields[15] as DateTime,
      fdNomineeName: fields[21] as String,
      initialDate: fields[16] as DateTime,
      investedAmt: fields[20] as int,
      portCompanyName: fields[22] as String,
      portFdNo: fields[23] as String,
      portMaturityAmt: fields[24] as String,
      portMaturityDate: fields[25] as DateTime,
      fDterm: fields[19] as int,
      certificateGivenDate: fields[18] as DateTime,
      certificateTakenDate: fields[17] as DateTime,
      isCummulative: fields[26] as bool,
      fdNo: fields[27] as String,
      cummulativeTerm: fields[28] as String,
      nomineeDob: fields[30] as DateTime,
      nomineeRelation: fields[29] as String,
      headName: fields[32] as String,
      statusDate: fields[31] as DateTime,
      isFresh: fields[33] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FdHiveModel obj) {
    writer
      ..writeByte(34)
      ..writeByte(13)
      ..write(obj.fdId)
      ..writeByte(14)
      ..write(obj.fdStatus)
      ..writeByte(15)
      ..write(obj.maturityDate)
      ..writeByte(16)
      ..write(obj.initialDate)
      ..writeByte(17)
      ..write(obj.certificateTakenDate)
      ..writeByte(18)
      ..write(obj.certificateGivenDate)
      ..writeByte(19)
      ..write(obj.fDterm)
      ..writeByte(20)
      ..write(obj.investedAmt)
      ..writeByte(21)
      ..write(obj.fdNomineeName)
      ..writeByte(22)
      ..write(obj.portCompanyName)
      ..writeByte(23)
      ..write(obj.portFdNo)
      ..writeByte(24)
      ..write(obj.portMaturityAmt)
      ..writeByte(25)
      ..write(obj.portMaturityDate)
      ..writeByte(26)
      ..write(obj.isCummulative)
      ..writeByte(27)
      ..write(obj.fdNo)
      ..writeByte(28)
      ..write(obj.cummulativeTerm)
      ..writeByte(29)
      ..write(obj.nomineeRelation)
      ..writeByte(30)
      ..write(obj.nomineeDob)
      ..writeByte(31)
      ..write(obj.statusDate)
      ..writeByte(32)
      ..write(obj.headName)
      ..writeByte(33)
      ..write(obj.isFresh)
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
      other is FdHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
