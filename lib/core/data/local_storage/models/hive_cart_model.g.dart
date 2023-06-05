// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCartModelAdapter extends TypeAdapter<HiveCartModel> {
  @override
  final int typeId = 7;

  @override
  HiveCartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCartModel(
      orderAmount: fields[8] as double,
      customerId: fields[7] as int,
      orderId: fields[2] as String,
      mrp: fields[10] as double,
      quantity: fields[5] as double,
      rate: fields[6] as double,
      id: fields[0] as int,
      unit: fields[9] as String,
      stock: fields[11] as double,
      userId: fields[1] as int,
      productId: fields[3] as String,
      productName: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCartModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.orderId)
      ..writeByte(3)
      ..write(obj.productId)
      ..writeByte(4)
      ..write(obj.productName)
      ..writeByte(5)
      ..write(obj.quantity)
      ..writeByte(6)
      ..write(obj.rate)
      ..writeByte(7)
      ..write(obj.customerId)
      ..writeByte(8)
      ..write(obj.orderAmount)
      ..writeByte(9)
      ..write(obj.unit)
      ..writeByte(10)
      ..write(obj.mrp)
      ..writeByte(11)
      ..write(obj.stock);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
