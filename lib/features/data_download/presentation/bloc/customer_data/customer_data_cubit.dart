import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/usecase/usecase.dart';
import 'package:distributor_app_flutter/features/data_download/domain/usecase/customer_data_use_case.dart';
import 'package:distributor_app_flutter/features/data_download/domain/usecase/delete_customer_selection_use_case.dart';
import 'package:distributor_app_flutter/features/data_download/domain/usecase/save_customer_selection_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/local_storage/models/hive_customer_model.dart';
import '../../../../../utils/strings.dart';
import '../../../domain/usecase/get_customer_selection_use_case.dart';

part 'customer_data_state.dart';

class CustomerDataCubit extends Cubit<CustomerDataState> {
  CustomerDataCubit({
    required this.customerDataUseCase,
    required this.saveCustomerSelectionUseCase,
    required this.deleteCustomerSelectionUseCase,
    required this.getCustomerSelectionUseCase,
  }) : super(CustomerDataInitial());

  final CustomerDataUseCase customerDataUseCase;
  final SaveCustomerSelectionUseCase saveCustomerSelectionUseCase;
  final DeleteCustomerSelectionUseCase deleteCustomerSelectionUseCase;
  final GetCustomerSelectionUseCase getCustomerSelectionUseCase;

  Future<void> getCustomers(String name) async {
    emit(CustomerDataLoading());
    var result = await customerDataUseCase.call(CustomerDataParams(name: name));
    result.fold((l) {
      if (l is ServerFailure) {
        emit(const CustomerDataFetchingFailed(message: serverFailureMessage));
      } else if (l is NetworkFailure) {
        emit(const CustomerDataFetchingFailed(message: networkFailureMessage));
      } else {
        emit(const CustomerDataFetchingFailed(
            message: 'Customers fetching failed'));
      }
    }, (r) {
      if(!isClosed){
        emit(CustomerDataPopulated(customers: r ?? []));
      }
    });
  }

  Future<void> saveCustomerSelection(
      HiveCustomerModel hiveCustomerModel) async {
    emit(CustomerDataLoading());
    var result = await saveCustomerSelectionUseCase.call(
        SaveCustomerSelectionParams(hiveCustomerModel: hiveCustomerModel));
    result.fold((l) {
      if (l is ServerFailure) {
        emit(const SaveCustomerSelectionFailed(message: serverFailureMessage));
      } else if (l is NetworkFailure) {
        emit(const SaveCustomerSelectionFailed(message: networkFailureMessage));
      } else {
        emit(const SaveCustomerSelectionFailed(
            message: 'Customers selection failed'));
      }
    }, (r) => emit(SaveCustomerSelectionSuccess()));
  }

  Future<void> deleteCustomerSelection() async {
    emit(CustomerDataLoading());
    var result = await deleteCustomerSelectionUseCase.call(NoParams());
    result.fold((l) {
      if (l is ServerFailure) {
        emit(
            const DeleteCustomerSelectionFailed(message: serverFailureMessage));
      } else if (l is NetworkFailure) {
        emit(const DeleteCustomerSelectionFailed(
            message: networkFailureMessage));
      } else {
        emit(const DeleteCustomerSelectionFailed(
            message: 'Customers selection clearing failed'));
      }
    }, (r) => emit(DeleteCustomerSelectionSuccess()));
  }

  Future<void> getCustomerSelection() async {
    emit(CustomerDataLoading());
    var result = await getCustomerSelectionUseCase.call(NoParams());
    result.fold((l) {
      if (l is ServerFailure) {
        emit(
            const GetCustomerSelectionFailed(message: serverFailureMessage));
      } else if (l is NetworkFailure) {
        emit(const GetCustomerSelectionFailed(
            message: networkFailureMessage));
      } else {
        emit(const GetCustomerSelectionFailed(
            message: 'Customers selection clearing failed'));
      }
    }, (r) => emit(GetCustomerSelectionSuccess(hiveCustomerModel: r)));
  }
}
