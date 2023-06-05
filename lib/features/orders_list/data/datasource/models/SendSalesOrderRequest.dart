import 'dart:convert';
/// SalesorderList : [{"OrderSummary":{"order_date":"2023-05-12, 18:42:54","cust_id":6500,"order_amt":"589.79","salesman_id":1061},"OrderDetails":[{"product_id":22563,"qty":5,"rate":88.13,"mrp":130},{"product_id":22562,"qty":2,"rate":74.57,"mrp":110}]}]

SendSalesOrderRequest sendSalesOrderRequestFromJson(String str) => SendSalesOrderRequest.fromJson(json.decode(str));
String sendSalesOrderRequestToJson(SendSalesOrderRequest data) => json.encode(data.toJson());
class SendSalesOrderRequest {
  SendSalesOrderRequest({
      List<SalesorderList>? salesorderList,}){
    _salesorderList = salesorderList;
}

  SendSalesOrderRequest.fromJson(dynamic json) {
    if (json['SalesorderList'] != null) {
      _salesorderList = [];
      json['SalesorderList'].forEach((v) {
        _salesorderList?.add(SalesorderList.fromJson(v));
      });
    }
  }
  List<SalesorderList>? _salesorderList;
SendSalesOrderRequest copyWith({  List<SalesorderList>? salesorderList,
}) => SendSalesOrderRequest(  salesorderList: salesorderList ?? _salesorderList,
);
  List<SalesorderList>? get salesorderList => _salesorderList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_salesorderList != null) {
      map['SalesorderList'] = _salesorderList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// OrderSummary : {"order_date":"2023-05-12, 18:42:54","cust_id":6500,"order_amt":"589.79","salesman_id":1061}
/// OrderDetails : [{"product_id":22563,"qty":5,"rate":88.13,"mrp":130},{"product_id":22562,"qty":2,"rate":74.57,"mrp":110}]

SalesorderList salesorderListFromJson(String str) => SalesorderList.fromJson(json.decode(str));
String salesorderListToJson(SalesorderList data) => json.encode(data.toJson());
class SalesorderList {
  SalesorderList({
      OrderSummary? orderSummary, 
      List<OrderDetails>? orderDetails,}){
    _orderSummary = orderSummary;
    _orderDetails = orderDetails;
}

  SalesorderList.fromJson(dynamic json) {
    _orderSummary = json['OrderSummary'] != null ? OrderSummary.fromJson(json['OrderSummary']) : null;
    if (json['OrderDetails'] != null) {
      _orderDetails = [];
      json['OrderDetails'].forEach((v) {
        _orderDetails?.add(OrderDetails.fromJson(v));
      });
    }
  }
  OrderSummary? _orderSummary;
  List<OrderDetails>? _orderDetails;
SalesorderList copyWith({  OrderSummary? orderSummary,
  List<OrderDetails>? orderDetails,
}) => SalesorderList(  orderSummary: orderSummary ?? _orderSummary,
  orderDetails: orderDetails ?? _orderDetails,
);
  OrderSummary? get orderSummary => _orderSummary;
  List<OrderDetails>? get orderDetails => _orderDetails;

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

/// product_id : 22563
/// qty : 5
/// rate : 88.13
/// mrp : 130

OrderDetails orderDetailsFromJson(String str) => OrderDetails.fromJson(json.decode(str));
String orderDetailsToJson(OrderDetails data) => json.encode(data.toJson());
class OrderDetails {
  OrderDetails({
      num? productId, 
      num? qty, 
      num? rate, 
      num? mrp,}){
    _productId = productId;
    _qty = qty;
    _rate = rate;
    _mrp = mrp;
}

  OrderDetails.fromJson(dynamic json) {
    _productId = json['product_id'];
    _qty = json['qty'];
    _rate = json['rate'];
    _mrp = json['mrp'];
  }
  num? _productId;
  num? _qty;
  num? _rate;
  num? _mrp;
OrderDetails copyWith({  num? productId,
  num? qty,
  num? rate,
  num? mrp,
}) => OrderDetails(  productId: productId ?? _productId,
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

/// order_date : "2023-05-12, 18:42:54"
/// cust_id : 6500
/// order_amt : "589.79"
/// salesman_id : 1061

OrderSummary orderSummaryFromJson(String str) => OrderSummary.fromJson(json.decode(str));
String orderSummaryToJson(OrderSummary data) => json.encode(data.toJson());
class OrderSummary {
  OrderSummary({
      String? orderDate, 
      num? custId, 
      String? orderAmt, 
      num? salesmanId,}){
    _orderDate = orderDate;
    _custId = custId;
    _orderAmt = orderAmt;
    _salesmanId = salesmanId;
}

  OrderSummary.fromJson(dynamic json) {
    _orderDate = json['order_date'];
    _custId = json['cust_id'];
    _orderAmt = json['order_amt'];
    _salesmanId = json['salesman_id'];
  }
  String? _orderDate;
  num? _custId;
  String? _orderAmt;
  num? _salesmanId;
OrderSummary copyWith({  String? orderDate,
  num? custId,
  String? orderAmt,
  num? salesmanId,
}) => OrderSummary(  orderDate: orderDate ?? _orderDate,
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