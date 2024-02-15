import 'package:auto_route/auto_route.dart';
import 'package:distributor_app_flutter/app_config.dart';
import 'package:distributor_app_flutter/features/order_history/presentation/bloc/order_history_cubit.dart';
import 'package:distributor_app_flutter/features/order_history/presentation/models/order_history.dart';
import 'package:distributor_app_flutter/features/order_history/presentation/pages/order_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_history_detail_screen.dart';

@RoutePage(name: 'OrderHistoryDetailRouter')
class OrderHistoryDetailWrapper extends StatelessWidget {
  const OrderHistoryDetailWrapper({Key? key,required this.orderHistory}) : super(key: key);

  final OrderHistory orderHistory;

  @override
  Widget build(BuildContext context) {
    return OrderHistoryDetailScreen(orderHistory: orderHistory,);
  }
}
