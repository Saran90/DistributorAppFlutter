part of 'customer_list_cubit.dart';

abstract class CustomerListState extends Equatable {
  const CustomerListState();
}

class CustomerListInitial extends CustomerListState {
  @override
  List<Object> get props => [];
}

class CustomerListLoading extends CustomerListState {
  @override
  List<Object> get props => [];
}

class CustomerListPopulated extends CustomerListState {

  List<HiveCustomerModel> customers;

  CustomerListPopulated({required this.customers});

  @override
  List<Object> get props => [customers];
}

class CustomerListFetchingFailed extends CustomerListState {

  final String message;

  const CustomerListFetchingFailed({required this.message});

  @override
  List<Object> get props => [message];
}
