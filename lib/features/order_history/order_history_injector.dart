import 'package:dio/dio.dart';
import 'package:distributor_app_flutter/features/order_history/data/datasource/order_history_data_source.dart';
import 'package:distributor_app_flutter/features/order_history/data/repository/order_history_repository_impl.dart';
import 'package:distributor_app_flutter/features/order_history/domain/repository/order_history_repository.dart';
import 'package:distributor_app_flutter/features/order_history/domain/usecase/get_order_history_use_case.dart';
import 'package:distributor_app_flutter/features/order_history/presentation/bloc/order_history_cubit.dart';

import '../../app_config.dart';

class OrderHistoryInjector {
  final Dio dio;

  OrderHistoryInjector({required this.dio});

  void initialize() {
    AppConfig.s1.registerLazySingleton<OrderHistoryDataSource>(
        () => OrderHistoryDataSourceImpl(dio: dio));
    AppConfig.s1.registerLazySingleton<OrderHistoryRepository>(
        () => OrderHistoryRepositoryImpl(dataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<GetOrderHistoryUseCase>(
        () => GetOrderHistoryUseCase(repository: AppConfig.s1()));

    AppConfig.s1.registerFactory<OrderHistoryCubit>(() => OrderHistoryCubit(
          getOrderHistoryUseCase: AppConfig.s1(),
        ));
  }
}
