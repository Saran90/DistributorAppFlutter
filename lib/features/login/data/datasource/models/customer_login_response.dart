import 'dart:convert';

/// access_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI0NzQ0NjEwZC04NmE0LTQzOTUtOWU1MS00Mzk1ZWQzZDYwM2EiLCJ2YWxpZCI6IjEiLCJ1c2VyaWQiOiI1LzEwLzIwMjMgNzoxNzo1NSBQTSIsIm5hbWUiOiJhcnVuIiwiZXhwIjoxNjgzODEyODc1LCJpc3MiOiJodHRwOi8vbXlzaXRlLmNvbSIsImF1ZCI6Imh0dHA6Ly9teXNpdGUuY29tIn0.t8vQRebZSI4TAygwfVQ0d6EXXkjfj6K9p3cjUVi6muk"
/// customer_id : 1061
/// error : ""
/// error_description : ""

CustomerLoginResponse loginResponseFromJson(String str) =>
    CustomerLoginResponse.fromJson(json.decode(str));

String loginResponseToJson(CustomerLoginResponse data) => json.encode(data.toJson());

class CustomerLoginResponse {
  CustomerLoginResponse({
    String? accessToken,
    int? customerId,
    String? error,
    String? errorDescription,
  }) {
    _accessToken = accessToken;
    _customerId = customerId;
    _error = error;
    _errorDescription = errorDescription;
  }

  CustomerLoginResponse.fromJson(dynamic json) {
    _accessToken = json['access_token'];
    _customerId = json['customer_id'];
    _error = json['error'];
    _errorDescription = json['error_description'];
  }

  String? _accessToken;
  int? _customerId;
  String? _error;
  String? _errorDescription;

  CustomerLoginResponse copyWith({
    String? accessToken,
    int? customerId,
    String? error,
    String? errorDescription,
  }) =>
      CustomerLoginResponse(
        accessToken: accessToken ?? _accessToken,
        customerId: customerId ?? _customerId,
        error: error ?? _error,
        errorDescription: errorDescription ?? _errorDescription,
      );

  String? get accessToken => _accessToken;

  int? get customerId => _customerId;

  String? get error => _error;

  String? get errorDescription => _errorDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    map['customer_id'] = _customerId;
    map['error'] = _error;
    map['error_description'] = _errorDescription;
    return map;
  }
}
