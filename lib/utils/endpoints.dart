class EndPoint {
  String testingUrl = 'http://tradematecochindemo.atintellilabs.live/api/';
  String liveUrl = 'http://sales.cochindistributor.in/api/';

  String get baseUrl {
    return testingUrl;
  }

  String login = 'authenticate';
  String customerLogin = 'customerauthenticate';
  String products = 'GetProductByName';
  String customerProducts = 'GetProductByCustomer';
  String locations = 'GetAllCustomerLocation';
  String customers = 'GetCustomerByName';
  String sendSalesOrder = 'SalesOrderUpdateList';
  String sendSalesOrderUpdate = 'SalesOrderUpdate';
  String manufactureList = 'GetManufactureList';
  String salesForceFullyUpdate = 'SalesOrderForcefullySaving';
}
