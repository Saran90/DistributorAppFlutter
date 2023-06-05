import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/data/local_storage/models/hive_customer_model.dart';
import '../../../../../../utils/strings.dart';
import '../../../domain/usecase/customer_list_use_case.dart';

part 'customer_list_state.dart';

class CustomerListCubit extends Cubit<CustomerListState> {
  CustomerListCubit({required this.customerListUseCase})
      : super(CustomerListInitial());

  final CustomerListUseCase customerListUseCase;

  Future<void> getCustomers(String search, String location) async {
    emit(CustomerListLoading());
    var result = await customerListUseCase
        .call(CustomerListParams(search: search, location: location));
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const CustomerListFetchingFailed(message: cacheFailureMessage));
      } else {
        emit(const CustomerListFetchingFailed(
            message: 'Customers fetching failed'));
      }
    }, (r) => emit(CustomerListPopulated(customers: r ?? [])));
  }
}
