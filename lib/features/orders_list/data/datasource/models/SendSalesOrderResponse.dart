import 'dart:convert';
/// Status : 1
/// StatusMessage : "Sales Order updated successfully"

SendSalesOrderResponse sendSalesOrderResponseFromJson(String str) => SendSalesOrderResponse.fromJson(json.decode(str));
String sendSalesOrderResponseToJson(SendSalesOrderResponse data) => json.encode(data.toJson());
class SendSalesOrderResponse {
  SendSalesOrderResponse({
      int? status, 
      String? statusMessage,}){
    _status = status;
    _statusMessage = statusMessage;
}

  SendSalesOrderResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _statusMessage = json['StatusMessage'];
  }
  int? _status;
  String? _statusMessage;
SendSalesOrderResponse copyWith({  int? status,
  String? statusMessage,
}) => SendSalesOrderResponse(  status: status ?? _status,
  statusMessage: statusMessage ?? _statusMessage,
);
  int? get status => _status;
  String? get statusMessage => _statusMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['StatusMessage'] = _statusMessage;
    return map;
  }

}