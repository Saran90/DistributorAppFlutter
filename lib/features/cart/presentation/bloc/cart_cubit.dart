import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/features/cart/domain/usecase/add_cart_use_case.dart';
import 'package:distributor_app_flutter/features/cart/domain/usecase/delete_cart_use_case.dart';
import 'package:distributor_app_flutter/features/cart/domain/usecase/update_cart_use_case.dart';
import 'package:distributor_app_flutter/features/cart/presentation/pages/models/cart.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/data/local_storage/models/hive_cart_model.dart';
import '../../../../../../utils/strings.dart';
import '../../domain/usecase/cart_list_use_case.dart';
import '../../domain/usecase/delete_cart_item_use_case.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required this.cartListUseCase,
    required this.addCartUseCase,
    required this.updateCartUseCase,
    required this.deleteCartUseCase,
    required this.deleteCartItemUseCase,
  }) : super(CartInitial());

  final CartListUseCase cartListUseCase;
  final AddCartUseCase addCartUseCase;
  final UpdateCartUseCase updateCartUseCase;
  final DeleteCartUseCase deleteCartUseCase;
  final DeleteCartItemUseCase deleteCartItemUseCase;

  Future<void> getCustomerCart(int customerId) async {
    emit(CartLoading());
    var result =
        await cartListUseCase.call(CartListParams(customerId: customerId));
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const CartListFetchingFailed(message: cacheFailureMessage));
      } else {
        emit(const CartListFetchingFailed(message: 'Carts fetching failed'));
      }
    },
        (r) => emit(CartListPopulated(
            carts: r!.map((e) => e.toCartModel()).toList() ?? [])));
  }

  Future<void> addCart(Cart cart) async {
    emit(CartLoading());
    var result = await addCartUseCase
        .call(AddCartParams(hiveCartModel: cart.toHiveModel()));
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const CartAdditionFailed(message: cacheFailureMessage));
      } else {
        emit(const CartAdditionFailed(message: 'Cart addition failed'));
      }
    }, (r) => emit(CartAdded()));
  }

  Future<void> updateCart(Cart cart) async {
    emit(CartLoading());
    var result = await updateCartUseCase
        .call(UpdateCartParams(hiveCartModel: cart.toHiveModel()));
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const CartUpdationFailed(message: cacheFailureMessage));
      } else {
        emit(const CartUpdationFailed(message: 'Cart updation failed'));
      }
    }, (r) => emit(CartUpdated()));
  }

  Future<void> deleteCart(int customerId) async {
    emit(CartLoading());
    var result =
        await deleteCartUseCase.call(DeleteCartParams(customerId: customerId));
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const CartDeletionFailed(message: cacheFailureMessage));
      } else {
        emit(const CartDeletionFailed(message: 'Cart deletion failed'));
      }
    }, (r) => emit(CartDeleted()));
  }

  Future<void> deleteCartItem(HiveCartModel hiveCartModel) async {
    emit(CartLoading());
    var result = await deleteCartItemUseCase
        .call(DeleteCartItemParams(hiveCartModel: hiveCartModel));
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const CartItemDeletionFailed(message: cacheFailureMessage));
      } else {
        emit(const CartItemDeletionFailed(message: 'Cart item deletion failed'));
      }
    }, (r) => emit(CartItemDeleted()));
  }
}
