// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_customer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCustomerModelAdapter extends TypeAdapter<HiveCustomerModel> {
  @override
  final int typeId = 3;

  @override
  HiveCustomerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCustomerModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      address: fields[2] as String?,
      contactNumber: fields[6] as String?,
      contactPerson: fields[5] as String?,
      location: fields[4] as String?,
      pincode: fields[3] as String?,
      status: fields[7] as int?,
      accountBalance: fields[8] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCustomerModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.pincode)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.contactPerson)
      ..writeByte(6)
      ..write(obj.contactNumber)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.accountBalance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCustomerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
