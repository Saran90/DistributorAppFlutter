// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    OrdersListRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrdersListWrapper(),
      );
    },
    SplashRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashWrapper(),
      );
    },
    CustomerListRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CustomerListWrapper(),
      );
    },
    DataDownloadRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DataDownloadWrapper(),
      );
    },
    ProductListRouter.name: (routeData) {
      final args = routeData.argsAs<ProductListRouterArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductListWrapper(
          key: args.key,
          hiveCustomerModel: args.hiveCustomerModel,
        ),
      );
    },
    CartRouter.name: (routeData) {
      final args = routeData.argsAs<CartRouterArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CartWrapper(
          key: args.key,
          hiveCustomerModel: args.hiveCustomerModel,
        ),
      );
    },
    SalesListRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SalesListWrapper(),
      );
    },
    LoginRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginWrapper(),
      );
    },
    OrdersItemListRouter.name: (routeData) {
      final args = routeData.argsAs<OrdersItemListRouterArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OrdersItemListWrapper(
          key: args.key,
          orderId: args.orderId,
        ),
      );
    },
  };
}

/// generated route for
/// [OrdersListWrapper]
class OrdersListRouter extends PageRouteInfo<void> {
  const OrdersListRouter({List<PageRouteInfo>? children})
      : super(
          OrdersListRouter.name,
          initialChildren: children,
        );

  static const String name = 'OrdersListRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashWrapper]
class SplashRouter extends PageRouteInfo<void> {
  const SplashRouter({List<PageRouteInfo>? children})
      : super(
          SplashRouter.name,
          initialChildren: children,
        );

  static const String name = 'SplashRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CustomerListWrapper]
class CustomerListRouter extends PageRouteInfo<void> {
  const CustomerListRouter({List<PageRouteInfo>? children})
      : super(
          CustomerListRouter.name,
          initialChildren: children,
        );

  static const String name = 'CustomerListRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DataDownloadWrapper]
class DataDownloadRouter extends PageRouteInfo<void> {
  const DataDownloadRouter({List<PageRouteInfo>? children})
      : super(
          DataDownloadRouter.name,
          initialChildren: children,
        );

  static const String name = 'DataDownloadRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProductListWrapper]
class ProductListRouter extends PageRouteInfo<ProductListRouterArgs> {
  ProductListRouter({
    Key? key,
    required HiveCustomerModel hiveCustomerModel,
    List<PageRouteInfo>? children,
  }) : super(
          ProductListRouter.name,
          args: ProductListRouterArgs(
            key: key,
            hiveCustomerModel: hiveCustomerModel,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductListRouter';

  static const PageInfo<ProductListRouterArgs> page =
      PageInfo<ProductListRouterArgs>(name);
}

class ProductListRouterArgs {
  const ProductListRouterArgs({
    this.key,
    required this.hiveCustomerModel,
  });

  final Key? key;

  final HiveCustomerModel hiveCustomerModel;

  @override
  String toString() {
    return 'ProductListRouterArgs{key: $key, hiveCustomerModel: $hiveCustomerModel}';
  }
}

/// generated route for
/// [CartWrapper]
class CartRouter extends PageRouteInfo<CartRouterArgs> {
  CartRouter({
    Key? key,
    required HiveCustomerModel hiveCustomerModel,
    List<PageRouteInfo>? children,
  }) : super(
          CartRouter.name,
          args: CartRouterArgs(
            key: key,
            hiveCustomerModel: hiveCustomerModel,
          ),
          initialChildren: children,
        );

  static const String name = 'CartRouter';

  static const PageInfo<CartRouterArgs> page = PageInfo<CartRouterArgs>(name);
}

class CartRouterArgs {
  const CartRouterArgs({
    this.key,
    required this.hiveCustomerModel,
  });

  final Key? key;

  final HiveCustomerModel hiveCustomerModel;

  @override
  String toString() {
    return 'CartRouterArgs{key: $key, hiveCustomerModel: $hiveCustomerModel}';
  }
}

/// generated route for
/// [SalesListWrapper]
class SalesListRouter extends PageRouteInfo<void> {
  const SalesListRouter({List<PageRouteInfo>? children})
      : super(
          SalesListRouter.name,
          initialChildren: children,
        );

  static const String name = 'SalesListRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginWrapper]
class LoginRouter extends PageRouteInfo<void> {
  const LoginRouter({List<PageRouteInfo>? children})
      : super(
          LoginRouter.name,
          initialChildren: children,
        );

  static const String name = 'LoginRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OrdersItemListWrapper]
class OrdersItemListRouter extends PageRouteInfo<OrdersItemListRouterArgs> {
  OrdersItemListRouter({
    Key? key,
    required int orderId,
    List<PageRouteInfo>? children,
  }) : super(
          OrdersItemListRouter.name,
          args: OrdersItemListRouterArgs(
            key: key,
            orderId: orderId,
          ),
          initialChildren: children,
        );

  static const String name = 'OrdersItemListRouter';

  static const PageInfo<OrdersItemListRouterArgs> page =
      PageInfo<OrdersItemListRouterArgs>(name);
}

class OrdersItemListRouterArgs {
  const OrdersItemListRouterArgs({
    this.key,
    required this.orderId,
  });

  final Key? key;

  final int orderId;

  @override
  String toString() {
    return 'OrdersItemListRouterArgs{key: $key, orderId: $orderId}';
  }
}
