import 'dart:convert';
/// ManufactureId : 2
/// ManufactureName : "Hindustan Pencils"

ManufactureListResponse manufactureListResponseFromJson(String str) => ManufactureListResponse.fromJson(json.decode(str));
String manufactureListResponseToJson(ManufactureListResponse data) => json.encode(data.toJson());
class ManufactureListResponse {
  ManufactureListResponse({
      int? manufactureId, 
      String? manufactureName,}){
    _manufactureId = manufactureId;
    _manufactureName = manufactureName;
}

  ManufactureListResponse.fromJson(dynamic json) {
    _manufactureId = json['ManufactureId'];
    _manufactureName = json['ManufactureName'];
  }
  int? _manufactureId;
  String? _manufactureName;
ManufactureListResponse copyWith({  int? manufactureId,
  String? manufactureName,
}) => ManufactureListResponse(  manufactureId: manufactureId ?? _manufactureId,
  manufactureName: manufactureName ?? _manufactureName,
);
  int? get manufactureId => _manufactureId;
  String? get manufactureName => _manufactureName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ManufactureId'] = _manufactureId;
    map['ManufactureName'] = _manufactureName;
    return map;
  }

}