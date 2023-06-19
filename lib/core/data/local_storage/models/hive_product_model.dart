import 'package:distributor_app_flutter/features/product_list/presentation/pages/models/product.dart';
import 'package:hive/hive.dart';

part 'hive_product_model.g.dart';

@HiveType(typeId: 2)
class HiveProductModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? category;
  @HiveField(3)
  String? unit;
  @HiveField(4)
  double? mrp;
  @HiveField(5)
  double? rate;
  @HiveField(6)
  double? stock;
  @HiveField(7)
  String? image;
  @HiveField(8)
  int? quantity;
  @HiveField(9)
  double? total;
  @HiveField(10)
  int? status;

  HiveProductModel(
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

  Product toProduct() {
    return Product(
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
