import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/usecase/usecase.dart';
import 'package:distributor_app_flutter/features/data_download/domain/usecase/is_data_available_use_case.dart';
import 'package:equatable/equatable.dart';

part 'data_download_state.dart';

class DataDownloadCubit extends Cubit<DataDownloadState> {
  DataDownloadCubit({required this.isDataAvailableUseCase})
      : super(DataDownloadInitial());

  final IsDataAvailableUseCase isDataAvailableUseCase;

  Future<void> isDataAvailable() async {
    emit(DataDownloadLoading());
    var result = await isDataAvailableUseCase.call(NoParams());
    result.fold((l) {
      if (l is CacheFailure) {
        emit(DataNotAvailable());
      } else {
        emit(DataNotAvailable());
      }
    }, (r) {
      if (r) {
        emit(DataAvailable());
      } else {
        emit(DataNotAvailable());
      }
    });
  }
}
