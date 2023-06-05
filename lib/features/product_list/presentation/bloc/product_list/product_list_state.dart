part of 'product_list_cubit.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();
}

class ProductListInitial extends ProductListState {
  @override
  List<Object> get props => [];
}

class ProductListLoading extends ProductListState {
  @override
  List<Object> get props => [];
}

class ProductListPopulated extends ProductListState {

  List<Product> products;

  ProductListPopulated({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductListFetchingFailed extends ProductListState {

  final String message;

  const ProductListFetchingFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class SelectedProductListPopulated extends ProductListState {

  List<Product> products;

  SelectedProductListPopulated({required this.products});

  @override
  List<Object> get props => [products];
}
