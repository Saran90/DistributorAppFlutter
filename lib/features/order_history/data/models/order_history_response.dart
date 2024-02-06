import 'dart:convert';
/// SavedSalesOrder : [{"order_date":"2024-01-16T04:30:24","CustName":"0471 The Complete Mens Terminal","order_amt":"715.05","status":"Pending","OrderDetails":[{"ProdName":"Us Wax Strong Hold Wet Look 50gm (Mrp-225)","mrp":225.00,"qty":5.00,"rate":143.01,"amount":715.0500},{"ProdName":"Ust Soap Activated Charcoal Pack of 4 Free","mrp":0.00,"qty":6.00,"rate":0.00,"amount":0.0000}]}]

OrderHistoryResponse orderHistoryResponseFromJson(String str) => OrderHistoryResponse.fromJson(json.decode(str));
String orderHistoryResponseToJson(OrderHistoryResponse data) => json.encode(data.toJson());
class OrderHistoryResponse {
  OrderHistoryResponse({
      List<SavedSalesOrder>? savedSalesOrder,}){
    _savedSalesOrder = savedSalesOrder;
}

  OrderHistoryResponse.fromJson(dynamic json) {
    if (json['SavedSalesOrder'] != null) {
      _savedSalesOrder = [];
      json['SavedSalesOrder'].forEach((v) {
        _savedSalesOrder?.add(SavedSalesOrder.fromJson(v));
      });
    }
  }
  List<SavedSalesOrder>? _savedSalesOrder;
OrderHistoryResponse copyWith({  List<SavedSalesOrder>? savedSalesOrder,
}) => OrderHistoryResponse(  savedSalesOrder: savedSalesOrder ?? _savedSalesOrder,
);
  List<SavedSalesOrder>? get savedSalesOrder => _savedSalesOrder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_savedSalesOrder != null) {
      map['SavedSalesOrder'] = _savedSalesOrder?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// order_date : "2024-01-16T04:30:24"
/// CustName : "0471 The Complete Mens Terminal"
/// order_amt : "715.05"
/// status : "Pending"
/// OrderDetails : [{"ProdName":"Us Wax Strong Hold Wet Look 50gm (Mrp-225)","mrp":225.00,"qty":5.00,"rate":143.01,"amount":715.0500},{"ProdName":"Ust Soap Activated Charcoal Pack of 4 Free","mrp":0.00,"qty":6.00,"rate":0.00,"amount":0.0000}]

SavedSalesOrder savedSalesOrderFromJson(String str) => SavedSalesOrder.fromJson(json.decode(str));
String savedSalesOrderToJson(SavedSalesOrder data) => json.encode(data.toJson());
class SavedSalesOrder {
  SavedSalesOrder({
      String? orderDate, 
      String? custName, 
      String? orderAmt, 
      String? status, 
      List<OrderDetails>? orderDetails,}){
    _orderDate = orderDate;
    _custName = custName;
    _orderAmt = orderAmt;
    _status = status;
    _orderDetails = orderDetails;
}

  SavedSalesOrder.fromJson(dynamic json) {
    _orderDate = json['order_date'];
    _custName = json['CustName'];
    _orderAmt = json['order_amt'];
    _status = json['status'];
    if (json['OrderDetails'] != null) {
      _orderDetails = [];
      json['OrderDetails'].forEach((v) {
        _orderDetails?.add(OrderDetails.fromJson(v));
      });
    }
  }
  String? _orderDate;
  String? _custName;
  String? _orderAmt;
  String? _status;
  List<OrderDetails>? _orderDetails;
SavedSalesOrder copyWith({  String? orderDate,
  String? custName,
  String? orderAmt,
  String? status,
  List<OrderDetails>? orderDetails,
}) => SavedSalesOrder(  orderDate: orderDate ?? _orderDate,
  custName: custName ?? _custName,
  orderAmt: orderAmt ?? _orderAmt,
  status: status ?? _status,
  orderDetails: orderDetails ?? _orderDetails,
);
  String? get orderDate => _orderDate;
  String? get custName => _custName;
  String? get orderAmt => _orderAmt;
  String? get status => _status;
  List<OrderDetails>? get orderDetails => _orderDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_date'] = _orderDate;
    map['CustName'] = _custName;
    map['order_amt'] = _orderAmt;
    map['status'] = _status;
    if (_orderDetails != null) {
      map['OrderDetails'] = _orderDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ProdName : "Us Wax Strong Hold Wet Look 50gm (Mrp-225)"
/// mrp : 225.00
/// qty : 5.00
/// rate : 143.01
/// amount : 715.0500

OrderDetails orderDetailsFromJson(String str) => OrderDetails.fromJson(json.decode(str));
String orderDetailsToJson(OrderDetails data) => json.encode(data.toJson());
class OrderDetails {
  OrderDetails({
      String? prodName, 
      num? mrp, 
      num? qty, 
      num? rate, 
      num? amount,}){
    _prodName = prodName;
    _mrp = mrp;
    _qty = qty;
    _rate = rate;
    _amount = amount;
}

  OrderDetails.fromJson(dynamic json) {
    _prodName = json['ProdName'];
    _mrp = json['mrp'];
    _qty = json['qty'];
    _rate = json['rate'];
    _amount = json['amount'];
  }
  String? _prodName;
  num? _mrp;
  num? _qty;
  num? _rate;
  num? _amount;
OrderDetails copyWith({  String? prodName,
  num? mrp,
  num? qty,
  num? rate,
  num? amount,
}) => OrderDetails(  prodName: prodName ?? _prodName,
  mrp: mrp ?? _mrp,
  qty: qty ?? _qty,
  rate: rate ?? _rate,
  amount: amount ?? _amount,
);
  String? get prodName => _prodName;
  num? get mrp => _mrp;
  num? get qty => _qty;
  num? get rate => _rate;
  num? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ProdName'] = _prodName;
    map['mrp'] = _mrp;
    map['qty'] = _qty;
    map['rate'] = _rate;
    map['amount'] = _amount;
    return map;
  }

}