import 'package:hive/hive.dart';

part 'hive_customer_model.g.dart';

@HiveType(typeId: 3)
class HiveCustomerModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? address;
  @HiveField(3)
  String? pincode;
  @HiveField(4)
  String? location;
  @HiveField(5)
  String? contactPerson;
  @HiveField(6)
  String? contactNumber;
  @HiveField(7)
  int? status;

  HiveCustomerModel(
      {this.id,
      this.name,
      this.address,
      this.contactNumber,
      this.contactPerson,
      this.location,
      this.pincode,
      this.status});
}
