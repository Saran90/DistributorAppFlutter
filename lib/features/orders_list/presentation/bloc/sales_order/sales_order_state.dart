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

class NoSalesOrderAvailableForSending extends SalesOrderState {

  final String message;

  const NoSalesOrderAvailableForSending({required this.message});

  @override
  List<Object> get props => [message];
}