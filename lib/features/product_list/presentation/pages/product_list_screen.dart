import 'package:distributor_app_flutter/core/data/local_storage/models/hive_customer_model.dart';
import 'package:distributor_app_flutter/core/widgets/app_button.dart';
import 'package:distributor_app_flutter/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:distributor_app_flutter/features/login/presentation/bloc/auth/auth_cubit.dart';
import 'package:distributor_app_flutter/features/product_list/presentation/bloc/product_list/product_list_cubit.dart';
import 'package:distributor_app_flutter/features/product_list/presentation/pages/models/product.dart';
import 'package:distributor_app_flutter/features/product_list/presentation/widgets/product_item_widget.dart';
import 'package:distributor_app_flutter/utils/app_router.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app_config.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/strings.dart';
import '../../../cart/presentation/pages/models/cart.dart';
import '../../../orders_list/presentation/bloc/sales_order/sales_order_cubit.dart';
import '../../../orders_list/presentation/widgets/sales_upload_widget.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key, required this.hiveCustomerModel})
      : super(key: key);

  final HiveCustomerModel hiveCustomerModel;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  int _cartCount = 0;

  final _searchController = TextEditingController();
  List<Product> _products = [];
  List<Cart> _cartProducts = [];

  final _tableHeaderStyle = const TextStyle(
      color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500);

  int? _userId;

  bool? _isCustomer;

  @override
  void initState() {
    context.read<AuthCubit>().isLoggedIn();
    _products = [];
    _cartProducts = [];
    _updateList();
    AuthState authState = context.read<AuthCubit>().state;
    if (authState is Authenticated) {
      _userId = authState.userId;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        bottomNavigationBar: Visibility(
          visible: _isCustomer ?? false,
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [appColorGradient1, appColorGradient2])),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedLabelStyle:
                  const TextStyle(color: Colors.white, fontSize: 15),
              unselectedLabelStyle:
                  const TextStyle(color: Colors.white, fontSize: 15),
              fixedColor: Colors.white,
              unselectedItemColor: Colors.white,
              onTap: (value) {
                if (value == 0) {
                  _showSalesUploadingBottomSheet();
                } else {
                  _showSyncDataConfirmationBottomSheet();
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/send.png',
                    width: 20,
                    height: 20,
                  ),
                  label: 'Send Sales Order',
                ),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/update.png',
                      width: 20,
                      height: 20,
                    ),
                    label: 'Sync Data')
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: appColor,
                  pinned: true,
                  elevation: 0,
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [appColorGradient1, appColorGradient2]),
                    ),
                  ),
                  automaticallyImplyLeading: true,
                  leadingWidth: 50,
                  actions: [
                    Visibility(
                      visible: _isCustomer ?? false,
                      child: _popupMenu(),
                    ),
                    InkWell(
                      onTap: _onCartTapped,
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  'assets/icons/cart.svg',
                                  width: 25,
                                  height: 25,
                                  color: Colors.white,
                                )),
                            Visibility(
                              visible: _cartCount > 0,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  backgroundColor: appColor,
                                  radius: 10,
                                  child: Center(
                                    child: Text(
                                      '$_cartCount',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                  centerTitle: true,
                  title: const Text(
                    'Products',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SliverAppBar(
                  toolbarHeight:
                      AppConfig.instance.flavor == AppFlavor.varsha.name
                          ? 170
                          : 80,
                  // backgroundColor: appColor,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [appColorGradient1, appColorGradient2])),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: AppConfig.instance.flavor ==
                                AppFlavor.varsha.name,
                            child: Text(
                              '${widget.hiveCustomerModel.name}, ${widget.hiveCustomerModel.location}',
                              maxLines: 2,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Visibility(
                            visible: AppConfig.instance.flavor ==
                                AppFlavor.varsha.name,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20,bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('Account balance:',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      '₹ ${widget.hiveCustomerModel.accountBalance}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white))
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            height: 40,
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: Image.asset(
                                      'assets/icons/search.png',
                                      color: Colors.white,
                                    )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 40,
                                    child: TextFormField(
                                      cursorColor: Colors.white,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      onTap: () {
                                        var selection = TextSelection(
                                            baseOffset: 0,
                                            extentOffset: _searchController
                                                .value.text.length);
                                        if (_searchController.selection.extentOffset !=
                                            _searchController
                                                .value.text.length) {
                                          _searchController.selection =
                                              selection;
                                        } else {
                                          _searchController.selection =
                                              TextSelection(
                                                  baseOffset: _searchController
                                                      .value.text.length,
                                                  extentOffset: _searchController
                                                      .value.text.length);
                                        }
                                      },
                                      controller: _searchController,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        hintText: 'Search Product',
                                        hintStyle: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 14),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) => _updateList(),
                                    ),
                                  ),
                                ),
                                Visibility(
                                    visible: _searchController.text.isNotEmpty,
                                    child: InkWell(
                                      onTap: () {
                                        _searchController.clear();
                                        _closeKeyboard();
                                        _updateList();
                                      },
                                      child: SizedBox(
                                        width: 60,
                                        height: 20,
                                        child: Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: SvgPicture.asset(
                                              'assets/icons/close.svg',
                                              height: 30,
                                              width: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverAppBar(
                  toolbarHeight: 30,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  titleSpacing: 0,
                  flexibleSpace: Container(
                    color: appColor,
                    child: Row(
                      children: [
                        const Expanded(flex: 2, child: SizedBox()),
                        Expanded(
                            flex: 8,
                            child: SizedBox(
                              child: Center(
                                child: Text(
                                  'Item Name',
                                  style: _tableHeaderStyle,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 4,
                            child: SizedBox(
                              child: Center(
                                child: Text(
                                  'Stock',
                                  style: _tableHeaderStyle,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 4,
                            child: SizedBox(
                              child: Center(
                                child: Text(
                                  'Rate',
                                  style: _tableHeaderStyle,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 4,
                            child: SizedBox(
                              child: Center(
                                child: Text(
                                  'Qty',
                                  style: _tableHeaderStyle,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 4,
                            child: SizedBox(
                              child: Center(
                                child: Text(
                                  'Total',
                                  style: _tableHeaderStyle,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                _products.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => InkWell(
                                onTap: () =>
                                    _onProductClicked(_products[index]),
                                child: ProductItemWidget(
                                    productModel: _products[index])),
                            childCount: _products.length),
                      )
                    : const SliverFillRemaining(
                        child: Center(
                          child: Text(
                            'No data available',
                          ),
                        ),
                      ),
              ],
            ),
            BlocConsumer<AuthCubit, AuthState>(
              builder: (context, state) => Container(),
              listener: (context, state) {
                if (state is Authenticated) {
                  _isCustomer = state.isCustomer;
                }
              },
            ),
            BlocConsumer<ProductListCubit, ProductListState>(
              builder: (context, state) {
                if (state is ProductListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              },
              listener: (context, state) {
                if (state is ProductListPopulated) {
                  setState(() {
                    _products = state.products;
                  });
                  _updateCart();
                }
                if (state is ProductListFetchingFailed) {
                  setState(() {
                    _products = [];
                  });
                  context.showMessage(state.message);
                }
                if (state is SelectedProductListPopulated) {
                  setState(() {
                    _products = state.products;
                  });
                }
              },
            ),
            BlocConsumer<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              },
              listener: (context, state) {
                if (state is CartListPopulated) {
                  setState(() {
                    _cartProducts = state.carts;
                    _cartCount = _cartProducts.length;
                  });
                  context
                      .read<ProductListCubit>()
                      .getSelectedProducts(_products, _cartProducts);
                }
                if (state is CartListFetchingFailed) {
                  setState(() {
                    _cartProducts = [];
                  });
                }
                if (state is CartAdded) {
                  _updateCart();
                }
                if (state is CartAdditionFailed) {
                  context.showMessage(state.message);
                }
                if (state is CartUpdated) {
                  _updateList();
                }
                if (state is CartUpdationFailed) {
                  context.showMessage(state.message);
                }
                if (state is CartDeleted) {
                  // _updateCart();
                }
                if (state is CartItemDeleted) {
                  _updateList();
                }
                if (state is CartDeletionFailed) {
                  context.showMessage(state.message);
                }
              },
            ),
            BlocConsumer<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              },
              listener: (context, state) {
                if (state is UnAuthenticated) {
                  if (AppConfig.instance.flavor == AppFlavor.varsha.name) {
                    AppConfig.appRouter.replace(const LandingRouter());
                  } else {
                    AppConfig.appRouter.replace(const LoginRouter());
                  }
                }
                if (state is LogoutFailed) {
                  context.showMessage(state.message);
                }
              },
            ),
            BlocConsumer<SalesOrderCubit, SalesOrderState>(
              builder: (context, state) {
                if (state is SalesOrderLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              },
              listener: (context, state) {
                if (state is SalesOrdersSendSuccessfully) {
                  context.showMessage(state.message);
                }
                if (state is SalesOrdersSendingFailed) {
                  context.showMessage(state.message);
                }
                if (state is NoSalesOrderAvailableForSending) {
                  context.showMessage(state.message);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onCartTapped() async {
    if (_cartCount != 0) {
      await AppConfig.appRouter.push(CartRouter(
          hiveCustomerModel: widget.hiveCustomerModel,
          isCustomer: _isCustomer));
      _updateList();
    }
  }

  void _updateList() {
    context.read<ProductListCubit>().getProducts(_searchController.text);
  }

  void _updateCart() {
    context.read<CartCubit>().getCustomerCart(widget.hiveCustomerModel.id!);
  }

  void _closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> _onProductClicked(Product product) async {
    await _showQuantitySelectionBottomSheet(product, _onQuantitySelected);
    _closeKeyboard();
  }

  void _onQuantitySelected(int quantity, Product product) {
    bool isProductAvailableInCart = false;
    if (_cartProducts.isNotEmpty) {
      for (int i = 0; i < _cartProducts.length; i++) {
        if (_cartProducts[i].productId == '${product.id}') {
          isProductAvailableInCart = true;
          _cartProducts[i].quantity = quantity;
          _cartProducts[i].orderAmount =
              (quantity.toDouble() * (product.rate ?? 0)).to2DigitFraction();
          if (quantity == 0) {
            context
                .read<CartCubit>()
                .deleteCartItem(_cartProducts[i].toHiveModel());
          } else {
            context.read<CartCubit>().updateCart(_cartProducts[i]);
          }
        }
      }
      if (!isProductAvailableInCart && quantity > 0) {
        context.read<CartCubit>().addCart(Cart(
            orderAmount: (product.rate ?? 0) * quantity,
            customerId: widget.hiveCustomerModel.id!,
            orderId: '',
            mrp: product.mrp ?? 0.0,
            quantity: quantity,
            rate: product.rate ?? 0.0,
            id: DateTime.now().microsecondsSinceEpoch,
            unit: product.unit ?? '',
            stock: product.stock ?? 0,
            userId: _userId ?? 0,
            productId: product.id != null ? '${product.id}' : '',
            productName: product.name ?? ''));
      }
    } else {
      if (quantity > 0) {
        context.read<CartCubit>().addCart(Cart(
            orderAmount: (product.rate ?? 0) * quantity,
            customerId: widget.hiveCustomerModel.id!,
            orderId: '',
            mrp: product.mrp ?? 0.0,
            quantity: quantity,
            rate: product.rate ?? 0.0,
            id: DateTime.now().microsecondsSinceEpoch,
            unit: product.unit ?? '',
            stock: product.stock ?? 0,
            userId: _userId ?? 0,
            productId: product.id != null ? '${product.id}' : '',
            productName: product.name ?? ''));
      }
    }
  }

  Future<void> _showQuantitySelectionBottomSheet(Product product,
      Function(int quantity, Product product) onQuantitySelected) async {
    final quantityFieldFocusNode = FocusNode();
    final quantityController = TextEditingController();
    if (product.quantity != null && product.quantity! > 0) {
      quantityController.text = '${product.quantity}';
    }
    quantityFieldFocusNode.requestFocus();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [appColorGradient1, appColorGradient2]),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 24,
              left: 24,
              right: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                height: 5,
                width: 80,
                margin: const EdgeInsets.only(top: 8),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  'Enter quantity',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(top: 40, bottom: 20),
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    cursorColor: Colors.black87,
                    focusNode: quantityFieldFocusNode,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+'))
                    ],
                    enableInteractiveSelection: false,
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter quantity',
                      hintStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                child: SizedBox(
                  height: 50,
                  child: AppButton(
                    startColor: appColorGradient1,
                    endColor: appColorGradient2,
                    onSubmit: () async {
                      if (quantityController.text.isNotEmpty) {
                        int quantity = int.parse(quantityController.text);
                        await AppConfig.appRouter.pop();
                        _onQuantitySelected(quantity, product);
                      } else {
                        int quantity = 0;
                        await AppConfig.appRouter.pop();
                        _onQuantitySelected(quantity, product);
                      }
                    },
                    label: 'Submit',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    if (_cartProducts.isNotEmpty) {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        builder: (ctx) => SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [appColorGradient1, appColorGradient2]),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 24,
                left: 24,
                right: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: 5,
                  width: 80,
                  margin: const EdgeInsets.only(top: 2),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'Cart',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    clearCartConfirmationMessage,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            height: 40,
                            child: AppButton(
                              startColor: appColorGradient1,
                              endColor: appColorGradient2,
                              onSubmit: () async {
                                AppConfig.appRouter.pop();
                              },
                              label: 'No',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            height: 40,
                            child: AppButton(
                              startColor: appColorGradient1,
                              endColor: appColorGradient2,
                              onSubmit: () async {
                                await context
                                    .read<CartCubit>()
                                    .deleteCart(widget.hiveCustomerModel.id!);
                                AppConfig.appRouter.pop();
                              },
                              label: 'Yes',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
      return true;
    } else {
      return true;
    }
  }

  Widget _popupMenu() {
    return PopupMenuButton(
      itemBuilder: (context) {
        var list = <PopupMenuEntry<Object>>[];
        list.add(const PopupMenuItem(
          value: 1,
          child: Text('Sales Orders'),
        ));
        list.add(const PopupMenuItem(
          value: 2,
          child: Text('Pending Orders'),
        ));
        list.add(const PopupMenuItem(
          value: 3,
          child: Text('Failed Orders'),
        ));
        if (_showOrderHistory()) {
          list.add(const PopupMenuItem(
            value: 4,
            child: Text('Order History'),
          ));
        }
        list.add(const PopupMenuItem(
          value: 5,
          child: Text('Logout'),
        ));
        return list;
      },
      position: PopupMenuPosition.under,
      initialValue: 0,
      onCanceled: () => _closeKeyboard(),
      onSelected: (value) {
        switch (value) {
          case 1:
            AppConfig.appRouter.push(const SalesListRouter());
            break;
          case 2:
            AppConfig.appRouter.push(const OrdersListRouter());
            break;
          case 3:
            AppConfig.appRouter.push(const FailedOrdersListRouter());
            break;
          case 4:
            _showOrderHistory()
                ? AppConfig.appRouter.push(const OrderHistoryRouter())
                : _showLogoutConfirmationBottomSheet();
            break;
          case 5:
            _showLogoutConfirmationBottomSheet();
            break;
        }
        _closeKeyboard();
      },
      icon: Image.asset(
        'assets/icons/settings.png',
        color: Colors.white,
        height: 24,
        width: 24,
      ),
    );
  }

  void _showLogoutConfirmationBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [appColorGradient1, appColorGradient2]),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 24,
              left: 24,
              right: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: 5,
                width: 80,
                margin: const EdgeInsets.only(top: 2),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  logoutConfirmationMessage,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          height: 40,
                          child: AppButton(
                            startColor: appColorGradient1,
                            endColor: appColorGradient2,
                            onSubmit: () async {
                              AppConfig.appRouter.pop();
                            },
                            label: 'Cancel',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          height: 40,
                          child: AppButton(
                            startColor: appColorGradient1,
                            endColor: appColorGradient2,
                            onSubmit: () async {
                              context.read<AuthCubit>().logout();
                              AppConfig.appRouter.pop();
                            },
                            label: 'Logout',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    // FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> _showSalesUploadingBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => BlocProvider<SalesOrderCubit>(
          create: (context) => AppConfig.s1(),
          child: const SalesUploadWidget(),
        ),
      ),
    );
    // FocusManager.instance.primaryFocus?.unfocus();
  }

  void _showSyncDataConfirmationBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [appColorGradient1, appColorGradient2]),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 24,
              left: 24,
              right: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: 5,
                width: 80,
                margin: const EdgeInsets.only(top: 2),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Sync Data',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  syncDataConfirmationDialogMessage,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          height: 40,
                          child: AppButton(
                            startColor: appColorGradient1,
                            endColor: appColorGradient2,
                            onSubmit: () async {
                              AppConfig.appRouter.pop();
                            },
                            label: 'Cancel',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          height: 40,
                          child: AppButton(
                            startColor: appColorGradient1,
                            endColor: appColorGradient2,
                            onSubmit: () async {
                              context.read<AuthCubit>().logout();
                              AppConfig.appRouter.pop();
                            },
                            label: 'Sync Data',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _showOrderHistory() {
    if (AppConfig.instance.flavor == AppFlavor.varsha.name) {
      return true;
    } else {
      return false;
    }
  }
}
