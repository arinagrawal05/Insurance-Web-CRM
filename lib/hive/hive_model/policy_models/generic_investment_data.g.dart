// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_investment_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GenericInvestmentHiveDataAdapter
    extends TypeAdapter<GenericInvestmentHiveData> {
  @override
  final int typeId = 2;

  @override
  GenericInvestmentHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GenericInvestmentHiveData(
      name: fields[1] as String,
      address: fields[2] as String,
      phone: fields[3] as String,
      email: fields[4] as String,
      isMale: fields[5] as bool,
      dob: fields[6] as DateTime,
      userid: fields[7] as String,
      type: fields[0] as String,
      companyName: fields[8] as String,
      companyID: fields[10] as String,
      companyLogo: fields[9] as String,
      bankDetails: fields[11] as String,
      payMode: fields[12] as String,
      renewalDate: fields[13] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GenericInvestmentHiveData obj) {
    writer
      ..writeByte(14)
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
      other is GenericInvestmentHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
