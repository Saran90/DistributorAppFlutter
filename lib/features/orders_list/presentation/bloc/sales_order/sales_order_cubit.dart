import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_details_model.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_summary_model.dart';
import 'package:distributor_app_flutter/core/data/usecase/usecase.dart';
import 'package:distributor_app_flutter/features/data_download/presentation/bloc/product_data/product_data_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderRequest.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderUpdateRequest.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/add_order_details_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/add_order_summary_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/delete_all_order_summaries_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/delete_all_order_summary_by_customer_id_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/delete_order_details_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/delete_order_summary_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/get_all_order_summaries_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/get_order_details_for_order_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/get_order_summary_by_customer_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/get_order_summary_by_id_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/send_sales_order_update_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/send_sales_order_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/update_order_details_status_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/update_order_summary_status_use_case.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/pages/models/order.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/strings.dart';
import '../../../domain/usecase/get_all_unsend_order_summaries_use_case.dart';

part 'sales_order_state.dart';

class SalesOrderCubit extends Cubit<SalesOrderState> {
  SalesOrderCubit({
    required this.sendSalesOrderUseCase,
    required this.getAllOrderSummariesUseCase,
    required this.getOrderDetailsForOrderUseCase,
    required this.updateOrderSummaryStatusUseCase,
    required this.updateOrderDetailsStatusUseCase,
    required this.sendSalesOrderUpdateUseCase,
    required this.getOrderSummaryByIdUseCase,
    required this.getAllUnSendOrderSummariesUseCase,
  }) : super(SalesOrderInitial());

  final SendSalesOrderUseCase sendSalesOrderUseCase;
  final GetAllOrderSummariesUseCase getAllOrderSummariesUseCase;
  final GetAllUnSendOrderSummariesUseCase getAllUnSendOrderSummariesUseCase;
  final GetOrderDetailsForOrderUseCase getOrderDetailsForOrderUseCase;
  final UpdateOrderSummaryStatusUseCase updateOrderSummaryStatusUseCase;
  final UpdateOrderDetailsStatusUseCase updateOrderDetailsStatusUseCase;
  final SendSalesOrderUpdateUseCase sendSalesOrderUpdateUseCase;
  final GetOrderSummaryByIdUseCase getOrderSummaryByIdUseCase;

  Future<void> sendSalesOrder() async {
    emit(SalesOrderLoading());
    List<SalesorderList> salesOrderList = [];
    var orderSummaries =
        await getAllUnSendOrderSummariesUseCase.call(NoParams());
    List<HiveOrderSummaryModel>? orderSummaryModels;
    orderSummaries.fold(
        (l) => orderSummaryModels = [], (r) => orderSummaryModels = r ?? []);
    if (orderSummaryModels != null) {
      for (int i = 0; i < orderSummaryModels!.length; i++) {
        OrderSummary orderSummary = OrderSummary(
            orderDate: orderSummaryModels![i].orderDate.toApiFormat(),
            custId: orderSummaryModels![i].customerId,
            orderAmt: orderSummaryModels![i].orderAmount.toString(),
            salesmanId: orderSummaryModels![i].userId);
        List<OrderDetails> orderDetailsList = [];
        var orderDetails = await getOrderDetailsForOrderUseCase.call(
            GetOrderDetailsForOrderParams(
                orderId: orderSummaryModels![i].orderId));
        List<HiveOrderDetailsModel>? orderDetailsModels;
        orderDetails.fold((l) => orderDetailsModels = [],
            (r) => orderDetailsModels = r ?? []);
        if (orderDetailsModels != null) {
          for (var orderDetail in orderDetailsModels!) {
            OrderDetails orderDetails = OrderDetails(
                rate: orderDetail.rate,
                mrp: orderDetail.mrp,
                productId: orderDetail.productId,
                qty: orderDetail.quantity);
            orderDetailsList.add(orderDetails);
          }
        }
        salesOrderList.add(SalesorderList(
            orderSummary: orderSummary, orderDetails: orderDetailsList));
      }
    }

    if (salesOrderList.isNotEmpty) {
      SendSalesOrderRequest sendSalesOrderRequest =
          SendSalesOrderRequest(salesorderList: salesOrderList);

      var result = await sendSalesOrderUseCase
          .call(SendSalesOrderParams(request: sendSalesOrderRequest));
      result.fold((l) {
        if (l is ServerFailure) {
          emit(const SalesOrderSendingFailed(message: serverFailureMessage));
        } else if (l is NetworkFailure) {
          emit(const SalesOrderSendingFailed(message: networkFailureMessage));
        } else {
          emit(const SalesOrderSendingFailed(
              message: 'Sales order sending failed'));
        }
      }, (r) async {
        if (r != null) {
          if ((r.status ?? 0) == 1) {
            debugPrint('OrderSummaryLength: ${orderSummaryModels!.length}');
            for (var orderSummary in orderSummaryModels!) {
              await updateOrderSummaryStatus(orderSummary.orderId, 1);
            }
            emit(SalesOrderSendSuccessfully(
                message: r.statusMessage ?? 'Order Send successfully'));
          } else {
            for (var orderSummary in orderSummaryModels!) {
              await updateOrderSummaryStatus(
                  orderSummary.orderId, r.status?.toInt() ?? 0);
            }
            emit(SalesOrderSendingFailed(
                message: r.statusMessage ?? 'Sales order sending failed'));
          }
        } else {
          emit(const SalesOrderSendingFailed(
              message: 'Sales order sending failed'));
        }
      });
    } else {
      emit(const NoSalesOrderAvailableForSending(
          message: 'No pending sales order'));
    }
  }

  Future<void> sendSalesOrderUpdate(int orderId) async {
    emit(SalesOrderLoading());
    var orderSummary = await getOrderSummaryByIdUseCase
        .call(GetOrderSummaryByIdParams(orderId: orderId));
    HiveOrderSummaryModel? hiveOrderSummaryModel;
    orderSummary.fold(
        (l) => hiveOrderSummaryModel = null, (r) => hiveOrderSummaryModel = r);
    if (hiveOrderSummaryModel != null) {
      OrderSummaryModel orderSummaryModel = OrderSummaryModel(
          orderDate: hiveOrderSummaryModel!.orderDate.toApiFormat(),
          custId: hiveOrderSummaryModel!.customerId,
          orderAmt: hiveOrderSummaryModel!.orderAmount.toString(),
          salesmanId: hiveOrderSummaryModel!.userId);
      List<OrderDetailsModel> orderDetailsList = [];
      var orderDetails = await getOrderDetailsForOrderUseCase.call(
          GetOrderDetailsForOrderParams(
              orderId: hiveOrderSummaryModel!.orderId));
      List<HiveOrderDetailsModel>? orderDetailsModels;
      orderDetails.fold(
          (l) => orderDetailsModels = [], (r) => orderDetailsModels = r ?? []);
      if (orderDetailsModels != null) {
        for (var orderDetail in orderDetailsModels!) {
          OrderDetailsModel orderDetails = OrderDetailsModel(
              rate: orderDetail.rate,
              mrp: orderDetail.mrp,
              productId: orderDetail.productId,
              qty: orderDetail.quantity);
          orderDetailsList.add(orderDetails);
        }
      }
      SendSalesOrderUpdateRequest salesOrderUpdateRequest =
          SendSalesOrderUpdateRequest(
              orderSummary: orderSummaryModel, orderDetails: orderDetailsList);
      var result = await sendSalesOrderUpdateUseCase
          .call(SendSalesOrderUpdateParams(request: salesOrderUpdateRequest));
      result.fold((l) {
        if (l is ServerFailure) {
          emit(const SalesOrderSendingFailed(message: serverFailureMessage));
        } else if (l is NetworkFailure) {
          emit(const SalesOrderSendingFailed(message: networkFailureMessage));
        } else {
          emit(const SalesOrderSendingFailed(
              message: 'Sales order sending failed'));
        }
      }, (r) async {
        if (r != null) {
          if ((r.status ?? 0) == 1) {
            await updateOrderSummaryStatus(hiveOrderSummaryModel!.orderId, 1);
            emit(SalesOrderSendSuccessfully(
                message: r.statusMessage ?? 'Order resend successfully'));
          } else {
            emit(SalesOrderSendingFailed(
                message: r.statusMessage ?? 'Sales order sending failed'));
          }
        } else {
          emit(const SalesOrderSendingFailed(
              message: 'Sales order sending failed'));
        }
      });
    } else {
      emit(
          const SalesOrderSendingFailed(message: 'Sales order sending failed'));
    }
  }

  Future<void> updateOrderSummaryStatus(int orderId, int status) async {
    var result = await updateOrderSummaryStatusUseCase
        .call(UpdateOrderSummaryStatusParams(orderId: orderId, status: status));
  }

  Future<void> updateOrderDetailsStatus(int orderId, int status) async {
    emit(SalesOrderLoading());
    var result = await updateOrderDetailsStatusUseCase
        .call(UpdateOrderDetailsStatusParams(orderId: orderId, status: status));
  }
}
