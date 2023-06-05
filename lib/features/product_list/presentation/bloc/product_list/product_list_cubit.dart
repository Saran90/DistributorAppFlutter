import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/features/product_list/presentation/pages/models/product.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/data/local_storage/models/hive_product_model.dart';
import '../../../../../../utils/strings.dart';
import '../../../../cart/presentation/pages/models/cart.dart';
import '../../../domain/usecase/product_list_use_case.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit({required this.productListUseCase})
      : super(ProductListInitial());

  final ProductListUseCase productListUseCase;

  Future<void> getProducts(String search) async {
    emit(ProductListLoading());
    var result =
        await productListUseCase.call(ProductListParams(search: search));
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const ProductListFetchingFailed(message: cacheFailureMessage));
      } else {
        emit(const ProductListFetchingFailed(
            message: 'Products fetching failed'));
      }
    },
        (r) => emit(ProductListPopulated(
            products: r!.map((e) => e.toProduct()).toList() ?? [])));
  }

  void getSelectedProducts(List<Product> products, List<Cart> carts) {
    for (int i = 0; i < products.length; i++) {
      for (int j = 0; j < carts.length; j++) {
        if ('${products[i].id}' == carts[j].productId) {
          products[i].quantity = carts[j].quantity;
          products[i].total =
              (carts[j].quantity * (products[i].rate ?? 0)).to2DigitFraction();
        }
      }
    }
    emit(SelectedProductListPopulated(products: products));
  }
}
