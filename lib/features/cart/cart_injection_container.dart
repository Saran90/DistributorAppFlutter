import '../../app_config.dart';
import 'data/datasource/add_cart_data_source.dart';
import 'data/datasource/cart_list_data_source.dart';
import 'data/datasource/delete_cart_data_source.dart';
import 'data/datasource/update_cart_data_source.dart';
import 'data/repository/add_cart_repository_impl.dart';
import 'data/repository/cart_list_repository_impl.dart';
import 'data/repository/delete_cart_repository_impl.dart';
import 'data/repository/update_cart_repository_impl.dart';
import 'domain/repository/add_cart_repository.dart';
import 'domain/repository/cart_list_repository.dart';
import 'domain/repository/delete_cart_repository.dart';
import 'domain/repository/update_cart_repository.dart';
import 'domain/usecase/add_cart_use_case.dart';
import 'domain/usecase/cart_list_use_case.dart';
import 'domain/usecase/delete_cart_item_use_case.dart';
import 'domain/usecase/delete_cart_use_case.dart';
import 'domain/usecase/update_cart_use_case.dart';
import 'presentation/bloc/cart_cubit.dart';

class CartInjectionContainer{

  static void initialize(){
    AppConfig.s1.registerLazySingleton<CartListDataSource>(
            () => CartListDataSourceImpl(hiveDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<AddCartDataSource>(
            () => AddCartDataSourceImpl(hiveDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<UpdateCartDataSource>(
            () => UpdateCartDataSourceImpl(hiveDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<DeleteCartDataSource>(
            () => DeleteCartDataSourceImpl(hiveDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<CartListRepository>(
            () => CartListRepositoryImpl(cartListDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<AddCartRepository>(
            () => AddCartRepositoryImpl(addCartDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<UpdateCartRepository>(
            () => UpdateCartRepositoryImpl(updateCartDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<DeleteCartRepository>(
            () => DeleteCartRepositoryImpl(deleteCartDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<CartListUseCase>(
            () => CartListUseCase(cartListRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<AddCartUseCase>(
            () => AddCartUseCase(addCartRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<UpdateCartUseCase>(
            () => UpdateCartUseCase(updateCartRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<DeleteCartUseCase>(
            () => DeleteCartUseCase(deleteCartRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<DeleteCartItemUseCase>(
            () => DeleteCartItemUseCase(deleteCartRepository: AppConfig.s1()));
    AppConfig.s1.registerFactory<CartCubit>(() => CartCubit(
        cartListUseCase: AppConfig.s1(),
        addCartUseCase: AppConfig.s1(),
        deleteCartUseCase: AppConfig.s1(),
        updateCartUseCase: AppConfig.s1(),
        deleteCartItemUseCase: AppConfig.s1()));
  }
}