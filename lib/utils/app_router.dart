import 'package:auto_route/auto_route.dart';
import 'package:distributor_app_flutter/features/landing_page/landing_wrapper.dart';
import 'package:distributor_app_flutter/utils/auth_guard.dart';
import 'package:flutter/material.dart';

import '../core/data/local_storage/models/hive_customer_model.dart';
import '../features/cart/presentation/pages/cart_wrapper.dart';
import '../features/customer_list/presentation/pages/customer_list_wrapper.dart';
import '../features/data_download/presentation/pages/data_download_wrapper.dart';
import '../features/failed_orders/presentation/pages/failed_order_item_list_wrapper.dart';
import '../features/failed_orders/presentation/pages/failed_orders_list_wrapper.dart';
import '../features/login/presentation/pages/customer/customer_login_wrapper.dart';
import '../features/login/presentation/pages/login_wrapper.dart';
import '../features/order_history/presentation/models/order_history.dart';
import '../features/order_history/presentation/pages/detail/order_history_detail_wrapper.dart';
import '../features/order_history/presentation/pages/order_history_wrapper.dart';
import '../features/orders_list/presentation/pages/order_item_list_wrapper.dart';
import '../features/orders_list/presentation/pages/orders_list_wrapper.dart';
import '../features/product_list/presentation/pages/product_list_wrapper.dart';
import '../features/sales_list/sales_item_list_wrapper.dart';
import '../features/sales_list/sales_list_wrapper.dart';
import '../features/splash/splash_wrapper.dart';
import 'routes.dart';

part 'app_router.gr.dart';

// extend the generated private router
@AutoRouterConfig(replaceInRouteName: 'Page, Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRouter.page, initial: true, path: splashRoute),
        AutoRoute(page: LoginRouter.page, path: loginRoute),
        AutoRoute(page: CustomerLoginRouter.page, path: customerLoginRoute),
        AutoRoute(page: LandingRouter.page, path: landingRoute),
        AutoRoute(
            page: DataDownloadRouter.page,
            path: dataDownloadRoute,
            guards: [AuthGuard()]),
        AutoRoute(
            page: CustomerListRouter.page,
            path: customerListRoute,
            guards: [AuthGuard()]),
        AutoRoute(
            page: ProductListRouter.page,
            path: productListRoute,
            guards: [AuthGuard()]),
        AutoRoute(
            page: CartRouter.page, path: cartRoute, guards: [AuthGuard()]),
        AutoRoute(
            page: SalesListRouter.page,
            path: salesListRoute,
            guards: [AuthGuard()]),
        AutoRoute(
            page: OrdersListRouter.page,
            path: orderListRoute,
            guards: [AuthGuard()]),
        AutoRoute(
            page: OrdersItemListRouter.page,
            path: orderItemListRoute,
            guards: [AuthGuard()]),
        AutoRoute(
            page: SalesItemListRouter.page,
            path: salesItemListRoute,
            guards: [AuthGuard()]),
        AutoRoute(
            page: FailedOrdersListRouter.page,
            path: failedOrdersListRoute,
            guards: [AuthGuard()]),
        AutoRoute(
            page: FailedOrdersItemListRouter.page,
            path: failedOrdersItemListRoute,
            guards: [AuthGuard()]),
        AutoRoute(
            page: OrderHistoryRouter.page,
            path: orderHistoryRoute,
            guards: [AuthGuard()]),
        AutoRoute(
            page: OrderHistoryDetailRouter.page,
            path: orderHistoryDetailRoute,
            guards: [AuthGuard()]),
      ];
}
