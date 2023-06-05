part of 'order_summary_cubit.dart';

abstract class OrderSummaryState extends Equatable {
  const OrderSummaryState();
}

class OrderSummaryInitial extends OrderSummaryState {
  @override
  List<Object> get props => [];
}

class OrderSummaryLoading extends OrderSummaryState {
  @override
  List<Object> get props => [];
}

class OrderSummaryPopulated extends OrderSummaryState {

  List<Order> orderSummaries;

  OrderSummaryPopulated({required this.orderSummaries});

  @override
  List<Object> get props => [orderSummaries];
}

class OrderSummaryByIdPopulated extends OrderSummaryState {

  HiveOrderSummaryModel orderSummaryModel;

  OrderSummaryByIdPopulated({required this.orderSummaryModel});

  @override
  List<Object> get props => [orderSummaryModel];
}

class OrderSummaryFetchingFailed extends OrderSummaryState {

  final String message;

  const OrderSummaryFetchingFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderSummaryDeleted extends OrderSummaryState {
  @override
  List<Object> get props => ['Order Summary Deleted'];
}

class OrderSummaryDeletionFailed extends OrderSummaryState {

  final String message;

  const OrderSummaryDeletionFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderSummaryAdded extends OrderSummaryState {

  const OrderSummaryAdded({required this.hiveOrderSummaryModel});

  final HiveOrderSummaryModel hiveOrderSummaryModel;

  @override
  List<Object> get props => ['Order Summary Added'];
}

class OrderSummaryAdditionFailed extends OrderSummaryState {

  final String message;

  const OrderSummaryAdditionFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderSummaryStatusUpdated extends OrderSummaryState {
  @override
  List<Object> get props => ['Order Summary Status Updated'];
}

class OrderSummaryStatusUpdationFailed extends OrderSummaryState {

  final String message;

  const OrderSummaryStatusUpdationFailed({required this.message});

  @override
  List<Object> get props => [message];
}
