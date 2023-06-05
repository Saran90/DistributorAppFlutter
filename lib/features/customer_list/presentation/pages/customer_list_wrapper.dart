import 'package:auto_route/auto_route.dart';
import 'package:distributor_app_flutter/features/customer_list/presentation/bloc/location_list/location_list_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_details/order_details_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_summary/order_summary_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/sales_order/sales_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_config.dart';
import '../bloc/customer_list/customer_list_cubit.dart';
import 'customer_list_screen.dart';

@RoutePage(name: 'CustomerListRouter')
class CustomerListWrapper extends StatelessWidget {
  const CustomerListWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CustomerListCubit>(
        create: (context) => AppConfig.s1(),
      ),
      BlocProvider<LocationListCubit>(
        create: (context) => AppConfig.s1()..getLocations(),
      ),
      BlocProvider<SalesOrderCubit>(
        create: (context) => AppConfig.s1(),
      ),
      BlocProvider<OrderSummaryCubit>(
        create: (context) => AppConfig.s1(),
      ),
      BlocProvider<OrderDetailsCubit>(
        create: (context) => AppConfig.s1(),
      )
    ], child: const CustomerListScreen());
  }
}
