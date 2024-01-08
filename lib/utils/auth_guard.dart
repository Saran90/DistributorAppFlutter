import 'package:auto_route/auto_route.dart';
import 'package:distributor_app_flutter/app_config.dart';
import 'package:distributor_app_flutter/features/login/presentation/bloc/auth/auth_cubit.dart';

import 'app_router.dart';
import 'routes.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final authState = AppConfig.s1<AuthCubit>().state;
    if(authState is Authenticated){
      resolver.next(true);
    }else{
      if (AppConfig.instance.flavor ==
          AppFlavor.varsha.name) {
        //Navigate to Landing page
        AppConfig.appRouter.replace(const LandingRouter());
      } else {
        AppConfig.appRouter.replace(const LoginRouter());
      }
    }
  }
}