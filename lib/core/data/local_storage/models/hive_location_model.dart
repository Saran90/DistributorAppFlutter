import 'package:hive/hive.dart';

part 'hive_location_model.g.dart';

@HiveType(typeId: 4)
class HiveLocationModel extends HiveObject {
  @HiveField(0)
  String? text;

  HiveLocationModel({this.text});
}
