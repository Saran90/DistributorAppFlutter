import 'package:hive/hive.dart';

part 'hive_order_summary_model.g.dart';

@HiveType(typeId: 6)
class HiveOrderSummaryModel extends HiveObject {
  @HiveField(0)
  int orderId;
  @HiveField(1)
  int customerId;
  @HiveField(2)
  int userId;
  @HiveField(3)
  int status;
  @HiveField(4)
  double orderAmount;
  @HiveField(5)
  DateTime orderDate;
  @HiveField(6)
  String customerName;

  HiveOrderSummaryModel(
      {required this.orderId,
      required this.orderDate,
      required this.status,
      required this.customerId,
      required this.orderAmount,
      required this.userId,
      required this.customerName});
}
