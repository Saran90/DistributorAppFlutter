import 'package:dio/dio.dart';
import 'package:distributor_app_flutter/core/data/interceptors/authenticated_api_interceptor.dart';
import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';
import 'package:distributor_app_flutter/core/data/preference/shared_preference_data_source.dart';
import 'package:distributor_app_flutter/features/cart/cart_injection_container.dart';
import 'package:distributor_app_flutter/features/data_download/data_injection_container.dart';
import 'package:distributor_app_flutter/features/login/auth_injection_container.dart';
import 'package:distributor_app_flutter/features/login/presentation/bloc/auth/auth_cubit.dart';
import 'package:distributor_app_flutter/features/login/presentation/bloc/manufacture/manufacture_cubit.dart';
import 'package:distributor_app_flutter/features/order_history/order_history_injector.dart';
import 'package:distributor_app_flutter/features/orders_list/order_injection_container.dart';
import 'package:distributor_app_flutter/features/product_list/product_injection_container.dart';
import 'package:distributor_app_flutter/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'app_config.dart';
import 'firebase_options.dart';
import 'utils/bloc_observer.dart';

Future<void> main() async {
  BindingBase.debugZoneErrorsAreFatal = true;
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
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

Future<void> initDependencies() async {
  AppConfig.s1.registerLazySingleton<SharedPreferenceDataSource>(
      () => SharedPreferenceDataSourceImpl()..init());

  Dio dio = Dio()
    ..options.baseUrl = AppConfig.instance.endPoint!.baseUrl
    ..options.connectTimeout = Duration(milliseconds: Constants.connectTimeOut)
    ..options.receiveTimeout = Duration(milliseconds: Constants.receiveTimeOut)
    ..interceptors.addAll([
      PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90)
    ]);

  AppConfig.s1
      .registerLazySingleton<HiveDataSource>(() => HiveDataSourceImpl());

  //Login
  AuthInjectionConateinr(
          dio: Dio()
            ..options.baseUrl = AppConfig.instance.endPoint!.baseUrl
            ..options.connectTimeout =
                Duration(milliseconds: Constants.connectTimeOut)
            ..options.receiveTimeout =
                Duration(milliseconds: Constants.receiveTimeOut)
            ..interceptors.add(PrettyDioLogger(
                requestHeader: true,
                requestBody: true,
                responseBody: true,
                responseHeader: false,
                error: true,
                compact: true,
                maxWidth: 90)))
      .initialize();

  //Data
  DataInjectionContainer(
          dio: dio
            ..interceptors.addAll([
              AuthenticatedApiInterceptor(
                  sharedPreferenceDataSource: AppConfig.s1(),
                  authCubit: AppConfig.s1())
            ]))
      .initialize();

  //Product List
  ProductInjectionContainer.initialize();

  //Cart
  CartInjectionContainer.initialize();

  //Order
  OrderInjectionContainer(
          dio: dio
            ..interceptors.addAll([
              AuthenticatedApiInterceptor(
                  sharedPreferenceDataSource: AppConfig.s1(),
                  authCubit: AppConfig.s1())
            ]))
      .initialize();

  //Order History
  OrderHistoryInjector(
          dio: dio
            ..interceptors.addAll([
              AuthenticatedApiInterceptor(
                  sharedPreferenceDataSource: AppConfig.s1(),
                  authCubit: AppConfig.s1())
            ]))
      .initialize();
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
          ),
          BlocProvider<ManufactureCubit>(
            create: (context) => AppConfig.s1(),
          )
        ],
        child: MaterialApp.router(
          title: 'Distributor App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          routerDelegate: AppConfig.appRouter.delegate(),
          routeInformationParser: AppConfig.appRouter.defaultRouteParser(),
        ));
  }
}
