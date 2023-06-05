import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:distributor_app_flutter/core/data/interceptors/authenticated_api_interceptor.dart';
import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';
import 'package:distributor_app_flutter/core/data/preference/shared_preference_data_source.dart';
import 'package:distributor_app_flutter/features/cart/cart_injection_container.dart';
import 'package:distributor_app_flutter/features/data_download/data_injection_container.dart';
import 'package:distributor_app_flutter/features/login/auth_injection_container.dart';
import 'package:distributor_app_flutter/features/login/presentation/bloc/auth/auth_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/order_injection_container.dart';
import 'package:distributor_app_flutter/features/product_list/product_injection_container.dart';
import 'package:distributor_app_flutter/utils/constants.dart';
import 'package:distributor_app_flutter/utils/endpoints.dart';
import 'package:distributor_app_flutter/utils/strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'app_config.dart';
import 'firebase_options.dart';
import 'utils/app_router.dart';
import 'utils/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Setting AppConfig
  AppConfig.set(AppConfig.varsha);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  await Hive.initFlutter();
  await HiveDataSourceImpl.initHiveBoxes();
  await initDependencies();
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

Future<void> initDependencies() async {
  Dio dio = Dio()
    ..options.baseUrl = AppConfig.instance.endPoint!.baseUrl
    ..options.connectTimeout = Duration(milliseconds: Constants.connectTimeOut)
    ..options.receiveTimeout = Duration(milliseconds: Constants.receiveTimeOut)
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));

  AppConfig.s1.registerLazySingleton<HiveDataSource>(() => HiveDataSourceImpl());

  AppConfig.s1.registerLazySingleton<SharedPreferenceDataSource>(
      () => SharedPreferenceDataSourceImpl()..init());

  AppConfig.s1.registerLazySingleton<AuthenticatedApiInterceptor>(
      () => AuthenticatedApiInterceptor(sharedPreferenceDataSource: AppConfig.s1()));

  //Login
  AuthInjectionConateinr(dio: dio).initialize();

  //Data
  DataInjectionContainer(dio: dio).initialize();

  //Product List
  ProductInjectionContainer.initialize();

  //Cart
  CartInjectionContainer.initialize();

  //Order
  OrderInjectionContainer(dio: dio).initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AppConfig.s1(),
          )
        ],
        child: MaterialApp.router(
          title: 'Distributor App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          routerDelegate: AppConfig.appRouter.delegate(),
          routeInformationParser: AppConfig.appRouter.defaultRouteParser(),
        ));
  }
}
