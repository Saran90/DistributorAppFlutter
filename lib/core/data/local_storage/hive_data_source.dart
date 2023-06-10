import 'package:distributor_app_flutter/core/data/local_storage/models/hive_cart_model.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_customer_model.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_location_model.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_details_model.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_summary_model.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_product_model.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_user_model.dart';
import 'package:hive/hive.dart';

abstract class HiveDataSource {
  Future<int?> addCustomer(HiveCustomerModel hiveCustomerModel);

  Future<void> updateCustomer(HiveCustomerModel hiveCustomerModel);

  HiveCustomerModel? getCustomer(int id);

  List<HiveCustomerModel>? getAllCustomers();

  List<HiveCustomerModel>? getAllFilteredCustomer(
      String search, String location);

  Future<void> deleteCustomer(HiveCustomerModel hiveCustomerModel);

  Future<int?> deleteAllCustomers();

  Future<void> addProduct(HiveProductModel hiveProductModel);

  Future<void> updateProduct(HiveProductModel hiveProductModel);

  HiveProductModel? getProduct(int id);

  List<HiveProductModel>? getAllProducts();

  List<HiveProductModel>? getFilteredProducts(String search);

  Future<void> deleteProduct(HiveProductModel hiveProductModel);

  Future<int?> deleteAllProducts();

  Future<int?> addLocation(HiveLocationModel hiveLocationModel);

  Future<void> updateLocation(HiveLocationModel hiveLocationModel);

  HiveLocationModel? getLocation(int id);

  List<HiveLocationModel>? getAllLocations();

  Future<void> deleteLocation(HiveLocationModel hiveLocationModel);

  Future<int?> deleteAllLocations();

  Future<void> addCart(HiveCartModel hiveCartModel);

  Future<void> updateCart(HiveCartModel hiveCartModel);

  HiveCartModel? getCartProduct(int productId, int customerId);

  List<HiveCartModel>? getCustomerCart(int customerId);

  Future<void> deleteCustomerCart(int customerId);

  Future<void>? deleteCustomerCartItem(HiveCartModel hiveCartModel);

  Future<void> deleteAllCart();

  Future<void> clearAll();

  Future<bool> isDataAvailable();

  Future<HiveOrderSummaryModel> addOrderSummary(
      HiveOrderSummaryModel hiveOrderSummaryModel);

  Future<void> deleteOrderSummary(HiveOrderSummaryModel hiveOrderSummaryModel);

  Future<void> deleteOrderSummaryByCustomer(int customerId);

  Future<int?> deleteAllOrderSummaries();

  Future<List<HiveOrderSummaryModel>?> getOrderSummariesByCustomer(
      int customerId);

  Future<List<HiveOrderSummaryModel>?> getAllOrderSummaries();

  Future<List<HiveOrderSummaryModel>?> getAllFailedOrderSummaries();

  Future<List<HiveOrderSummaryModel>?> getAllUnSendOrderSummaries();

  Future<HiveOrderSummaryModel?> getOrderSummaryById(int orderId);

  Future<void> updateOrderSummary(HiveOrderSummaryModel hiveOrderSummaryModel);

  Future<void> updateOrderSummaryStatus(int orderId, int status);

  Future<int> addOrderDetails(
      List<HiveOrderDetailsModel> hiveOrderDetailsModels);

  Future<List<HiveOrderDetailsModel>?> getAllOrderDetailsByOrder(int orderId);

  Future<void> deleteOrderDetailsForOrder(int orderId);

  Future<int?> deleteAllOrderDetails();

  Future<void> updateOrderDetailStatus(int orderId, int status);
}

class HiveDataSourceImpl extends HiveDataSource {
  static Box<HiveUserModel>? userBox;
  static Box<HiveCustomerModel>? customerBox;
  static Box<HiveProductModel>? productBox;
  static Box<HiveLocationModel>? locationBox;
  static Box<HiveOrderDetailsModel>? orderDetailsBox;
  static Box<HiveOrderSummaryModel>? orderSummaryBox;
  static Box<HiveCartModel>? cartBox;

  static initHiveBoxes() async {
    Hive.registerAdapter(HiveUserModelAdapter());
    Hive.registerAdapter(HiveCustomerModelAdapter());
    Hive.registerAdapter(HiveLocationModelAdapter());
    Hive.registerAdapter(HiveProductModelAdapter());
    Hive.registerAdapter(HiveOrderDetailsModelAdapter());
    Hive.registerAdapter(HiveOrderSummaryModelAdapter());
    Hive.registerAdapter(HiveCartModelAdapter());
    userBox = await Hive.openBox("userBox");
    customerBox = await Hive.openBox("customerBox");
    locationBox = await Hive.openBox("locationBox");
    productBox = await Hive.openBox("productBox");
    orderDetailsBox = await Hive.openBox("orderDetailsBox");
    orderSummaryBox = await Hive.openBox("orderSummaryBox");
    cartBox = await Hive.openBox("cartBox");
  }

  @override
  Future<int?> addCustomer(HiveCustomerModel hiveCustomerModel) async {
    return await customerBox?.add(hiveCustomerModel);
  }

  @override
  Future<void> updateCustomer(HiveCustomerModel hiveCustomerModel) async {
    return await customerBox?.put(hiveCustomerModel.key, hiveCustomerModel);
  }

  @override
  Future<void> deleteCustomer(HiveCustomerModel hiveCustomerModel) async {
    return await customerBox?.delete(hiveCustomerModel.key);
  }

  @override
  HiveCustomerModel? getCustomer(int key) {
    return customerBox?.get(key);
  }

  @override
  List<HiveCustomerModel>? getAllCustomers() {
    return customerBox?.values.toList();
  }

  @override
  List<HiveCustomerModel>? getAllFilteredCustomer(
      String search, String location) {
    List<HiveCustomerModel>? customers = customerBox?.values.toList();
    if (customers != null) {
      if (search.isNotEmpty) {
        customers = customers
            .where((element) =>
                element.name!.toLowerCase().startsWith(search.toLowerCase()))
            .toList();
      }
      if (location.isNotEmpty) {
        customers = customers
            .where((element) =>
                element.location!.toLowerCase() == location.toLowerCase())
            .toList();
      }
    }
    return customers;
  }

  @override
  Future<void> addProduct(HiveProductModel hiveProductModel) async {
    return await productBox?.put(
        hiveProductModel.name!.hashCode.toString(), hiveProductModel);
  }

  @override
  Future<void> updateProduct(HiveProductModel hiveProductModel) async {
    return await productBox?.put(
        hiveProductModel.name!.hashCode.toString(), hiveProductModel);
  }

  @override
  Future<void> deleteProduct(HiveProductModel hiveProductModel) async {
    return await productBox?.delete(hiveProductModel.key);
  }

  @override
  HiveProductModel? getProduct(int key) {
    return productBox?.get(key);
  }

  @override
  List<HiveProductModel>? getAllProducts() {
    return productBox?.values.toList();
  }

  @override
  Future<int?> addLocation(HiveLocationModel hiveLocationModel) async {
    return await locationBox?.add(hiveLocationModel);
  }

  @override
  Future<void> updateLocation(HiveLocationModel hiveLocationModel) async {
    return await locationBox?.put(hiveLocationModel.key, hiveLocationModel);
  }

  @override
  Future<void> deleteLocation(HiveLocationModel hiveLocationModel) async {
    return await locationBox?.delete(hiveLocationModel.key);
  }

  @override
  HiveLocationModel? getLocation(int key) {
    return locationBox?.get(key);
  }

  @override
  List<HiveLocationModel>? getAllLocations() {
    return locationBox?.values.toList();
  }

  @override
  Future<int?> deleteAllCustomers() async {
    return await customerBox?.clear();
  }

  @override
  Future<int?> deleteAllLocations() async {
    return await locationBox?.clear();
  }

  @override
  Future<int?> deleteAllProducts() async {
    return await productBox?.clear();
  }

  @override
  List<HiveProductModel>? getFilteredProducts(String search) {
    List<HiveProductModel>? products = productBox?.values.toList();
    if (products != null) {
      if (search.isNotEmpty) {
        products = products
            .where((element) =>
                element.name!.toLowerCase().startsWith(search.toLowerCase()))
            .toList();
      }
    }
    return products;
  }

  @override
  Future<void> addCart(HiveCartModel hiveCartModel) async {
    return await cartBox?.put(
        (hiveCartModel.customerId.toString() + hiveCartModel.productId)
            .hashCode,
        hiveCartModel);
  }

  @override
  Future<int?> deleteAllCart() async {
    return await cartBox?.clear();
  }

  @override
  Future<void> deleteCustomerCart(int customerId) async {
    List<HiveCartModel>? customerCart =
        cartBox?.values.where((e) => e.customerId == customerId).toList();
    if (customerCart != null) {
      List<dynamic> keys = customerCart.map((e) => e.key).toList();
      await cartBox?.deleteAll(keys);
    }
  }

  @override
  HiveCartModel? getCartProduct(int productId, int customerId) {
    List<HiveCartModel>? customerCart =
        cartBox?.values.where((e) => e.customerId == customerId).toList();
    if (customerCart != null) {
      return customerCart
          .where((element) => element.productId == productId)
          .toList()
          .first;
    }
    return null;
  }

  @override
  List<HiveCartModel>? getCustomerCart(int customerId) {
    List<HiveCartModel>? customerCart =
        cartBox?.values.where((e) => e.customerId == customerId).toList();
    return customerCart;
  }

  @override
  Future<void> updateCart(HiveCartModel hiveCartModel) async {
    return await cartBox?.put(
        (hiveCartModel.customerId.toString() + hiveCartModel.productId)
            .hashCode,
        hiveCartModel);
  }

  @override
  Future<void>? deleteCustomerCartItem(HiveCartModel hiveCartModel) {
    return cartBox?.delete(
        (hiveCartModel.customerId.toString() + hiveCartModel.productId)
            .hashCode);
  }

  @override
  Future<void> clearAll() async {
    await customerBox?.clear();
    await locationBox?.clear();
    await productBox?.clear();
    await cartBox?.clear();
    await userBox?.clear();
    await orderSummaryBox?.clear();
    await orderDetailsBox?.clear();
  }

  @override
  Future<bool> isDataAvailable() async {
    bool isCustomerDataAvailable =
        customerBox?.values.toList().isNotEmpty ?? false;
    bool isLocationDataAvailable =
        locationBox?.values.toList().isNotEmpty ?? false;
    bool isProductDataAvailable =
        productBox?.values.toList().isNotEmpty ?? false;
    return isCustomerDataAvailable &&
        isLocationDataAvailable &&
        isProductDataAvailable;
  }

  @override
  Future<HiveOrderSummaryModel> addOrderSummary(
      HiveOrderSummaryModel hiveOrderSummaryModel) async {
    await orderSummaryBox?.put(
        hiveOrderSummaryModel.orderId, hiveOrderSummaryModel);
    return hiveOrderSummaryModel;
  }

  @override
  Future<int?> deleteAllOrderSummaries() async {
    return await orderSummaryBox?.clear();
  }

  @override
  Future<void> deleteOrderSummary(
      HiveOrderSummaryModel hiveOrderSummaryModel) async {
    List<HiveOrderSummaryModel>? orderSummary = orderSummaryBox?.values
        .where((e) => e.orderId == hiveOrderSummaryModel.orderId)
        .toList();
    if (orderSummary != null) {
      List<dynamic> keys = orderSummary.map((e) => e.key).toList();
      await orderSummaryBox?.deleteAll(keys);
    }
  }

  @override
  Future<void> deleteOrderSummaryByCustomer(int customerId) async {
    List<HiveOrderSummaryModel>? orderSummary = orderSummaryBox?.values
        .where((e) => e.customerId == customerId)
        .toList();
    if (orderSummary != null) {
      List<dynamic> keys = orderSummary.map((e) => e.key).toList();
      await orderSummaryBox?.deleteAll(keys);
    }
  }

  @override
  Future<List<HiveOrderSummaryModel>?> getAllOrderSummaries() async {
    List<HiveOrderSummaryModel>? orderSummaries =
        orderSummaryBox?.values.toList();
    return orderSummaries;
  }

  @override
  Future<List<HiveOrderSummaryModel>?> getAllFailedOrderSummaries() async {
    List<HiveOrderSummaryModel>? orderSummaries = orderSummaryBox?.values
        .toList()
        .where((element) => element.status != 1)
        .toList();
    return orderSummaries;
  }

  @override
  Future<List<HiveOrderSummaryModel>?> getAllUnSendOrderSummaries() async {
    List<HiveOrderSummaryModel>? orderSummaries =
        orderSummaryBox?.values.toList();
    return orderSummaries?.where((element) => element.status != 1).toList();
  }

  @override
  Future<HiveOrderSummaryModel?> getOrderSummaryById(int orderId) async {
    List<HiveOrderSummaryModel>? orderSummary = orderSummaryBox?.values
        .where((element) => element.orderId == orderId)
        .toList();
    if (orderSummary != null && orderSummary.isNotEmpty) {
      return orderSummary.first;
    }
    return null;
  }

  @override
  Future<List<HiveOrderSummaryModel>?> getOrderSummariesByCustomer(
      int customerId) async {
    List<HiveOrderSummaryModel>? orderSummaries = orderSummaryBox?.values
        .where((element) => element.customerId == customerId)
        .toList();
    return orderSummaries;
  }

  @override
  Future<void> updateOrderSummary(
      HiveOrderSummaryModel hiveOrderSummaryModel) async {
    return await orderSummaryBox?.put(
        hiveOrderSummaryModel.orderId, hiveOrderSummaryModel);
  }

  @override
  Future<int> addOrderDetails(
      List<HiveOrderDetailsModel> hiveOrderDetailsModels) async {
    int status = 0;
    for (int i = 0; i < hiveOrderDetailsModels.length; i++) {
      int? status0 = await orderDetailsBox?.add(hiveOrderDetailsModels[i]);
      if (status0 == null) {
        status = 1;
        break;
      }
    }
    return status;
  }

  @override
  Future<List<HiveOrderDetailsModel>?> getAllOrderDetailsByOrder(
      int orderId) async {
    return orderDetailsBox?.values
        .toList()
        .where((e) => e.orderId == orderId)
        .toList();
  }

  @override
  Future<void> deleteOrderDetailsForOrder(int orderId) async {
    List<HiveOrderDetailsModel>? orderDetails =
        orderDetailsBox?.values.where((e) => e.orderId == orderId).toList();
    if (orderDetails != null) {
      List<dynamic> keys = orderDetails.map((e) => e.key).toList();
      await orderDetailsBox?.deleteAll(keys);
    }
  }

  @override
  Future<int?> deleteAllOrderDetails() async {
    return orderDetailsBox?.clear();
  }

  @override
  Future<void> updateOrderSummaryStatus(int orderId, int status) async {
    List<HiveOrderSummaryModel>? orderSummary =
        orderSummaryBox?.values.where((e) => e.orderId == orderId).toList();
    if (orderSummary != null) {
      for (int i = 0; i < orderSummary.length; i++) {
        await orderSummaryBox?.put(
            orderSummary[i].key, orderSummary[i]..status = status);
      }
    }
  }

  @override
  Future<void> updateOrderDetailStatus(int orderId, int status) async {
    List<HiveOrderDetailsModel>? orderDetails =
        orderDetailsBox?.values.where((e) => e.orderId == orderId).toList();
    if (orderDetails != null) {
      for (int i = 0; i < orderDetails.length; i++) {
        await orderDetailsBox?.put(
            orderDetails[i].key, orderDetails[i]..status = status);
      }
    }
  }
}
