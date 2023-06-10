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
import 'package:distributor_app_flutter/features/orders_list/domain/usecase/send_sales_order_update_forcefully_use_case.dart';
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
    required this.sendSalesOrderUpdateForcefullyUseCase,
  }) : super(SalesOrderInitial());

  final SendSalesOrderUseCase sendSalesOrderUseCase;
  final GetAllOrderSummariesUseCase getAllOrderSummariesUseCase;
  final GetAllUnSendOrderSummariesUseCase getAllUnSendOrderSummariesUseCase;
  final GetOrderDetailsForOrderUseCase getOrderDetailsForOrderUseCase;
  final UpdateOrderSummaryStatusUseCase updateOrderSummaryStatusUseCase;
  final UpdateOrderDetailsStatusUseCase updateOrderDetailsStatusUseCase;
  final SendSalesOrderUpdateUseCase sendSalesOrderUpdateUseCase;
  final SendSalesOrderUpdateForcefullyUseCase
      sendSalesOrderUpdateForcefullyUseCase;
  final GetOrderSummaryByIdUseCase getOrderSummaryByIdUseCase;

  Future<void> sendSalesOrder() async {
    emit(SalesOrdersLoading());
    var orderSummaries =
        await getAllUnSendOrderSummariesUseCase.call(NoParams());
    List<HiveOrderSummaryModel> hiveOrderSummaryModels = [];
    orderSummaries.fold(
        (l) => hiveOrderSummaryModels = [],
        (r) => hiveOrderSummaryModels =
            r?.where((element) => element.status == -2).toList() ?? []);
    List<int> ordersUploaded = [];
    List<int> ordersUploadingFailed = [];
    if (hiveOrderSummaryModels.isNotEmpty) {
      for (int i = 0; i < hiveOrderSummaryModels.length; i++) {
        var orderSummary = hiveOrderSummaryModels[i];

        OrderSummaryModel orderSummaryModel = OrderSummaryModel(
            orderDate: orderSummary.orderDate.toApiFormat(),
            custId: orderSummary.customerId,
            orderAmt: orderSummary.orderAmount.toString(),
            salesmanId: orderSummary.userId);
        List<OrderDetailsModel> orderDetailsList = [];
        var orderDetails = await getOrderDetailsForOrderUseCase
            .call(GetOrderDetailsForOrderParams(orderId: orderSummary.orderId));
        List<HiveOrderDetailsModel>? orderDetailsModels;
        orderDetails.fold((l) => orderDetailsModels = [],
            (r) => orderDetailsModels = r ?? []);
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
                orderSummary: orderSummaryModel,
                orderDetails: orderDetailsList);
        var result = await sendSalesOrderUpdateUseCase
            .call(SendSalesOrderUpdateParams(request: salesOrderUpdateRequest));

        double progress = (i / hiveOrderSummaryModels.length);
        emit(SalesOrdersUploadProgress(progress: progress));

        await result.fold((l) {
          if (l is ServerFailure) {
            emit(const SalesOrdersSendingFailed(message: serverFailureMessage));
            return;
          } else if (l is NetworkFailure) {
            emit(
                const SalesOrdersSendingFailed(message: networkFailureMessage));
            return;
          } else {
            return;
          }
        }, (r) async {
          if (r != null) {
            int orderStatus = r.status ?? 0;
            await updateOrderSummaryStatus(orderSummary.orderId, orderStatus);
            if (orderStatus == 1) {
              ordersUploaded.add(orderSummary.orderId);
            } else {
              ordersUploadingFailed.add(orderSummary.orderId);
            }
          } else {
            await updateOrderSummaryStatus(orderSummary.orderId, 0);
            ordersUploadingFailed.add(orderSummary.orderId);
          }
        });
      }
      emit(SalesOrdersSendSuccessfully(
          message: 'Uploading complete',
          failedOrders: ordersUploadingFailed,
          uploadedOrders: ordersUploaded));
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
          int orderStatus = r.status ?? 0;
          await updateOrderSummaryStatus(
              hiveOrderSummaryModel!.orderId, orderStatus);
          if (orderStatus == 1) {
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

  Future<void> sendSalesOrderUpdateForcefully(int orderId) async {
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
      var result = await sendSalesOrderUpdateForcefullyUseCase.call(
          SendSalesOrderUpdateForcefullyParams(
              request: salesOrderUpdateRequest));
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
          int orderStatus = r.status ?? 0;
          await updateOrderSummaryStatus(
              hiveOrderSummaryModel!.orderId, orderStatus);
          if (orderStatus == 1) {
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
