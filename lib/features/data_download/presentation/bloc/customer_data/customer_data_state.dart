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

class SaveCustomerSelectionSuccess extends CustomerDataState {
  @override
  List<Object> get props => [];
}

class SaveCustomerSelectionFailed extends CustomerDataState {

  final String message;

  const SaveCustomerSelectionFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteCustomerSelectionSuccess extends CustomerDataState {
  @override
  List<Object> get props => [];
}

class DeleteCustomerSelectionFailed extends CustomerDataState {

  final String message;

  const DeleteCustomerSelectionFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class GetCustomerSelectionSuccess extends CustomerDataState {

  HiveCustomerModel? hiveCustomerModel;

  GetCustomerSelectionSuccess({required this.hiveCustomerModel});

  @override
  List<Object> get props => [];
}

class GetCustomerSelectionFailed extends CustomerDataState {

  final String message;

  const GetCustomerSelectionFailed({required this.message});

  @override
  List<Object> get props => [message];
}
