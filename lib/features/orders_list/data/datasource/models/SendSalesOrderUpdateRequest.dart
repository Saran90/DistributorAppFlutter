import 'dart:convert';
/// OrderSummary : {"order_date":"2023-05-11, 00:18:37","cust_id":6640,"order_amt":"142.31","salesman_id":1061}
/// OrderDetails : [{"product_id":22561,"qty":7,"rate":20.33,"mrp":30}]

SendSalesOrderUpdateRequest sendSalesOrderUpdateRequestFromJson(String str) => SendSalesOrderUpdateRequest.fromJson(json.decode(str));
String sendSalesOrderUpdateRequestToJson(SendSalesOrderUpdateRequest data) => json.encode(data.toJson());
class SendSalesOrderUpdateRequest {
  SendSalesOrderUpdateRequest({
      OrderSummaryModel? orderSummary,
      List<OrderDetailsModel>? orderDetails,}){
    _orderSummary = orderSummary;
    _orderDetails = orderDetails;
}

  SendSalesOrderUpdateRequest.fromJson(dynamic json) {
    _orderSummary = json['OrderSummary'] != null ? OrderSummaryModel.fromJson(json['OrderSummary']) : null;
    if (json['OrderDetails'] != null) {
      _orderDetails = [];
      json['OrderDetails'].forEach((v) {
        _orderDetails?.add(OrderDetailsModel.fromJson(v));
      });
    }
  }
  OrderSummaryModel? _orderSummary;
  List<OrderDetailsModel>? _orderDetails;
SendSalesOrderUpdateRequest copyWith({  OrderSummaryModel? orderSummary,
  List<OrderDetailsModel>? orderDetails,
}) => SendSalesOrderUpdateRequest(  orderSummary: orderSummary ?? _orderSummary,
  orderDetails: orderDetails ?? _orderDetails,
);
  OrderSummaryModel? get orderSummary => _orderSummary;
  List<OrderDetailsModel>? get orderDetails => _orderDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_orderSummary != null) {
      map['OrderSummary'] = _orderSummary?.toJson();
    }
    if (_orderDetails != null) {
      map['OrderDetails'] = _orderDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// product_id : 22561
/// qty : 7
/// rate : 20.33
/// mrp : 30

OrderDetailsModel orderDetailsFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));
String orderDetailsToJson(OrderDetailsModel data) => json.encode(data.toJson());
class OrderDetailsModel {
  OrderDetailsModel({
      num? productId, 
      num? qty, 
      num? rate, 
      num? mrp,}){
    _productId = productId;
    _qty = qty;
    _rate = rate;
    _mrp = mrp;
}

  OrderDetailsModel.fromJson(dynamic json) {
    _productId = json['product_id'];
    _qty = json['qty'];
    _rate = json['rate'];
    _mrp = json['mrp'];
  }
  num? _productId;
  num? _qty;
  num? _rate;
  num? _mrp;
OrderDetailsModel copyWith({  num? productId,
  num? qty,
  num? rate,
  num? mrp,
}) => OrderDetailsModel(  productId: productId ?? _productId,
  qty: qty ?? _qty,
  rate: rate ?? _rate,
  mrp: mrp ?? _mrp,
);
  num? get productId => _productId;
  num? get qty => _qty;
  num? get rate => _rate;
  num? get mrp => _mrp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['qty'] = _qty;
    map['rate'] = _rate;
    map['mrp'] = _mrp;
    return map;
  }

}

/// order_date : "2023-05-11, 00:18:37"
/// cust_id : 6640
/// order_amt : "142.31"
/// salesman_id : 1061

OrderSummaryModel orderSummaryFromJson(String str) => OrderSummaryModel.fromJson(json.decode(str));
String orderSummaryToJson(OrderSummaryModel data) => json.encode(data.toJson());
class OrderSummaryModel {
  OrderSummaryModel({
      String? orderDate, 
      num? custId, 
      String? orderAmt, 
      num? salesmanId,}){
    _orderDate = orderDate;
    _custId = custId;
    _orderAmt = orderAmt;
    _salesmanId = salesmanId;
}

  OrderSummaryModel.fromJson(dynamic json) {
    _orderDate = json['order_date'];
    _custId = json['cust_id'];
    _orderAmt = json['order_amt'];
    _salesmanId = json['salesman_id'];
  }
  String? _orderDate;
  num? _custId;
  String? _orderAmt;
  num? _salesmanId;
OrderSummaryModel copyWith({  String? orderDate,
  num? custId,
  String? orderAmt,
  num? salesmanId,
}) => OrderSummaryModel(  orderDate: orderDate ?? _orderDate,
  custId: custId ?? _custId,
  orderAmt: orderAmt ?? _orderAmt,
  salesmanId: salesmanId ?? _salesmanId,
);
  String? get orderDate => _orderDate;
  num? get custId => _custId;
  String? get orderAmt => _orderAmt;
  num? get salesmanId => _salesmanId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_date'] = _orderDate;
    map['cust_id'] = _custId;
    map['order_amt'] = _orderAmt;
    map['salesman_id'] = _salesmanId;
    return map;
  }

}