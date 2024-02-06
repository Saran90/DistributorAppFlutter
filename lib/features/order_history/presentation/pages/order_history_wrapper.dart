import 'package:auto_route/auto_route.dart';
import 'package:distributor_app_flutter/app_config.dart';
import 'package:distributor_app_flutter/features/order_history/presentation/bloc/order_history_cubit.dart';
import 'package:distributor_app_flutter/features/order_history/presentation/pages/order_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'OrderHistoryRouter')
class OrderHistoryWrapper extends StatelessWidget {
  const OrderHistoryWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<OrderHistoryCubit>(
        create: (context) => AppConfig.s1()..getOrderHistory(),
      )
    ], child: const OrderHistoryScreen());
  }
}
