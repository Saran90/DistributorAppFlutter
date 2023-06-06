import 'package:auto_route/auto_route.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_details/order_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_config.dart';
import 'sales_item_list_screen.dart';

@RoutePage(name: 'SalesItemListRouter')
class SalesItemListWrapper extends StatelessWidget {
  SalesItemListWrapper({Key? key, required this.orderId}) : super(key: key);

  int orderId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<OrderDetailsCubit>(
        create: (context) => AppConfig.s1()..getOrderDetailsForOrder(orderId),
      )
    ], child: const SalesItemListScreen());
  }
}
