import '../../app_config.dart';
import 'data/datasource/product_list_data_source.dart';
import 'data/repository/product_list_repository_impl.dart';
import 'domain/repository/product_list_repository.dart';
import 'domain/usecase/product_list_use_case.dart';
import 'presentation/bloc/product_list/product_list_cubit.dart';

class ProductInjectionContainer{

  static void initialize(){
    AppConfig.s1.registerLazySingleton<ProductListDataSource>(
            () => ProductListDataSourceImpl(hiveDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<ProductListRepository>(
            () => ProductListRepositoryImpl(productListDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<ProductListUseCase>(
            () => ProductListUseCase(productListRepository: AppConfig.s1()));
    AppConfig.s1.registerFactory<ProductListCubit>(
            () => ProductListCubit(productListUseCase: AppConfig.s1()));
  }
}