import 'package:distributor_app_flutter/app_config.dart';
import 'package:distributor_app_flutter/features/login/presentation/bloc/auth/auth_cubit.dart';
import 'package:distributor_app_flutter/features/order_history/presentation/bloc/order_history_cubit.dart';
import 'package:distributor_app_flutter/features/order_history/presentation/models/order_history.dart';
import 'package:distributor_app_flutter/features/order_history/presentation/widgets/order_history_item_widget.dart';
import 'package:distributor_app_flutter/utils/app_router.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/colors.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final _tableHeaderStyle = const TextStyle(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500);

  var _orders = <OrderHistory>[];
  var _searchedOrders = <OrderHistory>[];

  var _selectedToDate = DateTime.now();
  var _selectedFromDate = DateTime.now();

  final _toDateController = TextEditingController();
  final _fromDateController = TextEditingController();
  final _searchController = TextEditingController();

  bool _isCustomer = false;

  @override
  void initState() {
    _toDateController.text = _selectedToDate.toDDMMYYYYFormat();
    _fromDateController.text = _selectedFromDate.toDDMMYYYYFormat();
    var authState = context.read<AuthCubit>().state;
    if (authState is Authenticated) {
      _isCustomer = authState.isCustomer;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: appColor,
                  pinned: true,
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
                    'Order History',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: appColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 24),
                      child: Row(
                        children: [
                          const Text(
                            'Date Filter',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: InkWell(
                                  onTap: () => _onFromCalendarTapped(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white.withOpacity(0.9)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextFormField(
                                      controller: _fromDateController,
                                      enabled: false,
                                      decoration: const InputDecoration(
                                          hintText: 'From Date',
                                          hintStyle: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12)),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                '-',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 5,
                                child: InkWell(
                                  onTap: () => _onToCalendarTapped(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white.withOpacity(0.9)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextFormField(
                                      enabled: false,
                                      controller: _toDateController,
                                      decoration: const InputDecoration(
                                          hintText: 'To Date',
                                          hintStyle: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12)),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                if (!_isCustomer)
                  SliverToBoxAdapter(
                    child: Container(
                      color: appColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.9)),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                                hintText: 'Search customer',
                                hintStyle: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                                prefixIcon: Icon(Icons.search),
                                contentPadding: EdgeInsets.only(top: 15)),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  _searchedOrders = _orders;
                                });
                                FocusManager.instance.primaryFocus?.unfocus();
                              } else {
                                setState(() {
                                  _searchedOrders = _orders
                                      .where((element) =>
                                          (element.customerName ?? '')
                                              .toLowerCase()
                                              .contains(value.toLowerCase()))
                                      .toList();
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: appColor,
                  toolbarHeight: 30,
                  pinned: true,
                  titleSpacing: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsetsDirectional.only(
                      start: 10,
                    ),
                    title: Container(
                      color: appColor,
                      child: Row(
                        children: [
                          if (!_isCustomer)
                            Expanded(
                                flex: 5,
                                child: Center(
                                  child: Text(
                                    'Customer Name',
                                    style: _tableHeaderStyle,
                                  ),
                                )),
                          if (!_isCustomer)
                            Container(
                              height: 70,
                              width: 0.5,
                              color: Colors.transparent,
                            ),
                          Expanded(
                              flex: 4,
                              child: Center(
                                child: Text(
                                  'Date',
                                  style: _tableHeaderStyle,
                                ),
                              )),
                          Container(
                            height: 70,
                            width: 0.5,
                            color: Colors.transparent,
                          ),
                          Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  'Amount',
                                  style: _tableHeaderStyle,
                                ),
                              )),
                          Container(
                            height: 70,
                            width: 0.5,
                            color: Colors.transparent,
                          ),
                          Expanded(
                              flex: 4,
                              child: Center(
                                child: Text(
                                  'Status',
                                  style: _tableHeaderStyle,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                _searchedOrders.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => InkWell(
                                  onTap: () {
                                    debugPrint('Clicked');
                                    AppConfig.appRouter.push(
                                        OrderHistoryDetailRouter(
                                            orderHistory:
                                                _searchedOrders[index]));
                                  },
                                  child: OrderHistoryItemWidget(
                                    orderItem: _searchedOrders[index],
                                    isCustomer: _isCustomer,
                                  ),
                                ),
                            childCount: _searchedOrders.length),
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
          BlocConsumer<OrderHistoryCubit, OrderHistoryState>(
            builder: (ctx, state) {
              if (state is OrderHistoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
            listener: (ctx, state) {
              if (state is GetOrderHistorySuccess) {
                setState(() {
                  _orders = state.orders;
                  _searchedOrders = state.orders;
                });
              }
              if (state is GetOrderHistoryFailed) {
                context.showMessage(state.message);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onToCalendarTapped() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedToDate,
      firstDate: _selectedFromDate,
      lastDate: DateTime(2150),
    );
    if (selectedDate != null) {
      setState(() {
        _selectedToDate = selectedDate;
        _toDateController.text = _selectedToDate.toDDMMYYYYFormat();
      });
    }
    _getOrderHistory();
  }

  Future<void> _onFromCalendarTapped() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedFromDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2150),
    );
    if (selectedDate != null) {
      setState(() {
        _selectedFromDate = selectedDate;
        _fromDateController.text = _selectedFromDate.toDDMMYYYYFormat();
        _selectedToDate = selectedDate;
        _toDateController.text = _selectedFromDate.toDDMMYYYYFormat();
      });
    }
    _getOrderHistory();
  }

  void _getOrderHistory() {
    context
        .read<OrderHistoryCubit>()
        .getOrderHistory(fromDate: _selectedFromDate, toDate: _selectedToDate);
  }
}
