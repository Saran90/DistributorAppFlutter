part of 'data_download_cubit.dart';

abstract class DataDownloadState extends Equatable {
  const DataDownloadState();
}

class DataDownloadInitial extends DataDownloadState {
  @override
  List<Object> get props => [];
}

class DataDownloadLoading extends DataDownloadState {
  @override
  List<Object> get props => [];
}

class DataAvailable extends DataDownloadState {
  @override
  List<Object> get props => ['Data Available'];
}

class DataNotAvailable extends DataDownloadState {
  @override
  List<Object> get props => ['Data Not Available'];
}
