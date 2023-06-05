import 'package:hive/hive.dart';

part 'hive_user_model.g.dart';

@HiveType(typeId: 1)
class HiveUserModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

  HiveUserModel({
    required this.id,
    required this.name
  });
}