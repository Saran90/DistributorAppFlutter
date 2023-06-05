import 'package:dio/dio.dart';

import '../../app_config.dart';
import 'data/datasource/order_details_data_source.dart';
import 'data/datasource/order_summary_data_source.dart';
import 'data/datasource/sales_order_data_source.dart';
import 'data/repository/order_details_repository_impl.dart';
import 'data/repository/order_summary_repository_impl.dart';
import 'data/repository/sales_order_repository_impl.dart';
import 'domain/repository/order_details_repository.dart';
import 'domain/repository/order_summary_repository.dart';
import 'domain/repository/sales_order_repository.dart';
import 'domain/usecase/add_order_details_use_case.dart';
import 'domain/usecase/add_order_summary_use_case.dart';
import 'domain/usecase/delete_all_order_details_use_case.dart';
import 'domain/usecase/delete_all_order_summaries_use_case.dart';
import 'domain/usecase/delete_all_order_summary_by_customer_id_use_case.dart';
import 'domain/usecase/delete_order_details_use_case.dart';
import 'domain/usecase/delete_order_summary_use_case.dart';
import 'domain/usecase/get_all_order_summaries_use_case.dart';
import 'domain/usecase/get_order_details_for_order_use_case.dart';
import 'domain/usecase/get_order_summary_by_customer_use_case.dart';
import 'domain/usecase/get_order_summary_by_id_use_case.dart';
import 'domain/usecase/send_sales_order_update_use_case.dart';
import 'domain/usecase/send_sales_order_use_case.dart';
import 'domain/usecase/update_order_details_status_use_case.dart';
import 'domain/usecase/update_order_summary_status_use_case.dart';
import 'presentation/bloc/order_details/order_details_cubit.dart';
import 'presentation/bloc/order_summary/order_summary_cubit.dart';
import 'presentation/bloc/sales_order/sales_order_cubit.dart';

class OrderInjectionContainer {

  OrderInjectionContainer({required this.dio});

  final Dio dio;

  void initialize() {
    AppConfig.s1.registerLazySingleton<OrderSummaryDataSource>(
        () => OrderSummaryDataSourceImpl(hiveDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<OrderSummaryRepository>(
        () => OrderSummaryRepositoryImpl(orderSummaryDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<AddOrderSummaryUseCase>(
        () => AddOrderSummaryUseCase(orderSummaryRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<DeleteAllOrderSummariesUseCase>(
        () => DeleteAllOrderSummariesUseCase(orderSummaryRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<DeleteAllOrderSummaryByCustomerIdUseCase>(() =>
        DeleteAllOrderSummaryByCustomerIdUseCase(orderSummaryRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<DeleteOrderSummaryUseCase>(
        () => DeleteOrderSummaryUseCase(orderSummaryRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<GetAllOrderSummariesUseCase>(
        () => GetAllOrderSummariesUseCase(orderSummaryRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<GetOrderSummaryByCustomerIdUseCase>(
        () => GetOrderSummaryByCustomerIdUseCase(orderSummaryRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<GetOrderSummaryByIdUseCase>(
        () => GetOrderSummaryByIdUseCase(orderSummaryRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<UpdateOrderSummaryStatusUseCase>(
        () => UpdateOrderSummaryStatusUseCase(orderSummaryRepository: AppConfig.s1()));

    AppConfig.s1.registerFactory<OrderSummaryCubit>(() => OrderSummaryCubit(
        addOrderSummaryUseCase: AppConfig.s1(),
        deleteAllOrderSummariesUseCase: AppConfig.s1(),
        deleteAllOrderSummaryByCustomerIdUseCase: AppConfig.s1(),
        deleteOrderSummaryUseCase: AppConfig.s1(),
        getAllOrderSummariesUseCase: AppConfig.s1(),
        getOrderSummaryByCustomerIdUseCase: AppConfig.s1(),
        getOrderSummaryByIdUseCase: AppConfig.s1(),
        updateOrderSummaryStatusUseCase: AppConfig.s1()));

    AppConfig.s1.registerLazySingleton<OrderDetailsDataSource>(
        () => OrderDetailsDataSourceImpl(hiveDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<OrderDetailsRepository>(
        () => OrderDetailsRepositoryImpl(orderDetailsDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<AddOrderDetailsUseCase>(
        () => AddOrderDetailsUseCase(orderDetailsRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<DeleteOrderDetailsUseCase>(
        () => DeleteOrderDetailsUseCase(orderDetailsRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<GetOrderDetailsForOrderUseCase>(
        () => GetOrderDetailsForOrderUseCase(orderDetailsRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<DeleteAllOrderDetailsUseCase>(
        () => DeleteAllOrderDetailsUseCase(orderDetailsRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<UpdateOrderDetailsStatusUseCase>(
        () => UpdateOrderDetailsStatusUseCase(orderDetailsRepository: AppConfig.s1()));

    AppConfig.s1.registerFactory<OrderDetailsCubit>(() => OrderDetailsCubit(
        addOrderDetailsUseCase: AppConfig.s1(),
        deleteOrderDetailsUseCase: AppConfig.s1(),
        getOrderDetailsForOrderUseCase: AppConfig.s1(),
        deleteAllOrderDetailsUseCase: AppConfig.s1(),
        updateOrderDetailsStatusUseCase: AppConfig.s1()));

    AppConfig.s1.registerLazySingleton<SalesOrderDataSource>(() =>
        SalesOrderDataSourceImpl(sharedPreferenceDataSource: AppConfig.s1(), dio: dio));
    AppConfig.s1.registerLazySingleton<SalesOrderRepository>(
        () => SalesOrderRepositoryImpl(salesOrderDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<SendSalesOrderUseCase>(
        () => SendSalesOrderUseCase(salesOrderRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<SendSalesOrderUpdateUseCase>(
        () => SendSalesOrderUpdateUseCase(salesOrderRepository: AppConfig.s1()));

    AppConfig.s1.registerFactory<SalesOrderCubit>(() => SalesOrderCubit(
        sendSalesOrderUseCase: AppConfig.s1(),
        getAllOrderSummariesUseCase: AppConfig.s1(),
        getOrderDetailsForOrderUseCase: AppConfig.s1(),
        updateOrderDetailsStatusUseCase: AppConfig.s1(),
        updateOrderSummaryStatusUseCase: AppConfig.s1(),
        getOrderSummaryByIdUseCase: AppConfig.s1(),
        sendSalesOrderUpdateUseCase: AppConfig.s1()));
  }
}
