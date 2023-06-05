import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_details_model.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_summary_model.dart';
import 'package:distributor_app_flutter/core/data/usecase/usecase.dart';
import 'package:distributor_app_flutter/features/data_download/presentation/bloc/product_data/product_data_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/add_order_details_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/add_order_summary_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/delete_all_order_details_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/delete_all_order_summaries_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/delete_all_order_summary_by_customer_id_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/delete_order_details_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/delete_order_summary_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/get_all_order_summaries_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/get_order_details_for_order_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/get_order_summary_by_customer_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/get_order_summary_by_id_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/update_order_details_status_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/pages/models/order.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../utils/strings.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit({
    required this.addOrderDetailsUseCase,
    required this.deleteOrderDetailsUseCase,
    required this.getOrderDetailsForOrderUseCase,
    required this.deleteAllOrderDetailsUseCase,
    required this.updateOrderDetailsStatusUseCase,
  }) : super(OrderDetailsInitial());

  final AddOrderDetailsUseCase addOrderDetailsUseCase;
  final DeleteOrderDetailsUseCase deleteOrderDetailsUseCase;
  final GetOrderDetailsForOrderUseCase getOrderDetailsForOrderUseCase;
  final DeleteAllOrderDetailsUseCase deleteAllOrderDetailsUseCase;
  final UpdateOrderDetailsStatusUseCase updateOrderDetailsStatusUseCase;

  Future<void> addOrderDetails(
      List<HiveOrderDetailsModel> hiveOrderDetailsModels) async {
    emit(OrderDetailsLoading());
    var result = await addOrderDetailsUseCase.call(
        AddOrderDetailsParams(hiveOrderDetailsModels: hiveOrderDetailsModels));
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const OrderDetailsAdditionFailed(message: cacheFailureMessage));
      } else {
        emit(const OrderDetailsAdditionFailed(
            message: 'Order Details addition failed'));
      }
    }, (r) => emit(OrderDetailsAdded()));
  }

  Future<void> deleteOrderDetailForOrder(int orderId) async {
    emit(OrderDetailsLoading());
    var result = await deleteOrderDetailsUseCase
        .call(DeleteOrderDetailsParams(orderId: orderId));
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const OrderDetailsDeletionFailed(message: cacheFailureMessage));
      } else {
        emit(const OrderDetailsDeletionFailed(
            message: 'Order Details deletion failed'));
      }
    }, (r) => emit(OrderDetailsDeleted()));
  }

  Future<void> getOrderDetailsForOrder(int orderId) async {
    emit(OrderDetailsLoading());
    var result = await getOrderDetailsForOrderUseCase
        .call(GetOrderDetailsForOrderParams(orderId: orderId));
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const OrderDetailsFetchingFailed(message: cacheFailureMessage));
      } else {
        emit(const OrderDetailsFetchingFailed(
            message: 'Order Details deletion failed'));
      }
    }, (r) => emit(OrderDetailsPopulated(orderDtails: r ?? [])));
  }

  Future<void> deleteAllOrderDetails() async {
    emit(OrderDetailsLoading());
    var result = await deleteAllOrderDetailsUseCase.call(NoParams());
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const AllOrderDetailsDeletionFailed(message: cacheFailureMessage));
      } else {
        emit(const AllOrderDetailsDeletionFailed(
            message: 'All Order Details deletion failed'));
      }
    }, (r) => emit(AllOrderDetailsDeleted()));
  }

  Future<void> updateOrderDetailsStatus(int orderId, int status) async {
    emit(OrderDetailsLoading());
    var result = await updateOrderDetailsStatusUseCase
        .call(UpdateOrderDetailsStatusParams(orderId: orderId, status: status));
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const OrderDetailsStatusUpdationFailed(
            message: cacheFailureMessage));
      } else {
        emit(const OrderDetailsStatusUpdationFailed(
            message: 'Order Details status updation failed'));
      }
    }, (r) => emit(OrderDetailsStatusUpdated()));
  }

}
