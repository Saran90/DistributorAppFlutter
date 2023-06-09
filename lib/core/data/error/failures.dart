import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {

  ServerFailure({this.message});

  final String? message;
}

class NetworkFailure extends Failure {}

class CacheFailure extends Failure {}