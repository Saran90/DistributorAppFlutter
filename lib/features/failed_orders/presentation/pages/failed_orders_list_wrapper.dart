import 'package:auto_route/auto_route.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_details/order_details_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_summary/order_summary_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/sales_order/sales_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../app_config.dart';
import 'failed_orders_list_screen.dart';

@RoutePage(name: 'FailedOrdersListRouter')
class FailedOrdersListWrapper extends StatelessWidget {
  const FailedOrdersListWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<OrderSummaryCubit>(
        create: (context) => AppConfig.s1(),
      ),
      BlocProvider<SalesOrderCubit>(
        create: (context) => AppConfig.s1(),
      ),
      BlocProvider<OrderDetailsCubit>(
        create: (context) => AppConfig.s1(),
      )
    ], child: const FailedOrdersListScreen());
  }
}
