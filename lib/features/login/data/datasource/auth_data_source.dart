import 'package:dio/dio.dart';
import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';
import 'package:distributor_app_flutter/core/data/preference/shared_preference_data_source.dart';
import 'package:distributor_app_flutter/features/login/data/datasource/models/customer_login_response.dart';
import 'package:distributor_app_flutter/features/login/data/datasource/models/login_response.dart';
import 'package:flutter/foundation.dart';

import '../../../../app_config.dart';
import '../../../../core/data/preference/constants.dart';

abstract class AuthDataSource {
  Future<LoginResponse?> login(String username, String password);

  Future<CustomerLoginResponse?> customerLogin(
      String username, String password);

  Future<LoginResponse?> loginWithManufacture(
      String username, String password, int manufacture);

  Future<void> logout();

  Future<int?> isLoggedIn();

  Future<bool?> isCustomerUser();

  Future<void> saveLogin(LoginResponse loginResponse);

  Future<void> saveCustomerLogin(CustomerLoginResponse customerLoginResponse);

  Future<void> saveLoginWithManufacture(
      LoginResponse loginResponse, int manufactureId);
}

class AuthDataSourceImpl extends AuthDataSource {
  AuthDataSourceImpl(
      {required this.dio,
      required this.sharedPreferenceDataSource,
      required this.hiveDataSource});

  final Dio dio;
  final SharedPreferenceDataSource sharedPreferenceDataSource;
  final HiveDataSource hiveDataSource;

  @override
  Future<LoginResponse?> login(String username, String password) async {
    var response = await dio.get(AppConfig.instance.endPoint!.login,
        queryParameters: {'username': username, 'password': password});
    try {
      LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      debugPrint('Access Token: ${loginResponse.accessToken}');
      return loginResponse;
    } catch (exception) {
      debugPrint('Login Call: $exception');
    }
    return null;
  }

  @override
  Future<CustomerLoginResponse?> customerLogin(
      String username, String password) async {
    var response = await dio.get(AppConfig.instance.endPoint!.customerLogin,
        queryParameters: {'username': username, 'password': password});
    try {
      CustomerLoginResponse loginResponse =
          CustomerLoginResponse.fromJson(response.data);
      debugPrint('Access Token: ${loginResponse.accessToken}');
      return loginResponse;
    } catch (exception) {
      debugPrint('Login Call: $exception');
    }
    return null;
  }

  @override
  Future<LoginResponse?> loginWithManufacture(
      String username, String password, int manufacture) async {
    var response = await dio.get(AppConfig.instance.endPoint!.login,
        queryParameters: {
          'username': username,
          'password': password,
          'manufactureid': manufacture
        });
    try {
      LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      return loginResponse;
    } catch (exception) {
      debugPrint('Login Call: $exception');
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await sharedPreferenceDataSource.setInt(spUserId, -1);
    await sharedPreferenceDataSource.setString(spAccessToken, '');
    await sharedPreferenceDataSource.setBool(spIsLoggedIn, false);
    await sharedPreferenceDataSource.setInt(spManufactureId, -1);
    await sharedPreferenceDataSource.setInt(spCustomerId, -1);
    await sharedPreferenceDataSource.setBool(spHasProductDataSynced, false);
    await sharedPreferenceDataSource.setBool(spHasLocationDataSynced, false);
    await sharedPreferenceDataSource.setBool(spHasCustomerDataSynced, false);
    await sharedPreferenceDataSource.setInt(spSelectedCustomerId, -1);
    await hiveDataSource.clearAll();
    await hiveDataSource.deleteSelectedCustomer();
  }

  @override
  Future<int?> isLoggedIn() async {
    bool isLoggedIn = sharedPreferenceDataSource.getBool(spIsLoggedIn) ?? false;
    int? userId = sharedPreferenceDataSource.getInt(spUserId);
    int? customerId = sharedPreferenceDataSource.getInt(spCustomerId);
    if (isLoggedIn) {
      return (customerId??0)>0?customerId:userId;
    } else {
      return null;
    }
  }

  @override
  Future<void> saveLogin(LoginResponse loginResponse) async {
    await sharedPreferenceDataSource.setString(
        spAccessToken, loginResponse.accessToken ?? '');
    await sharedPreferenceDataSource.setInt(
        spUserId, loginResponse.salesmanId ?? -1);
    await sharedPreferenceDataSource.setBool(spIsLoggedIn, true);
  }

  @override
  Future<void> saveCustomerLogin(CustomerLoginResponse loginResponse) async {
    await sharedPreferenceDataSource.setString(
        spAccessToken, loginResponse.accessToken ?? '');
    await sharedPreferenceDataSource.setInt(spUserId, 0);
    await sharedPreferenceDataSource.setInt(
        spCustomerId, loginResponse.customerId ?? -1);
    await sharedPreferenceDataSource.setBool(spIsLoggedIn, true);
  }

  @override
  Future<void> saveLoginWithManufacture(
      LoginResponse loginResponse, int manufactureId) async {
    await sharedPreferenceDataSource.setString(
        spAccessToken, loginResponse.accessToken ?? '');
    await sharedPreferenceDataSource.setInt(
        spUserId, loginResponse.salesmanId ?? -1);
    await sharedPreferenceDataSource.setInt(spManufactureId, manufactureId);
    await sharedPreferenceDataSource.setBool(spIsLoggedIn, true);
  }

  @override
  Future<bool?> isCustomerUser() async {
    int? customerId = sharedPreferenceDataSource.getInt(spCustomerId);
    if((customerId??0) > 0){
      return true;
    }else{
      return false;
    }
  }
}
