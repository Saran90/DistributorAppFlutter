import 'package:bloc/bloc.dart';
import 'package:distributor_app_flutter/core/data/error/failures.dart';
import 'package:distributor_app_flutter/core/data/usecase/usecase.dart';
import 'package:distributor_app_flutter/features/login/domain/usecase/manufacture_use_case.dart';
import 'package:distributor_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../pages/models/manufacture.dart';

part 'manufacture_state.dart';

class ManufactureCubit extends Cubit<ManufactureState> {
  ManufactureCubit({required this.manufactureUseCase})
      : super(ManufactureInitial());

  final ManufactureUseCase manufactureUseCase;

  Future<void> getManufactures() async {
    debugPrint('Manufactures fetched');
    emit(ManufactureLoading());
    var result = await manufactureUseCase.call(NoParams());
    result.fold((l) {
      if (l is ServerFailure) {
        emit(ManufactureListFecthingFailed(
            message: l.message ?? serverFailureMessage));
      } else if (l is NetworkFailure) {
        emit(ManufactureListFecthingFailed(message: networkFailureMessage));
      } else {
        emit(ManufactureListFecthingFailed(
            message: 'Manufacture fetching failed'));
      }
    }, (r) {
      if (r == null) {
        emit(NoManufacturesAvailable());
      } else if (r!.isNotEmpty) {
        emit(ManufactureListPopulated(
            manufactures: r
                .map((e) =>
                    Manufacture(id: e.manufactureId, name: e.manufactureName))
                .toList()));
      } else {
        emit(NoManufacturesAvailable());
      }
    });
  }
}
