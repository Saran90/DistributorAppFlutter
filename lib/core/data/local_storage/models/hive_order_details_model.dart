import 'package:hive/hive.dart';

part 'hive_order_details_model.g.dart';

@HiveType(typeId: 5)
class HiveOrderDetailsModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  int orderId;
  @HiveField(2)
  int productId;
  @HiveField(3)
  String productName;
  @HiveField(4)
  int quantity;
  @HiveField(5)
  double rate;
  @HiveField(6)
  double mrp;
  @HiveField(7)
  double total;
  @HiveField(8)
  int status;
  @HiveField(9)
  DateTime orderDate;

  HiveOrderDetailsModel({
    required this.id,
    required this.rate,
    required this.quantity,
    required this.mrp,
    required this.status,
    required this.orderDate,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.total,
  });
}
