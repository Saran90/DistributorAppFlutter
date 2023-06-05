part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object> get props => [];
}

class CartListPopulated extends CartState {

  List<Cart> carts;

  CartListPopulated({required this.carts});

  @override
  List<Object> get props => [carts];
}

class CartListFetchingFailed extends CartState {

  final String message;

  const CartListFetchingFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class CartAdded extends CartState {
  @override
  List<Object> get props => ['Cart Added'];
}

class CartAdditionFailed extends CartState {

  final String message;

  const CartAdditionFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class CartUpdated extends CartState {
  @override
  List<Object> get props => ['Cart Updated'];
}

class CartUpdationFailed extends CartState {

  final String message;

  const CartUpdationFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class CartDeleted extends CartState {
  @override
  List<Object> get props => ['Cart Deleted'];
}

class CartDeletionFailed extends CartState {

  final String message;

  const CartDeletionFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class CartItemDeleted extends CartState {
  @override
  List<Object> get props => ['Cart Item Deleted'];
}

class CartItemDeletionFailed extends CartState {

  final String message;

  const CartItemDeletionFailed({required this.message});

  @override
  List<Object> get props => [message];
}
