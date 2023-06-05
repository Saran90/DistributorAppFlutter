// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_order_summary_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveOrderSummaryModelAdapter extends TypeAdapter<HiveOrderSummaryModel> {
  @override
  final int typeId = 6;

  @override
  HiveOrderSummaryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveOrderSummaryModel(
      orderId: fields[0] as int,
      orderDate: fields[5] as DateTime,
      status: fields[3] as int,
      customerId: fields[1] as int,
      orderAmount: fields[4] as double,
      userId: fields[2] as int,
      customerName: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveOrderSummaryModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.orderId)
      ..writeByte(1)
      ..write(obj.customerId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.orderAmount)
      ..writeByte(5)
      ..write(obj.orderDate)
      ..writeByte(6)
      ..write(obj.customerName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveOrderSummaryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
