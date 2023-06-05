import 'package:auto_route/auto_route.dart';
import 'package:distributor_app_flutter/features/data_download/presentation/bloc/customer_data/customer_data_cubit.dart';
import 'package:distributor_app_flutter/features/data_download/presentation/bloc/location_data/location_data_cubit.dart';
import 'package:distributor_app_flutter/features/data_download/presentation/pages/data_download_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_config.dart';
import '../bloc/product_data/product_data_cubit.dart';

@RoutePage(name: 'DataDownloadRouter')
class DataDownloadWrapper extends StatelessWidget {
  const DataDownloadWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ProductDataCubit>(
        create: (context) => AppConfig.s1(),
      ),
      BlocProvider<CustomerDataCubit>(
        create: (context) => AppConfig.s1(),
      ),
      BlocProvider<LocationDataCubit>(
        create: (context) => AppConfig.s1(),
      )
    ], child: const DataDownloadScreen());
  }
}
