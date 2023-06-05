import 'dart:convert';

/// Products : [{"ID":23571,"Name":"2 TON INVERTER AC 5 STAR","Category":"AUTO","Unit":"NOS  ","MRP":0.00,"Rate":0.00,"Stock":0.00,"Status":1,"ImageName":""}]

ProductsDataResponse productsDataResponseFromJson(String str) =>
    ProductsDataResponse.fromJson(json.decode(str));

String productsDataResponseToJson(ProductsDataResponse data) =>
    json.encode(data.toJson());

class ProductsDataResponse {
  ProductsDataResponse({
    List<Products>? products,
  }) {
    _products = products;
  }

  ProductsDataResponse.fromJson(dynamic json) {
    if (json['Products'] != null) {
      _products = [];
      json['Products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
  }

  List<Products>? _products;

  ProductsDataResponse copyWith({
    List<Products>? products,
  }) =>
      ProductsDataResponse(
        products: products ?? _products,
      );

  List<Products>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_products != null) {
      map['Products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// ID : 23571
/// Name : "2 TON INVERTER AC 5 STAR"
/// Category : "AUTO"
/// Unit : "NOS  "
/// MRP : 0.00
/// Rate : 0.00
/// Stock : 0.00
/// Status : 1
/// ImageName : ""

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  Products({
    int? id,
    String? name,
    String? category,
    String? unit,
    double? mrp,
    double? rate,
    double? stock,
    int? status,
    String? imageName,
  }) {
    _id = id;
    _name = name;
    _category = category;
    _unit = unit;
    _mrp = mrp;
    _rate = rate;
    _stock = stock;
    _status = status;
    _imageName = imageName;
  }

  Products.fromJson(dynamic json) {
    _id = json['ID'];
    _name = json['Name'];
    _category = json['Category'];
    _unit = json['Unit'];
    _mrp = json['MRP'];
    _rate = json['Rate'];
    _stock = json['Stock'];
    _status = json['Status'];
    _imageName = json['ImageName'];
  }

  int? _id;
  String? _name;
  String? _category;
  String? _unit;
  double? _mrp;
  double? _rate;
  double? _stock;
  int? _status;
  String? _imageName;

  Products copyWith({
    int? id,
    String? name,
    String? category,
    String? unit,
    double? mrp,
    double? rate,
    double? stock,
    int? status,
    String? imageName,
  }) =>
      Products(
        id: id ?? _id,
        name: name ?? _name,
        category: category ?? _category,
        unit: unit ?? _unit,
        mrp: mrp ?? _mrp,
        rate: rate ?? _rate,
        stock: stock ?? _stock,
        status: status ?? _status,
        imageName: imageName ?? _imageName,
      );

  int? get id => _id;

  String? get name => _name;

  String? get category => _category;

  String? get unit => _unit;

  double? get mrp => _mrp;

  double? get rate => _rate;

  double? get stock => _stock;

  int? get status => _status;

  String? get imageName => _imageName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['Name'] = _name;
    map['Category'] = _category;
    map['Unit'] = _unit;
    map['MRP'] = _mrp;
    map['Rate'] = _rate;
    map['Stock'] = _stock;
    map['Status'] = _status;
    map['ImageName'] = _imageName;
    return map;
  }
}
