class OrderHistory {
  DateTime? orderDate;
  String? customerName;
  String? orderAmount;
  String? status;
  List<OrderHistoryItem>? items;

  OrderHistory(
      {this.status,
      this.customerName,
      this.orderAmount,
      this.orderDate,
      this.items});
}

class OrderHistoryItem {
  String? productName;
  double? mrp;
  double? quantity;
  double? rate;
  double? amount;

  OrderHistoryItem(
      {this.mrp, this.rate, this.amount, this.productName, this.quantity});
}
