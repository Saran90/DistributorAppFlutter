import 'package:auto_route/auto_route.dart';
import 'package:distributor_app_flutter/app_config.dart';
import 'package:distributor_app_flutter/features/login/presentation/bloc/manufacture/manufacture_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen.dart';

@RoutePage(name: 'LoginRouter')
class LoginWrapper extends StatelessWidget {
  const LoginWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ManufactureCubit>(
        create: (context) => AppConfig.s1(),
      )
    ], child: const LoginScreen());
  }
}
