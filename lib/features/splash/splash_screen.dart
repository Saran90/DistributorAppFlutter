import 'dart:async';

import 'package:distributor_app_flutter/app_config.dart';
import 'package:distributor_app_flutter/features/data_download/presentation/bloc/is_data_available/data_download_cubit.dart';
import 'package:distributor_app_flutter/features/login/presentation/bloc/auth/auth_cubit.dart';
import 'package:distributor_app_flutter/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final int timerDurationInSec = 2;

  @override
  void initState() {
    context.read<AuthCubit>().isLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            _backgroundImage(),
            _content(),
            BlocConsumer<AuthCubit, AuthState>(
              builder: (context, state) => Container(),
              listener: (context, state) {
                if (state is Authenticated) {
                  context.read<DataDownloadCubit>().isDataAvailable();
                }
                if (state is UnAuthenticated) {
                  Timer(Duration(seconds: timerDurationInSec), () {
                    if (mounted) {
                      if (AppConfig.instance.flavor ==
                          AppFlavor.varsha.name) {
                        //Navigate to Landing page
                        AppConfig.appRouter.replace(const LandingRouter());
                      } else {
                        AppConfig.appRouter.replace(const LoginRouter());
                      }
                    }
                  });
                }
              },
            ),
            BlocConsumer<DataDownloadCubit, DataDownloadState>(
              builder: (context, state) => Container(),
              listener: (context, state) {
                if (state is DataNotAvailable) {
                  Timer(Duration(seconds: timerDurationInSec), () {
                    if (mounted) {
                      AppConfig.appRouter.replace(const DataDownloadRouter());
                    }
                  });
                }
                if (state is DataAvailable) {
                  Timer(Duration(seconds: timerDurationInSec), () {
                    if (mounted) {
                      AppConfig.appRouter.replace(const CustomerListRouter());
                    }
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _backgroundImage() {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          'assets/images/background.png',
          fit: BoxFit.cover,
        ));
  }

  Widget _content() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_iconWidget(), _appNameWidget()],
      ),
    );
  }

  Widget _iconWidget() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage(AppConfig.instance.logo!))),
    );
  }

  Widget _appNameWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        AppConfig.instance.appName!.toUpperCase().replaceAll(' ', '\n'),
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
            height: 1.5),
        textAlign: TextAlign.center,
      ),
    );
  }
}
