class Order {
  int slNo;
  String customerName;
  double amount;
  int status;
  int orderId;
  int customerId;

  Order(
      {required this.orderId,
      required this.customerId,
      required this.status,
      required this.amount,
      required this.customerName,
      required this.slNo});
}
