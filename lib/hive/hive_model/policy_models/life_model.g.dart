// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'life_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LifeHiveModelAdapter extends TypeAdapter<LifeHiveModel> {
  @override
  final int typeId = 6;

  @override
  LifeHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LifeHiveModel(
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
      lifeID: fields[13] as String,
      lifeNo: fields[15] as String,
      lifeStatus: fields[14] as String,
      premuimAmt: fields[17] as int,
      payingTillDate: fields[19] as DateTime,
      sumAssured: fields[18] as int,
      commitmentDate: fields[20] as DateTime,
      renewalDate: fields[22] as DateTime,
      planID: fields[24] as String,
      planName: fields[23] as String,
      advisorName: fields[25] as String,
      nomineeName: fields[26] as String,
      nomineeDob: fields[27] as DateTime,
      nomineeRelation: fields[28] as String,
      lastRenewedDate: fields[30] as DateTime,
      maturityDate: fields[21] as DateTime,
      headName: fields[29] as String,
      payterm: fields[31] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LifeHiveModel obj) {
    writer
      ..writeByte(31)
      ..writeByte(13)
      ..write(obj.lifeID)
      ..writeByte(14)
      ..write(obj.lifeStatus)
      ..writeByte(15)
      ..write(obj.lifeNo)
      ..writeByte(17)
      ..write(obj.premuimAmt)
      ..writeByte(18)
      ..write(obj.sumAssured)
      ..writeByte(19)
      ..write(obj.payingTillDate)
      ..writeByte(20)
      ..write(obj.commitmentDate)
      ..writeByte(21)
      ..write(obj.maturityDate)
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
      ..write(obj.nomineeDob)
      ..writeByte(28)
      ..write(obj.nomineeRelation)
      ..writeByte(29)
      ..write(obj.headName)
      ..writeByte(30)
      ..write(obj.lastRenewedDate)
      ..writeByte(31)
      ..write(obj.payterm)
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
      other is LifeHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
