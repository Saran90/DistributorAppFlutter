part of 'location_list_cubit.dart';

abstract class LocationListState extends Equatable {
  const LocationListState();
}

class LocationListInitial extends LocationListState {
  @override
  List<Object> get props => [];
}

class LocationListLoading extends LocationListState {
  @override
  List<Object> get props => [];
}

class LocationListPopulated extends LocationListState {

  List<String> locations;

  LocationListPopulated({required this.locations});

  @override
  List<Object> get props => [locations];
}

class LocationListFetchingFailed extends LocationListState {

  final String message;

  const LocationListFetchingFailed({required this.message});

  @override
  List<Object> get props => [message];
}
