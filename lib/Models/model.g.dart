// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoordinatorModelAdapter extends TypeAdapter<CoordinatorModel> {
  @override
  final int typeId = 1;

  @override
  CoordinatorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoordinatorModel(
      id: fields[0] as String,
      one: fields[1] as String,
      two: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CoordinatorModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.one)
      ..writeByte(2)
      ..write(obj.two);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoordinatorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MembersModelAdapter extends TypeAdapter<MembersModel> {
  @override
  final int typeId = 2;

  @override
  MembersModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MembersModel(
      id: fields[0] as String,
      member: fields[1] as String,
      check: fields[2] as bool,
      reason: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MembersModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.member)
      ..writeByte(2)
      ..write(obj.check)
      ..writeByte(3)
      ..write(obj.reason);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MembersModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BatchModelAdapter extends TypeAdapter<BatchModel> {
  @override
  final int typeId = 3;

  @override
  BatchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BatchModel(
      id: fields[0] as String,
      batch: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BatchModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.batch);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BatchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
