import 'package:auto_route/auto_route.dart';
import 'package:distributor_app_flutter/features/data_download/presentation/bloc/is_data_available/data_download_cubit.dart';
import 'package:distributor_app_flutter/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_config.dart';

@RoutePage(name: 'SplashRouter')
class SplashWrapper extends StatelessWidget {
  const SplashWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<DataDownloadCubit>(
        create: (context) => AppConfig.s1()..isDataAvailable(),
      )
    ], child: const SplashScreen());
  }
}
