part of 'customer_data_cubit.dart';

abstract class CustomerDataState extends Equatable {
  const CustomerDataState();
}

class CustomerDataInitial extends CustomerDataState {
  @override
  List<Object> get props => [];
}

class CustomerDataLoading extends CustomerDataState {
  @override
  List<Object> get props => [];
}

class CustomerDataPopulated extends CustomerDataState {

  List<HiveCustomerModel> customers;

  CustomerDataPopulated({required this.customers});

  @override
  List<Object> get props => [customers];
}

class CustomerDataFetchingFailed extends CustomerDataState {

  final String message;

  const CustomerDataFetchingFailed({required this.message});

  @override
  List<Object> get props => [message];
}
