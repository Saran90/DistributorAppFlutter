import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/features/data_download/domain/usecase/customer_data_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/local_storage/models/hive_customer_model.dart';
import '../../../../../utils/strings.dart';

part 'customer_data_state.dart';

class CustomerDataCubit extends Cubit<CustomerDataState> {
  CustomerDataCubit({required this.customerDataUseCase}) : super(CustomerDataInitial());

  final CustomerDataUseCase customerDataUseCase;

  Future<void> getCustomers(String name) async {
    emit(CustomerDataLoading());
    var result = await customerDataUseCase.call(CustomerDataParams(name: name));
    result.fold((l) {
      if(l is ServerFailure){
        emit(const CustomerDataFetchingFailed(message: serverFailureMessage));
      }else if(l is NetworkFailure){
        emit(const CustomerDataFetchingFailed(message: networkFailureMessage));
      }else{
        emit(const CustomerDataFetchingFailed(message: 'Customers fetching failed'));
      }
    }, (r) => emit(CustomerDataPopulated(customers: r??[])));
  }
}
