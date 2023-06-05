import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';

abstract class IsDataAvailableDataSource {
  Future<bool> isDataAvailable();
}

class IsDataAvailableDataSourceImpl extends IsDataAvailableDataSource {
  IsDataAvailableDataSourceImpl({
    required this.hiveDataSource,
  });

  final HiveDataSource hiveDataSource;

  @override
  Future<bool> isDataAvailable() {
    return hiveDataSource.isDataAvailable();
  }
}
