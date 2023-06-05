part of 'location_data_cubit.dart';

abstract class LocationDataState extends Equatable {
  const LocationDataState();
}

class LocationDataInitial extends LocationDataState {
  @override
  List<Object> get props => [];
}

class LocationDataLoading extends LocationDataState {
  @override
  List<Object> get props => [];
}

class LocationDataPopulated extends LocationDataState {

  List<HiveLocationModel> locations;

  LocationDataPopulated({required this.locations});

  @override
  List<Object> get props => [locations];
}

class LocationDataFetchingFailed extends LocationDataState {

  final String message;

  const LocationDataFetchingFailed({required this.message});

  @override
  List<Object> get props => [message];
}
