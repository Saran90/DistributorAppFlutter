// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLocationModelAdapter extends TypeAdapter<HiveLocationModel> {
  @override
  final int typeId = 4;

  @override
  HiveLocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLocationModel(
      text: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveLocationModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
