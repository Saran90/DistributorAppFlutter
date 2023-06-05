import 'package:distributor_app_flutter/utils/app_router.dart';
import 'package:distributor_app_flutter/utils/endpoints_cochin_distributor.dart';
import 'package:get_it/get_it.dart';

import 'utils/endpoints.dart';
import 'utils/endpoints_varsha.dart';
import 'utils/strings.dart';

class AppConfig {
  final String? appName;
  final String? flavor;
  final String? logo;
  final EndPoint? endPoint;
  static AppRouter appRouter = AppRouter();
  static GetIt s1 = GetIt.instance;

  /// Private constructor
  AppConfig._internal(this.appName, this.flavor, this.endPoint, this.logo);

  /// Internal instance of AppConfig
  static AppConfig? _instance;

  /// Instance of AppConfig
  static AppConfig get instance {
    _instance ??= AppConfig();

    return _instance!;
  }

  /// Set Instance of AppConfig
  static void set(AppConfig appConfig) {
    _instance ??= appConfig;
  }

  /// Factory constructor
  factory AppConfig(
      {String? appName, String? flavor, EndPoint? endPoint, String? logo}) {
    _instance = AppConfig._internal(appName, flavor, endPoint, logo);

    return _instance!;
  }

  static AppConfig cochinDistributor = AppConfig(
      flavor: AppFlavor.cochinDistributor.name,
      appName: appNameCochinDistributor,
      endPoint: EndPointCochinDistributors(),
      logo: 'assets/images/cochin_distributors_logo.png');

  static AppConfig varsha = AppConfig(
      flavor: AppFlavor.varsha.name,
      appName: appNameVarsha,
      endPoint: EndPointVarsha(),
      logo: 'assets/images/varsha_logo.jpg');
}

enum AppFlavor { cochinDistributor, varsha }
