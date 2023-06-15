import 'package:dio/dio.dart';

import '../../app_config.dart';
import '../customer_list/data/datasource/customer_list_data_source.dart';
import '../customer_list/data/datasource/location_list_data_source.dart';
import '../customer_list/data/repository/customer_list_repository_impl.dart';
import '../customer_list/data/repository/location_list_repository_impl.dart';
import '../customer_list/domain/repository/customer_list_repository.dart';
import '../customer_list/domain/repository/location_list_repository.dart';
import '../customer_list/domain/usecase/customer_list_use_case.dart';
import '../customer_list/domain/usecase/location_list_use_case.dart';
import '../customer_list/presentation/bloc/customer_list/customer_list_cubit.dart';
import '../customer_list/presentation/bloc/location_list/location_list_cubit.dart';
import 'data/datasource/customer_data_data_source.dart';
import 'data/datasource/is_data_available_data_source.dart';
import 'data/datasource/location_data_data_source.dart';
import 'data/datasource/product_data_data_source.dart';
import 'data/repository/customer_data_repository_impl.dart';
import 'data/repository/is_data_available_repository_impl.dart';
import 'data/repository/location_data_repository_impl.dart';
import 'data/repository/product_data_repository_impl.dart';
import 'domain/repository/customer_data_repository.dart';
import 'domain/repository/is_data_available_repository.dart';
import 'domain/repository/location_data_repository.dart';
import 'domain/repository/product_data_repository.dart';
import 'domain/usecase/customer_data_use_case.dart';
import 'domain/usecase/is_data_available_use_case.dart';
import 'domain/usecase/location_data_use_case.dart';
import 'domain/usecase/product_data_use_case.dart';
import 'presentation/bloc/customer_data/customer_data_cubit.dart';
import 'presentation/bloc/is_data_available/data_download_cubit.dart';
import 'presentation/bloc/location_data/location_data_cubit.dart';
import 'presentation/bloc/product_data/product_data_cubit.dart';

class DataInjectionContainer {
  DataInjectionContainer({required this.dio});

  final Dio dio;

  void initialize() {
    //Product Data
    AppConfig.s1.registerLazySingleton<ProductDataDataSource>(() =>
        ProductDataDataSourceImpl(
            dio: dio,
            hiveDataSource: AppConfig.s1(),
            sharedPreferenceDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<ProductDataRepository>(
        () => ProductDataRepositoryImpl(productDataDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<ProductDataUseCase>(
        () => ProductDataUseCase(productDataRepository: AppConfig.s1()));
    AppConfig.s1.registerFactory<ProductDataCubit>(
        () => ProductDataCubit(productDataUseCase: AppConfig.s1()));

    //Customer Data
    AppConfig.s1.registerLazySingleton<CustomerDataDataSource>(() =>
        CustomerDataDataSourceImpl(
            dio: dio,
            hiveDataSource: AppConfig.s1(),
            sharedPreferenceDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<CustomerDataRepository>(() =>
        CustomerDataRepositoryImpl(customerDataDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<CustomerDataUseCase>(
        () => CustomerDataUseCase(customerDataRepository: AppConfig.s1()));
    AppConfig.s1.registerFactory<CustomerDataCubit>(
        () => CustomerDataCubit(customerDataUseCase: AppConfig.s1()));

    //Location Data
    AppConfig.s1.registerLazySingleton<LocationDataDataSource>(() =>
        LocationDataDataSourceImpl(
            dio: dio,
            hiveDataSource: AppConfig.s1(),
            sharedPreferenceDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<LocationDataRepository>(() =>
        LocationDataRepositoryImpl(locationDataDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<LocationDataUseCase>(
        () => LocationDataUseCase(locationDataRepository: AppConfig.s1()));
    AppConfig.s1.registerFactory<LocationDataCubit>(
        () => LocationDataCubit(locationDataUseCase: AppConfig.s1()));

    //Data Availability
    AppConfig.s1.registerLazySingleton<IsDataAvailableDataSource>(() =>
        IsDataAvailableDataSourceImpl(
            hiveDataSource: AppConfig.s1(),
            sharedPreferenceDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<IsDataAvailableRepository>(() =>
        IsDataAvailableRepositoryImpl(
            isDataAvailableDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<IsDataAvailableUseCase>(() =>
        IsDataAvailableUseCase(isDataAvailableRepository: AppConfig.s1()));
    AppConfig.s1.registerFactory<DataDownloadCubit>(
        () => DataDownloadCubit(isDataAvailableUseCase: AppConfig.s1()));

    //Customer List
    AppConfig.s1.registerLazySingleton<CustomerListDataSource>(
        () => CustomerListDataSourceImpl(hiveDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<CustomerListRepository>(() =>
        CustomerListRepositoryImpl(customerListDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<CustomerListUseCase>(
        () => CustomerListUseCase(customerListRepository: AppConfig.s1()));
    AppConfig.s1.registerFactory<CustomerListCubit>(
        () => CustomerListCubit(customerListUseCase: AppConfig.s1()));

    //Location List
    AppConfig.s1.registerLazySingleton<LocationListDataSource>(
        () => LocationListDataSourceImpl(hiveDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<LocationListRepository>(() =>
        LocationListRepositoryImpl(locationListDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<LocationListUseCase>(
        () => LocationListUseCase(locationListRepository: AppConfig.s1()));
    AppConfig.s1.registerFactory<LocationListCubit>(
        () => LocationListCubit(locationListUseCase: AppConfig.s1()));
  }
}
