import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';

import '../../../../core/data/local_storage/models/hive_location_model.dart';

abstract class LocationListDataSource {
  Future<List<HiveLocationModel>?> getLocations();
}

class LocationListDataSourceImpl extends LocationListDataSource {
  LocationListDataSourceImpl({required this.hiveDataSource});

  final HiveDataSource hiveDataSource;

  @override
  Future<List<HiveLocationModel>?> getLocations() async {
    return hiveDataSource.getAllLocations();
  }
}
