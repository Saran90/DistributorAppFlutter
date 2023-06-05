import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/data/local_storage/models/hive_location_model.dart';
import '../../../../../../utils/strings.dart';
import '../../../domain/usecase/location_list_use_case.dart';

part 'location_list_state.dart';

class LocationListCubit extends Cubit<LocationListState> {
  LocationListCubit({required this.locationListUseCase})
      : super(LocationListInitial());

  final LocationListUseCase locationListUseCase;

  Future<void> getLocations() async {
    emit(LocationListLoading());
    var result = await locationListUseCase.call(NoParams());
    result.fold((l) {
      if (l is CacheFailure) {
        emit(const LocationListFetchingFailed(message: cacheFailureMessage));
      } else {
        emit(const LocationListFetchingFailed(
            message: 'Locations fetching failed'));
      }
    },
        (r) => emit(
            LocationListPopulated(locations: r!.map((e) => e.text!).toList())));
  }
}
