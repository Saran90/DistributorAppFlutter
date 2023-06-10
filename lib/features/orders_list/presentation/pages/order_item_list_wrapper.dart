import 'package:auto_route/auto_route.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_details/order_details_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/pages/order_item_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_config.dart';
import '../bloc/order_summary/order_summary_cubit.dart';

@RoutePage(name: 'OrdersItemListRouter')
class OrdersItemListWrapper extends StatelessWidget {
  OrdersItemListWrapper({Key? key, required this.orderId}) : super(key: key);

  int orderId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<OrderDetailsCubit>(
        create: (context) => AppConfig.s1()..getOrderDetailsForOrder(orderId),
      ),
      BlocProvider<OrderSummaryCubit>(
        create: (context) =>
            AppConfig.s1(),
      )
    ], child: OrdersItemListScreen(orderId: orderId,));
  }
}
