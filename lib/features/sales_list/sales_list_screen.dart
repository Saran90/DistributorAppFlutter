import 'package:distributor_app_flutter/features/orders_list/presentation/pages/models/order.dart';
import 'package:distributor_app_flutter/utils/app_router.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_config.dart';
import '../../utils/colors.dart';
import '../orders_list/presentation/bloc/order_summary/order_summary_cubit.dart';
import '../orders_list/presentation/bloc/sales_order/sales_order_cubit.dart';
import 'widgets/sales_item_widget.dart';

class SalesListScreen extends StatefulWidget {
  const SalesListScreen({Key? key}) : super(key: key);

  @override
  State<SalesListScreen> createState() => _SalesListScreenState();
}

class _SalesListScreenState extends State<SalesListScreen> {
  final _tableHeaderStyle = const TextStyle(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500);

  List<Order> _orders = [];

  @override
  void initState() {
    context.read<OrderSummaryCubit>().getAllOrderSummaries(1);
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
                    'Sales Orders',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SliverVisibility(
                  visible: _orders.isNotEmpty,
                  sliver: SliverAppBar(
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
                            Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    'SNo',
                                    style: _tableHeaderStyle,
                                  ),
                                )),
                            Container(
                              height: 70,
                              width: 0.5,
                              color: Colors.transparent,
                            ),
                            Expanded(
                                flex: 8,
                                child: Center(
                                  child: Text(
                                    'Customer Name',
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
                ),
                _orders.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => InkWell(
                              onTap: () => AppConfig.appRouter.push(
                                  SalesItemListRouter(
                                      orderId:
                                      _orders[index].orderId)),
                              child: SalesItemWidget(
                                    order: _orders[index],
                                  ),
                            ),
                            childCount: _orders.length),
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
              if (state is OrderSummaryPopulated) {
                setState(() {
                  _orders = state.orderSummaries;
                });
              }
              if (state is OrderSummaryFetchingFailed) {
                setState(() {
                  _orders = [];
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
