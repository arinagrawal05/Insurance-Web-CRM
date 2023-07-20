// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PolicyDataHiveModelAdapter extends TypeAdapter<PolicyDataHiveModel> {
  @override
  final int typeId = 3;

  @override
  PolicyDataHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PolicyDataHiveModel(
      data: fields[0] as GenericInvestmentHiveData?,
    );
  }

  @override
  void write(BinaryWriter writer, PolicyDataHiveModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PolicyDataHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
