part of 'manufacture_cubit.dart';

@immutable
abstract class ManufactureState {}

class ManufactureInitial extends ManufactureState {}

class ManufactureLoading extends ManufactureState {}

class ManufactureListPopulated extends ManufactureState {
  List<Manufacture> manufactures;

  ManufactureListPopulated({required this.manufactures});
}

class NoManufacturesAvailable extends ManufactureState {
}

class ManufactureListFecthingFailed extends ManufactureState {
  final String message;

  ManufactureListFecthingFailed({required this.message});
}
