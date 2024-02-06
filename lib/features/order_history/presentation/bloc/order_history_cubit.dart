import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/features/order_history/domain/usecase/get_order_history_use_case.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../utils/strings.dart';
import '../models/order_history.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit({required this.getOrderHistoryUseCase})
      : super(OrderHistoryInitial());

  final GetOrderHistoryUseCase getOrderHistoryUseCase;

  Future<void> getOrderHistory({DateTime? fromDate, DateTime? toDate}) async {
    emit(OrderHistoryLoading());
    var result = await getOrderHistoryUseCase.call(GetOrderHistoryParams(
        fromDate: fromDate!=null?fromDate.toDDMMYYYYFormat():DateTime.now().toDDMMYYYYFormat(),
        tillDate: toDate!=null?toDate.toDDMMYYYYFormat():DateTime.now().toDDMMYYYYFormat()));
    result.fold((l) {
      if (l is ServerFailure) {
        emit(GetOrderHistoryFailed(message: serverFailureMessage));
      } else if (l is NetworkFailure) {
        emit(GetOrderHistoryFailed(message: networkFailureMessage));
      } else {
        emit(GetOrderHistoryFailed(message: 'Order history fetching failed'));
      }
    }, (r) {
      if (r != null) {
        emit(GetOrderHistorySuccess(
            orders: r.savedSalesOrder
                ?.map((e) =>
                OrderHistory(
                    customerName: e.custName,
                    orderAmount: e.orderAmt,
                    orderDate: e.orderDate?.toDate(),
                    status: e.status,
                    items: e.orderDetails?.map((f) =>
                        OrderHistoryItem(
                            productName: f.prodName,
                            mrp: f.mrp?.toDouble(),
                            rate: f.rate?.toDouble(),
                            quantity: f.qty?.toDouble(),
                            amount: f.amount?.toDouble()
                        )).toList()
                ))
                .toList() ??
                []));
      } else {
        emit(GetOrderHistorySuccess(orders: []));
      }
    });
  }
}
