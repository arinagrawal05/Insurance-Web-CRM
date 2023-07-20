// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommissionHiveModelAdapter extends TypeAdapter<CommissionHiveModel> {
  @override
  final int typeId = 1;

  @override
  CommissionHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommissionHiveModel(
      name: fields[0] as String,
      commissionAmt: fields[7] as int,
      commissionDate: fields[4] as DateTime,
      isPending: fields[5] as bool,
      premiumAmt: fields[6] as int,
      policyID: fields[1] as String,
      policyNo: fields[2] as String,
      issuedDate: fields[3] as DateTime,
      commissionId: fields[10] as String,
      companyName: fields[8] as String,
      commissionType: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CommissionHiveModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.policyID)
      ..writeByte(2)
      ..write(obj.policyNo)
      ..writeByte(3)
      ..write(obj.issuedDate)
      ..writeByte(4)
      ..write(obj.commissionDate)
      ..writeByte(5)
      ..write(obj.isPending)
      ..writeByte(6)
      ..write(obj.premiumAmt)
      ..writeByte(7)
      ..write(obj.commissionAmt)
      ..writeByte(8)
      ..write(obj.companyName)
      ..writeByte(9)
      ..write(obj.commissionType)
      ..writeByte(10)
      ..write(obj.commissionId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommissionHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
