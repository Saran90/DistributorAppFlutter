import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_summary_model.dart';
import 'package:distributor_app_flutter/core/data/usecase/usecase.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/add_order_summary_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/delete_all_order_summaries_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/delete_all_order_summary_by_customer_id_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/delete_order_summary_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/get_all_order_summaries_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/get_order_summary_by_customer_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/get_order_summary_by_id_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/update_order_summary_status_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/pages/models/order.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../utils/strings.dart';
import '../../../domain/usecase/get_all_failed_order_summaries_use_case.dart';

part 'order_summary_state.dart';

class OrderSummaryCubit extends Cubit<OrderSummaryState> {
  OrderSummaryCubit({
    required this.addOrderSummaryUseCase,
    required this.deleteAllOrderSummariesUseCase,
    required this.deleteAllOrderSummaryByCustomerIdUseCase,
    required this.deleteOrderSummaryUseCase,
    required this.getAllOrderSummariesUseCase,
    required this.getAllFailedOrderSummariesUseCase,
    required this.getOrderSummaryByCustomerIdUseCase,
    required this.getOrderSummaryByIdUseCase,
    required this.updateOrderSummaryStatusUseCase,
  }) : super(OrderSummaryInitial());

  final AddOrderSummaryUseCase addOrderSummaryUseCase;
  final DeleteAllOrderSummariesUseCase deleteAllOrderSummariesUseCase;
  final DeleteAllOrderSummaryByCustomerIdUseCase
      deleteAllOrderSummaryByCustomerIdUseCase;
  final DeleteOrderSummaryUseCase deleteOrderSummaryUseCase;
  final GetAllOrderSummariesUseCase getAllOrderSummariesUseCase;
  final GetAllFailedOrderSummariesUseCase getAllFailedOrderSummariesUseCase;
  final GetOrderSummaryByCustomerIdUseCase getOrderSummaryByCustomerIdUseCase;
  final GetOrderSummaryByIdUseCase getOrderSummaryByIdUseCase;
  final UpdateOrderSummaryStatusUseCase updateOrderSummaryStatusUseCase;

  Future<void> addOrderSummary(
      HiveOrderSummaryModel hiveOrderSummaryModel) async {
    emit(OrderSummaryLoading());
    var result = await addOrderSummaryUseCase.call(
        AddOrderSummaryParams(hiveOrderSummaryModel: hiveOrderSummaryModel));
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const OrderSummaryAdditionFailed(message: cacheFailureMessage));
      } else {
        emit(
            const OrderSummaryAdditionFailed(message: 'Order addition failed'));
      }
    }, (r) => emit(OrderSummaryAdded(hiveOrderSummaryModel: r)));
  }

  Future<void> deleteAllOrderSummaries() async {
    emit(OrderSummaryLoading());
    var result = await deleteAllOrderSummariesUseCase.call(NoParams());
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const OrderSummaryDeletionFailed(message: cacheFailureMessage));
      } else {
        emit(
            const OrderSummaryDeletionFailed(message: 'Order deletion failed'));
      }
    }, (r) => emit(OrderSummaryDeleted()));
  }

  Future<void> deleteAllOrderSummaryByCustomerId(int customerId) async {
    emit(OrderSummaryLoading());
    var result = await deleteAllOrderSummaryByCustomerIdUseCase
        .call(DeleteAllOrderSummaryByCustomerIdParams(customerId: customerId));
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const OrderSummaryDeletionFailed(message: cacheFailureMessage));
      } else {
        emit(
            const OrderSummaryDeletionFailed(message: 'Order deletion failed'));
      }
    }, (r) => emit(OrderSummaryDeleted()));
  }

  Future<void> deleteOrderSummary(
      HiveOrderSummaryModel hiveOrderSummaryModel) async {
    emit(OrderSummaryLoading());
    var result = await deleteOrderSummaryUseCase.call(
        DeleteOrderSummaryParams(hiveOrderSummaryModel: hiveOrderSummaryModel));
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const OrderSummaryDeletionFailed(message: cacheFailureMessage));
      } else {
        emit(
            const OrderSummaryDeletionFailed(message: 'Order deletion failed'));
      }
    }, (r) => emit(OrderSummaryDeleted()));
  }

  Future<void> getAllOrderSummaries(int status) async {
    emit(OrderSummaryLoading());
    var result = await getAllOrderSummariesUseCase.call(NoParams());
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const OrderSummaryFetchingFailed(message: cacheFailureMessage));
      } else {
        emit(
            const OrderSummaryFetchingFailed(message: 'Order fetching failed'));
      }
    }, (r) {
      if (r != null) {
        List<HiveOrderSummaryModel> pendingOrderSummaries =
            r.where((element) => element.status == status).toList();
        pendingOrderSummaries.sort(
          (a, b) => a.orderDate.compareTo(b.orderDate),
        );
        List<Order> pendingOrders = [];
        for (int i = 0; i < pendingOrderSummaries.length; i++) {
          pendingOrders.add(Order(
              orderId: pendingOrderSummaries[i].orderId,
              customerId: pendingOrderSummaries[i].customerId,
              status: pendingOrderSummaries[i].status,
              amount: pendingOrderSummaries[i].orderAmount,
              customerName: pendingOrderSummaries[i].customerName,
              slNo: (i + 1)));
        }
        emit(OrderSummaryPopulated(orderSummaries: pendingOrders));
      } else {
        emit(OrderSummaryPopulated(orderSummaries: []));
      }
    });
  }

  Future<void> getAllFailedOrderSummaries() async {
    emit(OrderSummaryLoading());
    var result = await getAllFailedOrderSummariesUseCase.call(NoParams());
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const OrderSummaryFetchingFailed(message: cacheFailureMessage));
      } else {
        emit(
            const OrderSummaryFetchingFailed(message: 'Order fetching failed'));
      }
    }, (r) {
      if (r != null) {
        List<HiveOrderSummaryModel> failedOrderSummaries = r;
        failedOrderSummaries.sort(
          (a, b) => a.orderDate.compareTo(b.orderDate),
        );
        List<Order> failedOrders = [];
        for (int i = 0; i < failedOrderSummaries.length; i++) {
          failedOrders.add(Order(
              orderId: failedOrderSummaries[i].orderId,
              customerId: failedOrderSummaries[i].customerId,
              status: failedOrderSummaries[i].status,
              amount: failedOrderSummaries[i].orderAmount,
              customerName: failedOrderSummaries[i].customerName,
              slNo: (i + 1)));
        }
        emit(OrderSummaryPopulated(orderSummaries: failedOrders));
      } else {
        emit(OrderSummaryPopulated(orderSummaries: []));
      }
    });
  }

  Future<void> updateOrderSummaryStatus(int orderId, int status) async {
    emit(OrderSummaryLoading());
    var result = await updateOrderSummaryStatusUseCase
        .call(UpdateOrderSummaryStatusParams(orderId: orderId, status: status));
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const OrderSummaryStatusUpdationFailed(
            message: cacheFailureMessage));
      } else {
        emit(const OrderSummaryStatusUpdationFailed(
            message: 'Order status updation failed'));
      }
    }, (r) => emit(OrderSummaryStatusUpdated()));
  }

  Future<void> deleteSummary(int orderId) async {
    emit(OrderSummaryLoading());
    var orderSummary = await getOrderSummaryByIdUseCase
        .call(GetOrderSummaryByIdParams(orderId: orderId));
    HiveOrderSummaryModel? hiveOrderSummaryModel;
    orderSummary.fold((l) {
      if (l is CacheFailure) {
        emit(const OrderSummaryDeletionFailed(message: cacheFailureMessage));
      } else {
        emit(
            const OrderSummaryDeletionFailed(message: 'Order deletion failed'));
      }
    }, (r) => hiveOrderSummaryModel = r);
    if (hiveOrderSummaryModel != null) {
      var result = await deleteOrderSummaryUseCase.call(
          DeleteOrderSummaryParams(
              hiveOrderSummaryModel: hiveOrderSummaryModel!));
      result.fold((l) {
        if (l is CacheFailure) {
          emit(const OrderSummaryDeletionFailed(message: cacheFailureMessage));
        } else {
          emit(const OrderSummaryDeletionFailed(
              message: 'Order deletion failed'));
        }
      }, (r) => emit(OrderSummaryDeleted()));
    } else {
      emit(const OrderSummaryDeletionFailed(message: 'Order deletion failed'));
    }
  }
}
