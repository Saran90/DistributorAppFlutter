import 'dart:convert';

/// Customers : [{"ID":6499,"Name":"20 20 SUPER MKT AYIROOR","Address":"7356802020","PinCode":"","Location":"CHANGAMANADU","ContactPerson":"","ContactNo":"7356802020","Status":1}]

CustomerDataResponse customerDataResponseFromJson(String str) =>
    CustomerDataResponse.fromJson(json.decode(str));

String customerDataResponseToJson(CustomerDataResponse data) =>
    json.encode(data.toJson());

class CustomerDataResponse {
  CustomerDataResponse({
    List<Customers>? customers,
  }) {
    _customers = customers;
  }

  CustomerDataResponse.fromJson(dynamic json) {
    if (json['Customers'] != null) {
      _customers = [];
      json['Customers'].forEach((v) {
        _customers?.add(Customers.fromJson(v));
      });
    }
  }

  List<Customers>? _customers;

  CustomerDataResponse copyWith({
    List<Customers>? customers,
  }) =>
      CustomerDataResponse(
        customers: customers ?? _customers,
      );

  List<Customers>? get customers => _customers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_customers != null) {
      map['Customers'] = _customers?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// ID : 6499
/// Name : "20 20 SUPER MKT AYIROOR"
/// Address : "7356802020"
/// PinCode : ""
/// Location : "CHANGAMANADU"
/// ContactPerson : ""
/// ContactNo : "7356802020"
/// Status : 1

Customers customersFromJson(String str) => Customers.fromJson(json.decode(str));

String customersToJson(Customers data) => json.encode(data.toJson());

class Customers {
  Customers({
    int? id,
    String? name,
    String? address,
    String? pinCode,
    String? location,
    String? contactPerson,
    String? contactNo,
    int? status,
  }) {
    _id = id;
    _name = name;
    _address = address;
    _pinCode = pinCode;
    _location = location;
    _contactPerson = contactPerson;
    _contactNo = contactNo;
    _status = status;
  }

  Customers.fromJson(dynamic json) {
    _id = json['ID'];
    _name = json['Name'];
    _address = json['Address'];
    _pinCode = json['PinCode'];
    _location = json['Location'];
    _contactPerson = json['ContactPerson'];
    _contactNo = json['ContactNo'];
    _status = json['Status'];
  }

  int? _id;
  String? _name;
  String? _address;
  String? _pinCode;
  String? _location;
  String? _contactPerson;
  String? _contactNo;
  int? _status;

  Customers copyWith({
    int? id,
    String? name,
    String? address,
    String? pinCode,
    String? location,
    String? contactPerson,
    String? contactNo,
    int? status,
  }) =>
      Customers(
        id: id ?? _id,
        name: name ?? _name,
        address: address ?? _address,
        pinCode: pinCode ?? _pinCode,
        location: location ?? _location,
        contactPerson: contactPerson ?? _contactPerson,
        contactNo: contactNo ?? _contactNo,
        status: status ?? _status,
      );

  int? get id => _id;

  String? get name => _name;

  String? get address => _address;

  String? get pinCode => _pinCode;

  String? get location => _location;

  String? get contactPerson => _contactPerson;

  String? get contactNo => _contactNo;

  int? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['Name'] = _name;
    map['Address'] = _address;
    map['PinCode'] = _pinCode;
    map['Location'] = _location;
    map['ContactPerson'] = _contactPerson;
    map['ContactNo'] = _contactNo;
    map['Status'] = _status;
    return map;
  }
}
