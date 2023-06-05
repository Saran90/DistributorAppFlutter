import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/usecase/usecase.dart';
import 'package:distributor_app_flutter/features/data_download/domain/usecase/location_data_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/local_storage/models/hive_location_model.dart';
import '../../../../../utils/strings.dart';

part 'location_data_state.dart';

class LocationDataCubit extends Cubit<LocationDataState> {
  LocationDataCubit({required this.locationDataUseCase}) : super(LocationDataInitial());

  final LocationDataUseCase locationDataUseCase;

  Future<void> getLocations() async {
    emit(LocationDataLoading());
    var result = await locationDataUseCase.call(NoParams());
    result.fold((l) {
      if(l is ServerFailure){
        emit(const LocationDataFetchingFailed(message: serverFailureMessage));
      }else if(l is NetworkFailure){
        emit(const LocationDataFetchingFailed(message: networkFailureMessage));
      }else{
        emit(const LocationDataFetchingFailed(message: 'Locations fetching failed'));
      }
    }, (r) => emit(LocationDataPopulated(locations: r??[])));
  }
}
