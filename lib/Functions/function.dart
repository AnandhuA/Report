// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:report/Models/model.dart';

List<CoordinatorModel> list = [];

List<BatchModel> batchList = [];

final ValueNotifier<List<MembersModel>> membersList = ValueNotifier([]);

add({required CoordinatorModel coodinator}) async {
  final box = await Hive.openBox<CoordinatorModel>("database");
  box.put(coodinator.id, coodinator);
}

Future<List<CoordinatorModel>> get() async {
  final box = await Hive.openBox<CoordinatorModel>("database");
  return box.values.toList();
}

addBatch({required BatchModel batch}) async {
  final batchBox = await Hive.openBox<BatchModel>("batchDB");
  batchBox.put(batch.id, batch);
}

Future<List<BatchModel>> getBatch() async {
  final batchBox = await Hive.openBox<BatchModel>("batchDB");
  return batchBox.values.toList();
}

addMembers({required MembersModel members}) async {
  final memberBox = await Hive.openBox<MembersModel>("MemberDB");
  memberBox.put(members.id, members);
}

removeMember({required MembersModel member}) async {
  final memberBox = await Hive.openBox<MembersModel>("MemberDB");
  memberBox.delete(member.id);
}

Future<List<MembersModel>> getMembers() async {
  final memberBox = await Hive.openBox<MembersModel>("MemberDB");
  return memberBox.values.toList();
}

refresh() async {
  final coordinator = await get();
  final members = await getMembers();
  final batch = await getBatch();
  batchList.clear();
  membersList.value.clear();
  list.clear();
  batchList = List.from(batch);
  membersList.value = List.from(members);
  list = List.from(coordinator);
  membersList.notifyListeners();
}
