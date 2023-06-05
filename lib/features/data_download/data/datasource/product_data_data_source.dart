import 'package:dio/dio.dart';
import 'package:distributor_app_flutter/core/data/local_storage/hive_data_source.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_product_model.dart';
import 'package:distributor_app_flutter/core/data/preference/constants.dart';
import 'package:distributor_app_flutter/core/data/preference/shared_preference_data_source.dart';
import 'package:distributor_app_flutter/features/data_download/data/datasource/models/products_data_response.dart';
import 'package:distributor_app_flutter/utils/endpoints.dart';
import 'package:flutter/foundation.dart';

import '../../../../app_config.dart';

abstract class ProductDataDataSource {
  Future<List<HiveProductModel>?> getProducts(String name);
}

class ProductDataDataSourceImpl extends ProductDataDataSource {
  ProductDataDataSourceImpl(
      {required this.dio,
      required this.hiveDataSource,
      required this.sharedPreferenceDataSource});

  final Dio dio;
  final HiveDataSource hiveDataSource;
  final SharedPreferenceDataSource sharedPreferenceDataSource;

  @override
  Future<List<HiveProductModel>?> getProducts(String name) async {
    try {
      var response = await dio.get(AppConfig.instance.endPoint!.products,
          queryParameters: {'Name': name},
          options: Options(headers: {
            'Authorization':
                'Bearer ${sharedPreferenceDataSource.getString(spAccessToken)}'
          }));
      ProductsDataResponse productsDataResponse =
          ProductsDataResponse.fromJson(response.data);
      List<HiveProductModel> hiveProductModels =
          _getHiveProductsModels(productsDataResponse);
      await _storeProducts(hiveProductModels);
      return hiveProductModels;
    } catch (exception) {
      debugPrint('Products Call: $exception');
    }
    return null;
  }

  HiveProductModel _getHiveProductModel(Products products) {
    return HiveProductModel(
        name: products.name,
        id: products.id,
        category: products.category,
        image: products.imageName,
        mrp: products.mrp,
        rate: products.rate,
        stock: products.stock,
        unit: products.unit,
        status: products.status,
        quantity: 0.0,
        total: 0.0);
  }

  List<HiveProductModel> _getHiveProductsModels(
      ProductsDataResponse productsDataResponse) {
    List<HiveProductModel> hiveProductModels = [];
    if (productsDataResponse.products != null) {
      for (int i = 0; i < productsDataResponse.products!.length; i++) {
        HiveProductModel hiveProductModel =
            _getHiveProductModel(productsDataResponse.products![i]);
        hiveProductModels.add(hiveProductModel);
      }
    }
    return hiveProductModels;
  }

  Future<void> _storeProducts(List<HiveProductModel> hiveProductModels) async {
    await hiveDataSource.deleteAllProducts();
    for (int i = 0; i < hiveProductModels.length; i++) {
      await hiveDataSource.addProduct(hiveProductModels[i]);
    }
  }
}
