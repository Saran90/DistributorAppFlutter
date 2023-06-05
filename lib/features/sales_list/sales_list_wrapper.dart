import 'package:auto_route/auto_route.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_summary/order_summary_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/sales_order/sales_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_config.dart';
import 'sales_list_screen.dart';

@RoutePage(name: 'SalesListRouter')
class SalesListWrapper extends StatelessWidget {
  const SalesListWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<OrderSummaryCubit>(
        create: (context) => AppConfig.s1(),
      ),
      BlocProvider<SalesOrderCubit>(
        create: (context) => AppConfig.s1(),
      )
    ], child: const SalesListScreen());
  }
}
