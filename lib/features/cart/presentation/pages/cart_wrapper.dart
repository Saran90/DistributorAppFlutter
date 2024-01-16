import 'package:auto_route/auto_route.dart';
import 'package:distributor_app_flutter/features/cart/presentation/pages/cart_screen.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_details/order_details_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_summary/order_summary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_config.dart';
import '../../../../core/data/local_storage/models/hive_customer_model.dart';
import '../bloc/cart_cubit.dart';

@RoutePage(name: 'CartRouter')
class CartWrapper extends StatelessWidget {
  const CartWrapper(
      {Key? key, required this.hiveCustomerModel, this.isCustomer})
      : super(key: key);

  final HiveCustomerModel hiveCustomerModel;
  final bool? isCustomer;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CartCubit>(
            create: (context) =>
                AppConfig.s1()..getCustomerCart(hiveCustomerModel.id!),
          ),
          BlocProvider<OrderSummaryCubit>(
            create: (context) => AppConfig.s1(),
          ),
          BlocProvider<OrderDetailsCubit>(
            create: (context) => AppConfig.s1(),
          )
        ],
        child: CartScreen(
          hiveCustomerModel: hiveCustomerModel,
          isCustomer: isCustomer ?? false,
        ));
  }
}
