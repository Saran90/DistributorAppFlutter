import 'dart:convert';
/// AllCustomerLocation : [{"Location":"ADIMALY "}]

LocationDataResponse locationDataResponseFromJson(String str) => LocationDataResponse.fromJson(json.decode(str));
String locationDataResponseToJson(LocationDataResponse data) => json.encode(data.toJson());
class LocationDataResponse {
  LocationDataResponse({
      List<AllCustomerLocation>? allCustomerLocation,}){
    _allCustomerLocation = allCustomerLocation;
}

  LocationDataResponse.fromJson(dynamic json) {
    if (json['AllCustomerLocation'] != null) {
      _allCustomerLocation = [];
      json['AllCustomerLocation'].forEach((v) {
        _allCustomerLocation?.add(AllCustomerLocation.fromJson(v));
      });
    }
  }
  List<AllCustomerLocation>? _allCustomerLocation;
LocationDataResponse copyWith({  List<AllCustomerLocation>? allCustomerLocation,
}) => LocationDataResponse(  allCustomerLocation: allCustomerLocation ?? _allCustomerLocation,
);
  List<AllCustomerLocation>? get allCustomerLocation => _allCustomerLocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_allCustomerLocation != null) {
      map['AllCustomerLocation'] = _allCustomerLocation?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Location : "ADIMALY "

AllCustomerLocation allCustomerLocationFromJson(String str) => AllCustomerLocation.fromJson(json.decode(str));
String allCustomerLocationToJson(AllCustomerLocation data) => json.encode(data.toJson());
class AllCustomerLocation {
  AllCustomerLocation({
      String? location,}){
    _location = location;
}

  AllCustomerLocation.fromJson(dynamic json) {
    _location = json['Location'];
  }
  String? _location;
AllCustomerLocation copyWith({  String? location,
}) => AllCustomerLocation(  location: location ?? _location,
);
  String? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Location'] = _location;
    return map;
  }

}