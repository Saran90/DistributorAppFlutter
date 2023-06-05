import 'dart:convert';
/// Status : 1
/// StatusMessage : "Sales Order updated successfully"

SendSalesOrderResponse sendSalesOrderResponseFromJson(String str) => SendSalesOrderResponse.fromJson(json.decode(str));
String sendSalesOrderResponseToJson(SendSalesOrderResponse data) => json.encode(data.toJson());
class SendSalesOrderResponse {
  SendSalesOrderResponse({
      num? status, 
      String? statusMessage,}){
    _status = status;
    _statusMessage = statusMessage;
}

  SendSalesOrderResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _statusMessage = json['StatusMessage'];
  }
  num? _status;
  String? _statusMessage;
SendSalesOrderResponse copyWith({  num? status,
  String? statusMessage,
}) => SendSalesOrderResponse(  status: status ?? _status,
  statusMessage: statusMessage ?? _statusMessage,
);
  num? get status => _status;
  String? get statusMessage => _statusMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['StatusMessage'] = _statusMessage;
    return map;
  }

}