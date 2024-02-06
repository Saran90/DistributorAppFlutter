import 'package:distributor_app_flutter/core/data/local_storage/models/hive_customer_model.dart';
import 'package:distributor_app_flutter/features/data_download/presentation/bloc/customer_data/customer_data_cubit.dart';
import 'package:distributor_app_flutter/features/data_download/presentation/bloc/location_data/location_data_cubit.dart';
import 'package:distributor_app_flutter/features/data_download/presentation/bloc/product_data/product_data_cubit.dart';
import 'package:distributor_app_flutter/features/login/presentation/bloc/auth/auth_cubit.dart';
import 'package:distributor_app_flutter/utils/app_router.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../app_config.dart';
import '../../../../utils/strings.dart';

class DataDownloadScreen extends StatefulWidget {
  const DataDownloadScreen({Key? key}) : super(key: key);

  @override
  State<DataDownloadScreen> createState() => _DataDownloadScreenState();
}

class _DataDownloadScreenState extends State<DataDownloadScreen> {
  var _progress = 0.1;
  var _downloadMessage = '';
  bool? _isProductFetchingSuccess;
  bool? _isCustomerFetchingSuccess;
  bool? _isLocationFetchingSuccess;
  bool? _isCustomerUser;
  int? _customerId;

  @override
  void initState() {
    context.read<AuthCubit>().isLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_title(), _progressIndicator(), _description()],
            ),
          ),
          BlocConsumer<AuthCubit, AuthState>(
            builder: (context, state) {
              return Container();
            },
            listener: (context, state) {
              if (state is Authenticated) {
                setState(() {
                  _customerId = state.customerId;
                  _isCustomerUser = state.isCustomer;
                });
                if (state.isCustomer) {
                  context.read<ProductDataCubit>().getCustomerProducts('');
                  _downloadMessage = 'Downloading product details';
                } else {
                  context.read<ProductDataCubit>().getProducts('');
                  _downloadMessage = 'Downloading product details';
                }
              }
            },
          ),
          BlocConsumer<ProductDataCubit, ProductDataState>(
            builder: (context, state) {
              return Container();
            },
            listener: (context, state) {
              if (state is ProductDataPopulated) {
                if (_isCustomerUser ?? false) {
                  setState(() {
                    _isProductFetchingSuccess = true;
                    _progress = 0.50;
                  });
                  context.read<CustomerDataCubit>().getCustomers('');
                } else {
                  setState(() {
                    _isProductFetchingSuccess = true;
                    _progress = 0.33;
                    _downloadMessage = 'Downloading customer details';
                  });
                  context.read<CustomerDataCubit>().getCustomers('');
                }
              }
              if (state is ProductDataFetchingFailed) {
                setState(() {
                  _isProductFetchingSuccess = false;
                });
                context.showMessage(state.message);
              }
            },
          ),
          BlocConsumer<CustomerDataCubit, CustomerDataState>(
            builder: (context, state) {
              return Container();
            },
            listener: (context, state) {
              if (state is CustomerDataPopulated) {
                if (_isCustomerUser ?? false) {
                  setState(() {
                    _isCustomerFetchingSuccess = true;
                    _progress = 1;
                  });
                  if(state.customers.any((e) => e.id == _customerId)){
                    HiveCustomerModel selectedCustomer =
                        state.customers.where((e) => e.id == _customerId).first;
                    context.read<CustomerDataCubit>().saveCustomerSelection(selectedCustomer);
                    AppConfig.appRouter
                        .replace(ProductListRouter(hiveCustomerModel: selectedCustomer));
                  }else{
                    context.showMessage('Unknown customer');
                    context.read<AuthCubit>().logout();
                  }
                } else {
                  setState(() {
                    _isCustomerFetchingSuccess = true;
                    _progress = 0.66;
                    _downloadMessage = 'Downloading location details';
                  });
                  context.read<LocationDataCubit>().getLocations();
                }
              }
              if (state is CustomerDataFetchingFailed) {
                setState(() {
                  _isCustomerFetchingSuccess = false;
                });
                context.showMessage(state.message);
              }
            },
          ),
          BlocConsumer<LocationDataCubit, LocationDataState>(
            builder: (context, state) {
              return Container();
            },
            listener: (context, state) {
              if (state is LocationDataPopulated) {
                setState(() {
                  _isLocationFetchingSuccess = true;
                  _progress = 1;
                });
                AppConfig.appRouter.replace(const CustomerListRouter());
              }
              if (state is LocationDataFetchingFailed) {
                setState(() {
                  _isLocationFetchingSuccess = false;
                });
                context.showMessage(state.message);
              }
            },
          )
        ],
      ),
    );
  }

  Widget _progressIndicator() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: CircularPercentIndicator(
        radius: 130.0,
        lineWidth: 15.0,
        percent: _progress,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${(_progress * 100)}%',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _downloadMessage,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            )
          ],
        ),
        progressColor: Colors.green,
      ),
    );
  }

  Widget _title() {
    return const Text(
      'Initializing...',
      style: TextStyle(
          color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _description() {
    return const Padding(
      padding: EdgeInsets.only(top: 60),
      child: Text(
        dataDownloadDescription,
        style: TextStyle(color: Colors.black87, fontSize: 14),
      ),
    );
  }
}
