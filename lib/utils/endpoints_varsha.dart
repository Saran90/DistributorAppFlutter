import 'endpoints.dart';

class EndPointVarsha extends EndPoint {
  @override
  String get testingUrl {
    return 'http://varsha.atintellilabs.live/api/';
  }

  @override
  String get liveUrl {
    return 'http://sales.cochindistributor.in/api/';
  }

  @override
  String get baseUrl {
    return testingUrl;
  }

  @override
  String get login {
    return 'authenticate';
  }

  @override
  String get products {
    return 'GetProductByName';
  }

  @override
  String get locations {
    return 'GetAllCustomerLocation';
  }

  @override
  String get customers {
    return 'GetCustomerByName';
  }

  @override
  String get sendSalesOrder {
    return 'SalesOrderUpdateList';
  }

  @override
  String get sendSalesOrderUpdate {
    return 'SalesOrderUpdate';
  }

  @override
  String get manufactureList {
    return 'GetManufactureList';
  }
}
