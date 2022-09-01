// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fact_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FactModelAdapter extends TypeAdapter<FactModel> {
  @override
  final int typeId = 0;

  @override
  FactModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FactModel(
      fact: fields[0] as String,
      length: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FactModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.fact)
      ..writeByte(1)
      ..write(obj.length);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FactModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
