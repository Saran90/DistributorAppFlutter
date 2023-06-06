import 'package:distributor_app_flutter/core/data/local_storage/models/hive_customer_model.dart';
import 'package:distributor_app_flutter/features/customer_list/presentation/bloc/customer_list/customer_list_cubit.dart';
import 'package:distributor_app_flutter/features/customer_list/presentation/bloc/location_list/location_list_cubit.dart';
import 'package:distributor_app_flutter/features/login/presentation/bloc/auth/auth_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/sales_order/sales_order_cubit.dart';
import 'package:distributor_app_flutter/utils/app_router.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_popup_menu/app_popup_menu.dart';

import '../../../../../utils/colors.dart';
import '../../../../app_config.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../utils/strings.dart';
import '../widgets/customer_item_widget.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({Key? key}) : super(key: key);

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  List<String> _locations = [];
  List<HiveCustomerModel> _customers = [];

  String? _selectedLocation;

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
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
                leading: _appLogoWidget(),
                leadingWidth: 50,
                actions: [_popupMenu()],
                title: Text(
                  AppConfig.instance.appName!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SliverAppBar(
                toolbarHeight: 120,
                backgroundColor: appColor,
                pinned: false,
                title: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  margin: const EdgeInsets.only(bottom: 20),
                  color: appColor,
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 1)),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.white,
                              underline: Container(),
                              dropdownColor: appColor,
                              items: _locations.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              value: _selectedLocation,
                              hint: const Text('Select location',
                                  style: TextStyle(color: Colors.white)),
                              onChanged: (location) {
                                setState(() {
                                  if (location != null) {
                                    _selectedLocation = location;
                                  }
                                });
                                _updateList();
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 1)),
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  controller: _searchController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    hintText: 'Search Customer',
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
                                    width: 20,
                                    height: 20,
                                    child: SvgPicture.asset(
                                      'assets/icons/close.svg',
                                      height: 30,
                                      width: 30,
                                      color: Colors.white,
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
              _customers.isNotEmpty
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => InkWell(
                                onTap: () =>
                                    _onCutsomerSelected(_customers[index]),
                                child: CustomerItemWidget(
                                    customerModel: _customers[index]),
                              ),
                          childCount: _customers.length),
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
          BlocConsumer<LocationListCubit, LocationListState>(
            builder: (context, state) {
              if (state is LocationListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
            listener: (context, state) {
              if (state is LocationListPopulated) {
                setState(() {
                  _locations = state.locations;
                });
                _locations.insert(0, 'All locations');
                _locations.insert(0, 'Select location');
              }
              if (state is LocationListFetchingFailed) {
                setState(() {
                  _locations = [];
                });
                context.showMessage(state.message);
              }
            },
          ),
          BlocConsumer<CustomerListCubit, CustomerListState>(
            builder: (context, state) {
              if (state is CustomerListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
            listener: (context, state) {
              if (state is CustomerListPopulated) {
                setState(() {
                  _customers = state.customers;
                });
              }
              if (state is CustomerListFetchingFailed) {
                setState(() {
                  _customers = [];
                });
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
                AppConfig.appRouter.replace(const LoginRouter());
              }
              if (state is LogoutFailed) {
                setState(() {
                  _customers = [];
                });
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
              if (state is SalesOrderSendSuccessfully) {
                context.showMessage(state.message);
              }
              if (state is SalesOrderSendingFailed) {
                context.showMessage(state.message);
              }
              if (state is NoSalesOrderAvailableForSending) {
                context.showMessage(state.message);
              }
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: appColor,
        selectedLabelStyle: const TextStyle(color: Colors.white, fontSize: 15),
        unselectedLabelStyle:
            const TextStyle(color: Colors.white, fontSize: 15),
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (value) {
          if (value == 0) {
            context.read<SalesOrderCubit>().sendSalesOrder();
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
    );
  }

  Widget _appLogoWidget() {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Container(
          width: 30,
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image:
                  DecorationImage(image: AssetImage(AppConfig.instance.logo!))),
        ),
      ],
    );
  }

  _onProfileTapped() {}

  void _updateList() {
    if (_selectedLocation == 'All locations') {
      context
          .read<CustomerListCubit>()
          .getCustomers(_searchController.text, '');
    } else {
      context
          .read<CustomerListCubit>()
          .getCustomers(_searchController.text, _selectedLocation ?? '');
    }
  }

  void _closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> _onCutsomerSelected(HiveCustomerModel customer) async {
    await AppConfig.appRouter
        .push(ProductListRouter(hiveCustomerModel: customer));
    _closeKeyboard();
  }

  Widget _popupMenu() {
    return PopupMenuButton(
      itemBuilder: (context) {
        var list = <PopupMenuEntry<Object>>[];
        list.add(const PopupMenuItem(
          value: 1,
          child: Text('Sales Order'),
        ));
        list.add(const PopupMenuItem(
          value: 2,
          child: Text('Pending Order'),
        ));
        list.add(const PopupMenuItem(
          value: 3,
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
            _logoutClicked();
            break;
        }
        _closeKeyboard();
      },
      icon: Image.asset('assets/icons/settings.png',color: Colors.white,height: 24,width: 24,),
    );
  }

  Future<void> _logoutClicked() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Alert'),
        content: const Text('Do you really want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => AppConfig.appRouter.pop(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              context.read<AuthCubit>().logout();
              AppConfig.appRouter.pop();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
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
              color: appColor,
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
                  borderRadius: BorderRadius.circular(10)
                ),
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
                      fontWeight: FontWeight.w500),
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
                    const SizedBox(width: 10,),
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
    // FocusManager.instance.primaryFocus?.unfocus();
  }

}
