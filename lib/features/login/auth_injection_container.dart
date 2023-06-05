import 'package:dio/dio.dart';
import 'package:distributor_app_flutter/features/login/data/datasource/manufacture_data_source.dart';
import 'package:distributor_app_flutter/features/login/data/repository/manufacture_repository_impl.dart';
import 'package:distributor_app_flutter/features/login/domain/repository/manufacture_repository.dart';
import 'package:distributor_app_flutter/features/login/domain/usecase/login_with_manufacture_use_case.dart';
import 'package:distributor_app_flutter/features/login/domain/usecase/manufacture_use_case.dart';
import 'package:distributor_app_flutter/features/login/presentation/bloc/manufacture/manufacture_cubit.dart';

import '../../app_config.dart';
import 'data/datasource/auth_data_source.dart';
import 'data/repository/auth_repository_impl.dart';
import 'domain/repository/auth_repository.dart';
import 'domain/usecase/is_logged_in_use_case.dart';
import 'domain/usecase/login_use_case.dart';
import 'domain/usecase/logout_use_case.dart';
import 'presentation/bloc/auth/auth_cubit.dart';

class AuthInjectionConateinr {
  AuthInjectionConateinr({required this.dio});

  final Dio dio;

  void initialize() {
    AppConfig.s1.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(
        dio: dio,
        sharedPreferenceDataSource: AppConfig.s1(),
        hiveDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(authDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(authRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<LogoutUseCase>(
        () => LogoutUseCase(authRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<IsLoggedInUseCase>(
        () => IsLoggedInUseCase(authRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<LoginWithManufactureUseCase>(
        () => LoginWithManufactureUseCase(authRepository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<AuthCubit>(
      () => AuthCubit(
          loginUseCase: AppConfig.s1(),
          logoutUseCase: AppConfig.s1(),
          isLoggedInUseCase: AppConfig.s1(),
          loginWithManufactureUseCase: AppConfig.s1()),
    );

    AppConfig.s1.registerLazySingleton<ManufactureDataSource>(() =>
        ManufactureDataSourceImpl(
            dio: dio,
            sharedPreferenceDataSource: AppConfig.s1(),
            hiveDataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<ManufactureRepository>(
        () => ManufactureRepositoryImpl(dataSource: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<ManufactureUseCase>(
        () => ManufactureUseCase(repository: AppConfig.s1()));
    AppConfig.s1.registerLazySingleton<ManufactureCubit>(
      () => ManufactureCubit(manufactureUseCase: AppConfig.s1()),
    );
  }
}
