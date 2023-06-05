part of 'product_data_cubit.dart';

abstract class ProductDataState extends Equatable {
  const ProductDataState();
}

class ProductDataInitial extends ProductDataState {
  @override
  List<Object> get props => [];
}

class ProductDataLoading extends ProductDataState {
  @override
  List<Object> get props => [];
}

class ProductDataPopulated extends ProductDataState {

  List<HiveProductModel> products;

  ProductDataPopulated({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductDataFetchingFailed extends ProductDataState {

  final String message;

  const ProductDataFetchingFailed({required this.message});

  @override
  List<Object> get props => [message];
}
