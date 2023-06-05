import 'package:auto_route/auto_route.dart';
import 'package:distributor_app_flutter/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:distributor_app_flutter/features/product_list/presentation/bloc/product_list/product_list_cubit.dart';
import 'package:distributor_app_flutter/features/product_list/presentation/pages/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_config.dart';
import '../../../../core/data/local_storage/models/hive_customer_model.dart';

@RoutePage(name: 'ProductListRouter')
class ProductListWrapper extends StatelessWidget {
  const ProductListWrapper({Key? key,required this.hiveCustomerModel}) : super(key: key);

  final HiveCustomerModel hiveCustomerModel;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ProductListCubit>(
        create: (context) => AppConfig.s1(),
      ),
      BlocProvider<CartCubit>(
        create: (context) => AppConfig.s1(),
      )
    ], child: ProductListScreen(hiveCustomerModel: hiveCustomerModel,));
  }
}
