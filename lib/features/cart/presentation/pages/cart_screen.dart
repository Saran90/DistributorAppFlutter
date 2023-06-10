import 'package:distributor_app_flutter/app_config.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_details_model.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_details/order_details_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_summary/order_summary_cubit.dart';
import 'package:distributor_app_flutter/utils/app_router.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/local_storage/models/hive_customer_model.dart';
import '../../../../core/data/local_storage/models/hive_order_summary_model.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/strings.dart';
import '../../../login/presentation/bloc/auth/auth_cubit.dart';
import '../bloc/cart_cubit.dart';
import '../widgets/cart_item_widget.dart';
import 'models/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, required this.hiveCustomerModel})
      : super(key: key);

  final HiveCustomerModel hiveCustomerModel;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _tableHeaderStyle = const TextStyle(
      color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500);

  List<Cart> _cartProducts = [];

  int? _userId;

  @override
  void initState() {
    AuthState authState = context.read<AuthCubit>().state;
    if (authState is Authenticated) {
      _userId = authState.userId;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 170),
            child: CustomScrollView(
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
                  centerTitle: true,
                  title: const Text(
                    'Cart',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SliverAppBar(
                  toolbarHeight: 70,
                  backgroundColor: appColor,
                  automaticallyImplyLeading: false,
                  pinned: false,
                  flexibleSpace: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [appColorGradient1, appColorGradient2])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.hiveCustomerModel.name}, ${widget.hiveCustomerModel.location}',
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: appColor,
                  toolbarHeight: 20,
                  pinned: true,
                  title: Container(
                    color: appColor,
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
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
                        const Expanded(flex: 2, child: SizedBox()),
                      ],
                    ),
                  ),
                ),
                _cartProducts.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => CartItemWidget(
                                  cartModel: _cartProducts[index],
                                  onDeleteClicked: () =>
                                      _showDeleteItemConfirmationBottomSheet(_cartProducts[index]),
                                  onQuantityClicked: () =>
                                      _onQuantityClicked(_cartProducts[index]),
                                ),
                            childCount: _cartProducts.length),
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 170,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [appColorGradient1, appColorGradient2]),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [_cartSummaryWidget(), _actionButtons()],
              ),
            ),
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
                });
                if (_cartProducts.isEmpty) {
                  AppConfig.appRouter.pop();
                }
              }
              if (state is CartListFetchingFailed) {
                setState(() {
                  _cartProducts = [];
                });
              }
              if (state is CartUpdated) {
                context
                    .read<CartCubit>()
                    .getCustomerCart(widget.hiveCustomerModel.id!);
              }
              if (state is CartUpdationFailed) {
                context.showMessage(state.message);
              }
              if (state is CartItemDeleted) {
                context
                    .read<CartCubit>()
                    .getCustomerCart(widget.hiveCustomerModel.id!);
              }
              if (state is CartItemDeletionFailed) {
                context.showMessage(state.message);
              }
              if (state is CartDeleted) {
                context
                    .read<CartCubit>()
                    .getCustomerCart(widget.hiveCustomerModel.id!);
              }
              if (state is CartDeletionFailed) {
                context.showMessage(state.message);
              }
            },
          ),
          BlocConsumer<OrderSummaryCubit, OrderSummaryState>(
            builder: (context, state) {
              if (state is OrderSummaryLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
            listener: (context, state) {
              if (state is OrderSummaryAdded) {
                context.read<OrderDetailsCubit>().addOrderDetails(_cartProducts
                    .map((e) => HiveOrderDetailsModel(
                        id: _generateOrderItemId(
                            state.hiveOrderSummaryModel.orderId, e.productId),
                        rate: e.rate,
                        quantity: e.quantity,
                        mrp: e.mrp,
                        status: state.hiveOrderSummaryModel.status,
                        orderDate: state.hiveOrderSummaryModel.orderDate,
                        orderId: state.hiveOrderSummaryModel.orderId,
                        productId: int.parse(e.productId),
                        productName: e.productName,
                        total: e.orderAmount))
                    .toList());
              }
              if (state is OrderSummaryAdditionFailed) {
                context.showMessage(state.message);
              }
            },
          ),
          BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
            builder: (context, state) {
              if (state is OrderDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
            listener: (context, state) {
              if (state is OrderDetailsAdded) {
                context.showMessage('Order Saved');
                context
                    .read<CartCubit>()
                    .deleteCart(widget.hiveCustomerModel.id!);
                AppConfig.appRouter.pushAndPopUntil(
                  const CustomerListRouter(),
                  predicate: (route) => false,
                );
              }
              if (state is OrderDetailsAdditionFailed) {
                context.showMessage(state.message);
              }
            },
          )
        ],
      ),
    );
  }

  void _onQuantityClicked(Cart cartProduct) {
    _showQuantitySelectionBottomSheet(cartProduct, _onQuantitySelected);
  }

  void _showQuantitySelectionBottomSheet(Cart cart,
      Function(double quantity, Cart cart) onQuantitySelected) async {
    final quantityFieldFocusNode = FocusNode();
    final quantityController = TextEditingController();
    if (cart.quantity > 0) {
      quantityController.text = '${cart.quantity}';
    }
    quantityFieldFocusNode.requestFocus();
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                appColorGradient1,
                appColorGradient2
              ]),
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
                        double quantity = double.parse(quantityController.text);
                        await AppConfig.appRouter.pop();
                        onQuantitySelected(quantity, cart);
                      } else {
                        double quantity = double.parse(quantityController.text);
                        await AppConfig.appRouter.pop();
                        onQuantitySelected(quantity, cart);
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

  void _onQuantitySelected(double quantity, Cart cart) {
    for (int i = 0; i < _cartProducts.length; i++) {
      if (_cartProducts[i].productId == cart.productId) {
        _cartProducts[i].quantity = quantity;
        _cartProducts[i].orderAmount = quantity * _cartProducts[i].rate;
        if (quantity == 0) {
          context
              .read<CartCubit>()
              .deleteCartItem(_cartProducts[i].toHiveModel());
        } else {
          context.read<CartCubit>().updateCart(_cartProducts[i]);
        }
      }
    }
  }

  Widget _cartSummaryWidget() {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                  flex: 6,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Total number of items:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ))),
              Expanded(
                  flex: 4,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${_cartProducts.length}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22),
                      ))),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Expanded(
                  flex: 6,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Gross Amount:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ))),
              Expanded(
                  flex: 4,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${_cartAmount()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white),
                      ))),
            ],
          )
        ],
      ),
    );
  }

  Widget _actionButtons() {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: AppButton(
            startColor: appColorGradient1,
            endColor: appColorGradient2,
            label: 'Clear',
            onSubmit: () => _showClearCartConfirmationBottomSheet(),
          )),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: AppButton(
            startColor: appColorGradient1,
            endColor: appColorGradient2,
            label: 'Save',
            onSubmit: _onSaveClicked,
          ))
        ],
      ),
    );
  }

  double _cartAmount() {
    double totalAmount = 0;
    for (var cartItem in _cartProducts) {
      totalAmount += cartItem.orderAmount;
    }
    return totalAmount.to2DigitFraction();
  }

  _onSaveClicked() {
    context.read<OrderSummaryCubit>().addOrderSummary(HiveOrderSummaryModel(
        orderId: _generateOrderId(),
        status: -2,
        userId: _userId!,
        customerId: widget.hiveCustomerModel.id!,
        customerName: widget.hiveCustomerModel.name!,
        orderAmount: _cartAmount(),
        orderDate: DateTime.now()));
  }

  int _generateOrderId() {
    return (widget.hiveCustomerModel.id! + DateTime.now().hashCode.hashCode);
  }

  int _generateOrderItemId(int orderId, String productId) {
    return (orderId.toString() + productId).hashCode;
  }

  void _showClearCartConfirmationBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                appColorGradient1,
                appColorGradient2
              ]),
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
                              context
                                  .read<CartCubit>()
                                  .deleteCart(widget.hiveCustomerModel.id!);
                              AppConfig.appRouter.pop();
                            },
                            label: 'Clear',
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

  void _showDeleteItemConfirmationBottomSheet(Cart cartProduct) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                appColorGradient1,
                appColorGradient2
              ]),
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
                  deleteItemConfirmationMessage,
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
                              context
                                  .read<CartCubit>()
                                  .deleteCartItem(cartProduct.toHiveModel());
                              AppConfig.appRouter.pop();
                            },
                            label: 'Delete',
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
}
