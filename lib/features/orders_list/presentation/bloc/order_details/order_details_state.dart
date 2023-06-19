part of 'order_details_cubit.dart';

abstract class OrderDetailsState extends Equatable {
  const OrderDetailsState();
}

class OrderDetailsInitial extends OrderDetailsState {
  @override
  List<Object> get props => [];
}

class OrderDetailsLoading extends OrderDetailsState {
  @override
  List<Object> get props => [];
}

class OrderDetailsPopulated extends OrderDetailsState {
  List<HiveOrderDetailsModel> orderDtails;

  OrderDetailsPopulated({required this.orderDtails});

  @override
  List<Object> get props => [orderDtails];
}

class OrderDetailsFetchingFailed extends OrderDetailsState {
  final String message;

  const OrderDetailsFetchingFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderDetailsDeleted extends OrderDetailsState {
  @override
  List<Object> get props => ['Order Details Deleted'];
}

class OrderDetailsDeletionFailed extends OrderDetailsState {
  final String message;

  const OrderDetailsDeletionFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderDetailsAdded extends OrderDetailsState {
  @override
  List<Object> get props => ['Order Details Added'];
}

class OrderDetailsAdditionFailed extends OrderDetailsState {
  final String message;

  const OrderDetailsAdditionFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class AllOrderDetailsDeleted extends OrderDetailsState {
  @override
  List<Object> get props => ['All Order Details Deleted'];
}

class AllOrderDetailsDeletionFailed extends OrderDetailsState {
  final String message;

  const AllOrderDetailsDeletionFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderDetailsStatusUpdated extends OrderDetailsState {
  @override
  List<Object> get props => ['Order Details Status Updated'];
}

class OrderDetailsStatusUpdationFailed extends OrderDetailsState {
  final String message;

  const OrderDetailsStatusUpdationFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderDetailsUpdated extends OrderDetailsState {
  @override
  List<Object> get props => ['Order Details Updated'];
}

class OrderDetailsUpdationFailed extends OrderDetailsState {
  final String message;

  const OrderDetailsUpdationFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderDetailItemDeleted extends OrderDetailsState {
  @override
  List<Object> get props => ['Order Detail item Deleted'];
}

class OrderDetailItemDeletionFailed extends OrderDetailsState {
  final String message;

  const OrderDetailItemDeletionFailed({required this.message});

  @override
  List<Object> get props => [message];
}
