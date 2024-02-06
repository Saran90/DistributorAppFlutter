part of 'order_history_cubit.dart';

abstract class OrderHistoryState extends Equatable {
  const OrderHistoryState();
}

class OrderHistoryInitial extends OrderHistoryState {
  @override
  List<Object> get props => [];
}

class OrderHistoryLoading extends OrderHistoryState {
  @override
  List<Object> get props => [];
}

class GetOrderHistorySuccess extends OrderHistoryState {

  List<OrderHistory> orders;

  GetOrderHistorySuccess({required this.orders});

  @override
  List<Object> get props => [orders];
}

class GetOrderHistoryFailed extends OrderHistoryState {

  String message;

  GetOrderHistoryFailed({required this.message});

  @override
  List<Object> get props => [message];
}
