import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';
import 'package:distributor_app_flutter/core/data/preference/shared_preference_data_source.dart';
import 'package:distributor_app_flutter/features/login/data/datasource/models/manufacture_list_response.dart';
import 'package:flutter/foundation.dart';

import '../../../../app_config.dart';

abstract class ManufactureDataSource {
  Future<List<ManufactureListResponse>?> getManufactures();
}

class ManufactureDataSourceImpl extends ManufactureDataSource {
  ManufactureDataSourceImpl(
      {required this.dio,
      required this.sharedPreferenceDataSource,
      required this.hiveDataSource});

  final Dio dio;
  final SharedPreferenceDataSource sharedPreferenceDataSource;
  final HiveDataSource hiveDataSource;

  @override
  Future<List<ManufactureListResponse>?> getManufactures() async {
    var response = await dio.get(AppConfig.instance.endPoint!.manufactureList);
    try {
      debugPrint('Manufacture Response: ${response.data}');
      List<dynamic> list = response.data as List<dynamic>;
      List<ManufactureListResponse> manufactureListResponse =
          list.map((e) => ManufactureListResponse.fromJson(e)).toList();
      return manufactureListResponse;
    } catch (exception) {
      debugPrint('Manufacture List Call: $exception');
    }
    return null;
  }
}
