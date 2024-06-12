// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DocHiveModelAdapter extends TypeAdapter<DocHiveModel> {
  @override
  final int typeId = 8;

  @override
  DocHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DocHiveModel(
      docId: fields[0] as String,
      userId: fields[1] as String,
      docCreated: fields[2] as DateTime,
      name: fields[3] as String,
      docFormat: fields[4] as String,
      docType: fields[5] as String,
      docName: fields[6] as String,
      docUrl: fields[7] as String,
      timestamp: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DocHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.docId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.docCreated)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.docFormat)
      ..writeByte(5)
      ..write(obj.docType)
      ..writeByte(6)
      ..write(obj.docName)
      ..writeByte(7)
      ..write(obj.docUrl)
      ..writeByte(8)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
