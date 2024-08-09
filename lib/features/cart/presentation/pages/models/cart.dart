import 'package:distributor_app_flutter/core/data/local_storage/models/hive_cart_model.dart';

class Cart {
  int id;
  int userId;
  String orderId;
  String productId;
  String productName;
  int quantity;
  double rate;
  int customerId;
  double orderAmount;
  String unit;
  double mrp;
  double stock;
  DateTime dateTime;

  Cart(
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
      required this.dateTime,
      required this.productName});

  HiveCartModel toHiveModel() {
    return HiveCartModel(
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
        dateTime: dateTime,
        productName: productName);
  }
}
