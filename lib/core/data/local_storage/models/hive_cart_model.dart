import 'package:hive/hive.dart';

import '../../../../features/cart/presentation/pages/models/cart.dart';

part 'hive_cart_model.g.dart';

@HiveType(typeId: 7)
class HiveCartModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  int userId;
  @HiveField(2)
  String orderId;
  @HiveField(3)
  String productId;
  @HiveField(4)
  String productName;
  @HiveField(5)
  int quantity;
  @HiveField(6)
  double rate;
  @HiveField(7)
  int customerId;
  @HiveField(8)
  double orderAmount;
  @HiveField(9)
  String unit;
  @HiveField(10)
  double mrp;
  @HiveField(11)
  double stock;

  HiveCartModel(
      {required this.orderAmount,
      required this.customerId,
      required this.orderId,
      required this.mrp,
      required this.quantity,
      required this.rate,
      required this.id,
      required this.unit,
      required this.stock,
      required this.userId,
      required this.productId,
      required this.productName});

  Cart toCartModel() {
    return Cart(
        orderAmount: orderAmount,
        customerId: customerId,
        orderId: orderId,
        mrp: mrp,
        quantity: quantity,
        rate: rate,
        id: id,
        unit: unit,
        stock: stock,
        userId: userId,
        productId: productId,
        productName: productName);
  }
}
