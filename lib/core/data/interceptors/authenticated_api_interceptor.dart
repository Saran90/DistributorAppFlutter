import 'dart:async';

import 'package:dio/dio.dart';
import 'package:distributor_app_flutter/app_config.dart';
import 'package:distributor_app_flutter/core/data/preference/constants.dart';
import 'package:distributor_app_flutter/core/data/preference/shared_preference_data_source.dart';
import 'package:distributor_app_flutter/features/login/presentation/bloc/auth/auth_cubit.dart';
import 'package:distributor_app_flutter/utils/app_router.dart';
import 'package:flutter/cupertino.dart';

class AuthenticatedApiInterceptor extends Interceptor {
  AuthenticatedApiInterceptor({required this.sharedPreferenceDataSource,required this.authCubit});

  final SharedPreferenceDataSource sharedPreferenceDataSource;
  final AuthCubit authCubit;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var accessToken = sharedPreferenceDataSource.getString(spAccessToken);
    debugPrint('Interceptor Access Token: $accessToken');
    if(accessToken!=null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    // options.headers.addAll({"Authorization": "Bearer $accessToken}"});
    return handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    debugPrint('Interceptor Access Token: ${err.requestOptions.headers['Authorization']}');
    if (err.response?.statusCode == 401) {
      await authCubit.logout();
      AppConfig.appRouter.replaceAll([
        const LoginRouter()
      ]);
    }
  }
}
