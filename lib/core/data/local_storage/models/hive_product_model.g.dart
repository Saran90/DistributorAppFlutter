// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveProductModelAdapter extends TypeAdapter<HiveProductModel> {
  @override
  final int typeId = 2;

  @override
  HiveProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveProductModel(
      name: fields[1] as String?,
      id: fields[0] as int?,
      total: fields[9] as double?,
      category: fields[2] as String?,
      image: fields[7] as String?,
      mrp: fields[4] as double?,
      quantity: fields[8] as int?,
      rate: fields[5] as double?,
      stock: fields[6] as double?,
      unit: fields[3] as String?,
      status: fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveProductModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.unit)
      ..writeByte(4)
      ..write(obj.mrp)
      ..writeByte(5)
      ..write(obj.rate)
      ..writeByte(6)
      ..write(obj.stock)
      ..writeByte(7)
      ..write(obj.image)
      ..writeByte(8)
      ..write(obj.quantity)
      ..writeByte(9)
      ..write(obj.total)
      ..writeByte(10)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
