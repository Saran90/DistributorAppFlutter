import 'package:dio/dio.dart';
import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_location_model.dart';
import 'package:distributor_app_flutter/core/data/preference/constants.dart';
import 'package:distributor_app_flutter/core/data/preference/shared_preference_data_source.dart';
import 'package:distributor_app_flutter/utils/endpoints.dart';
import 'package:flutter/foundation.dart';

import '../../../../app_config.dart';
import 'models/location_data_response.dart';

abstract class LocationDataDataSource {
  Future<List<HiveLocationModel>?> getLocations();
}

class LocationDataDataSourceImpl extends LocationDataDataSource {
  LocationDataDataSourceImpl(
      {required this.dio,
      required this.hiveDataSource,
      required this.sharedPreferenceDataSource});

  final Dio dio;
  final HiveDataSource hiveDataSource;
  final SharedPreferenceDataSource sharedPreferenceDataSource;

  @override
  Future<List<HiveLocationModel>?> getLocations() async {
    try {
      var response = await dio.get(AppConfig.instance.endPoint!.locations,);
      LocationDataResponse locationsDataResponse =
          LocationDataResponse.fromJson(response.data);
      List<HiveLocationModel> hiveLocationModels =
          _getHiveLocationsModels(locationsDataResponse);
      await _storeLocations(hiveLocationModels);
      await sharedPreferenceDataSource.setBool(spHasLocationDataSynced, true);
      return hiveLocationModels;
    } catch (exception) {
      debugPrint('Locations Call: $exception');
    }
    return null;
  }

  HiveLocationModel _getHiveLocationModel(AllCustomerLocation locations) {
    return HiveLocationModel(
      text: locations.location
    );
  }

  List<HiveLocationModel> _getHiveLocationsModels(
      LocationDataResponse locationDataResponse) {
    List<HiveLocationModel> hiveLocationModels = [];
    if (locationDataResponse.allCustomerLocation != null) {
      for (int i = 0; i < locationDataResponse.allCustomerLocation!.length; i++) {
        HiveLocationModel hiveLocationModel =
            _getHiveLocationModel(locationDataResponse.allCustomerLocation![i]);
        hiveLocationModels.add(hiveLocationModel);
      }
    }
    return hiveLocationModels;
  }

  Future<void> _storeLocations(List<HiveLocationModel> hiveLocationModels) async {
    await hiveDataSource.deleteAllLocations();
    for (int i = 0; i < hiveLocationModels.length; i++) {
      await hiveDataSource.addLocation(hiveLocationModels[i]);
    }
  }
}
