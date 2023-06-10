part of 'sales_order_cubit.dart';

abstract class SalesOrderState extends Equatable {
  const SalesOrderState();
}

class SalesOrderInitial extends SalesOrderState {
  @override
  List<Object> get props => [];
}

class SalesOrderLoading extends SalesOrderState {
  @override
  List<Object> get props => [];
}

class SalesOrdersLoading extends SalesOrderState {
  @override
  List<Object> get props => [];
}

class SalesOrdersUploadProgress extends SalesOrderState {
  SalesOrdersUploadProgress({required this.progress});

  final double progress;

  @override
  List<Object> get props => [progress];
}

class SalesOrderSendSuccessfully extends SalesOrderState {
  String message;

  SalesOrderSendSuccessfully({required this.message});

  @override
  List<Object> get props => [message];
}

class SalesOrderSendingFailed extends SalesOrderState {
  final String message;

  const SalesOrderSendingFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class SalesOrdersSendSuccessfully extends SalesOrderState {
  String message;
  List<int> uploadedOrders;
  List<int> failedOrders;

  SalesOrdersSendSuccessfully(
      {required this.message,
      required this.uploadedOrders,
      required this.failedOrders});

  @override
  List<Object> get props => [message, uploadedOrders, failedOrders];
}

class SalesOrdersSendingFailed extends SalesOrderState {
  final String message;

  const SalesOrdersSendingFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class NoSalesOrderAvailableForSending extends SalesOrderState {
  final String message;

  const NoSalesOrderAvailableForSending({required this.message});

  @override
  List<Object> get props => [message];
}
