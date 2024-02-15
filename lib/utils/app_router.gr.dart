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
    SplashRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashWrapper(),
      );
    },
    FailedOrdersListRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FailedOrdersListWrapper(),
      );
    },
    FailedOrdersItemListRouter.name: (routeData) {
      final args = routeData.argsAs<FailedOrdersItemListRouterArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FailedOrdersItemListWrapper(
          key: args.key,
          orderId: args.orderId,
        ),
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
          isCustomer: args.isCustomer,
        ),
      );
    },
    LandingRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LandingWrapper(),
      );
    },
    SalesListRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SalesListWrapper(),
      );
    },
    SalesItemListRouter.name: (routeData) {
      final args = routeData.argsAs<SalesItemListRouterArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SalesItemListWrapper(
          key: args.key,
          orderId: args.orderId,
        ),
      );
    },
    LoginRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginWrapper(),
      );
    },
    CustomerLoginRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CustomerLoginWrapper(),
      );
    },
    OrderHistoryRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrderHistoryWrapper(),
      );
    },
    OrderHistoryDetailRouter.name: (routeData) {
      final args = routeData.argsAs<OrderHistoryDetailRouterArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OrderHistoryDetailWrapper(
          key: args.key,
          orderHistory: args.orderHistory,
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
/// [FailedOrdersListWrapper]
class FailedOrdersListRouter extends PageRouteInfo<void> {
  const FailedOrdersListRouter({List<PageRouteInfo>? children})
      : super(
          FailedOrdersListRouter.name,
          initialChildren: children,
        );

  static const String name = 'FailedOrdersListRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FailedOrdersItemListWrapper]
class FailedOrdersItemListRouter
    extends PageRouteInfo<FailedOrdersItemListRouterArgs> {
  FailedOrdersItemListRouter({
    Key? key,
    required int orderId,
    List<PageRouteInfo>? children,
  }) : super(
          FailedOrdersItemListRouter.name,
          args: FailedOrdersItemListRouterArgs(
            key: key,
            orderId: orderId,
          ),
          initialChildren: children,
        );

  static const String name = 'FailedOrdersItemListRouter';

  static const PageInfo<FailedOrdersItemListRouterArgs> page =
      PageInfo<FailedOrdersItemListRouterArgs>(name);
}

class FailedOrdersItemListRouterArgs {
  const FailedOrdersItemListRouterArgs({
    this.key,
    required this.orderId,
  });

  final Key? key;

  final int orderId;

  @override
  String toString() {
    return 'FailedOrdersItemListRouterArgs{key: $key, orderId: $orderId}';
  }
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
    bool? isCustomer,
    List<PageRouteInfo>? children,
  }) : super(
          CartRouter.name,
          args: CartRouterArgs(
            key: key,
            hiveCustomerModel: hiveCustomerModel,
            isCustomer: isCustomer,
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
    this.isCustomer,
  });

  final Key? key;

  final HiveCustomerModel hiveCustomerModel;

  final bool? isCustomer;

  @override
  String toString() {
    return 'CartRouterArgs{key: $key, hiveCustomerModel: $hiveCustomerModel, isCustomer: $isCustomer}';
  }
}

/// generated route for
/// [LandingWrapper]
class LandingRouter extends PageRouteInfo<void> {
  const LandingRouter({List<PageRouteInfo>? children})
      : super(
          LandingRouter.name,
          initialChildren: children,
        );

  static const String name = 'LandingRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [SalesItemListWrapper]
class SalesItemListRouter extends PageRouteInfo<SalesItemListRouterArgs> {
  SalesItemListRouter({
    Key? key,
    required int orderId,
    List<PageRouteInfo>? children,
  }) : super(
          SalesItemListRouter.name,
          args: SalesItemListRouterArgs(
            key: key,
            orderId: orderId,
          ),
          initialChildren: children,
        );

  static const String name = 'SalesItemListRouter';

  static const PageInfo<SalesItemListRouterArgs> page =
      PageInfo<SalesItemListRouterArgs>(name);
}

class SalesItemListRouterArgs {
  const SalesItemListRouterArgs({
    this.key,
    required this.orderId,
  });

  final Key? key;

  final int orderId;

  @override
  String toString() {
    return 'SalesItemListRouterArgs{key: $key, orderId: $orderId}';
  }
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
/// [CustomerLoginWrapper]
class CustomerLoginRouter extends PageRouteInfo<void> {
  const CustomerLoginRouter({List<PageRouteInfo>? children})
      : super(
          CustomerLoginRouter.name,
          initialChildren: children,
        );

  static const String name = 'CustomerLoginRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OrderHistoryWrapper]
class OrderHistoryRouter extends PageRouteInfo<void> {
  const OrderHistoryRouter({List<PageRouteInfo>? children})
      : super(
          OrderHistoryRouter.name,
          initialChildren: children,
        );

  static const String name = 'OrderHistoryRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OrderHistoryDetailWrapper]
class OrderHistoryDetailRouter
    extends PageRouteInfo<OrderHistoryDetailRouterArgs> {
  OrderHistoryDetailRouter({
    Key? key,
    required OrderHistory orderHistory,
    List<PageRouteInfo>? children,
  }) : super(
          OrderHistoryDetailRouter.name,
          args: OrderHistoryDetailRouterArgs(
            key: key,
            orderHistory: orderHistory,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderHistoryDetailRouter';

  static const PageInfo<OrderHistoryDetailRouterArgs> page =
      PageInfo<OrderHistoryDetailRouterArgs>(name);
}

class OrderHistoryDetailRouterArgs {
  const OrderHistoryDetailRouterArgs({
    this.key,
    required this.orderHistory,
  });

  final Key? key;

  final OrderHistory orderHistory;

  @override
  String toString() {
    return 'OrderHistoryDetailRouterArgs{key: $key, orderHistory: $orderHistory}';
  }
}
