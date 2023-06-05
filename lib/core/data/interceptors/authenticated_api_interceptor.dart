import 'dart:async';

import 'package:dio/dio.dart';
import 'package:distributor_app_flutter/core/data/preference/constants.dart';
import 'package:distributor_app_flutter/core/data/preference/shared_preference_data_source.dart';

class AuthenticatedApiInterceptor extends Interceptor {
  AuthenticatedApiInterceptor({required this.sharedPreferenceDataSource});

  final SharedPreferenceDataSource sharedPreferenceDataSource;

  @override
  FutureOr<dynamic> onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var accessToken = sharedPreferenceDataSource.getString(spAccessToken);

    options.headers['Authorization'] = 'Bearer $accessToken}';
    // options.headers.addAll({"Authorization": "Bearer $accessToken}"});
    return options;
  }
}
