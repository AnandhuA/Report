import 'package:hive_flutter/adapters.dart';

part 'model.g.dart';

@HiveType(typeId: 1)
class CoordinatorModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String one;
  @HiveField(2)
  final String two;

  CoordinatorModel({
    required this.id,
    required this.one,
    required this.two,
  });
}

@HiveType(typeId: 2)
class MembersModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String member;
  @HiveField(2)
  bool check;
  @HiveField(3)
  String reason;

  MembersModel(
      {required this.id,
      required this.member,
      required this.check,
      this.reason = "No Reason"});
}

@HiveType(typeId: 3)
class BatchModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String batch;

  BatchModel({
    required this.id,
    required this.batch,
  });
}
