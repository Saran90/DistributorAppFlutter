// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_order_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveOrderDetailsModelAdapter extends TypeAdapter<HiveOrderDetailsModel> {
  @override
  final int typeId = 5;

  @override
  HiveOrderDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveOrderDetailsModel(
      id: fields[0] as int,
      rate: fields[5] as double,
      quantity: fields[4] as int,
      mrp: fields[6] as double,
      status: fields[8] as int,
      orderDate: fields[9] as DateTime,
      orderId: fields[1] as int,
      productId: fields[2] as int,
      productName: fields[3] as String,
      total: fields[7] as double,
      dateTime: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HiveOrderDetailsModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.orderId)
      ..writeByte(2)
      ..write(obj.productId)
      ..writeByte(3)
      ..write(obj.productName)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.rate)
      ..writeByte(6)
      ..write(obj.mrp)
      ..writeByte(7)
      ..write(obj.total)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.orderDate)
      ..writeByte(10)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveOrderDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
