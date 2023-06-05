import 'package:distributor_app_flutter/core/data/local_storage/models/hive_product_model.dart';

class Product {
  int? id;
  String? name;
  String? category;
  String? unit;
  double? mrp;
  double? rate;
  double? stock;
  String? image;
  double? quantity;
  double? total;
  int? status;

  Product(
      {this.name,
      this.id,
      this.total,
      this.category,
      this.image,
      this.mrp,
      this.quantity,
      this.rate,
      this.stock,
      this.unit,
      this.status});

  HiveProductModel toHiveModel() {
    return HiveProductModel(
        total: total,
        quantity: quantity,
        status: status,
        name: name,
        id: id,
        image: image,
        category: category,
        mrp: mrp,
        rate: rate,
        stock: stock,
        unit: unit);
  }
}
