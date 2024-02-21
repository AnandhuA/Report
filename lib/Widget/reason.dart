import 'package:flutter/material.dart';

import '../Functions/function.dart';
import '../Models/model.dart';

class Reason extends StatelessWidget {
  final String selectedRadio;
  final int index;

  const Reason({
    super.key,
    required this.index,
    required this.selectedRadio,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const Text("Absent"),
              Radio(
                value: "Absent",
                groupValue: selectedRadio,
                onChanged: (val) async {
                  if (val != null) {
                    await addMembers(
                      members: MembersModel(
                        id: membersList.value[index].id,
                        member: membersList.value[index].member,
                        check: membersList.value[index].check,
                        reason: val,
                      ),
                    );
                    await refresh();
                  }
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text("Review"),
              Radio(
                value: "Review",
                groupValue: selectedRadio,
                onChanged: (val) async {
                  if (val != null) {
                    await addMembers(
                      members: MembersModel(
                        id: membersList.value[index].id,
                        member: membersList.value[index].member,
                        check: membersList.value[index].check,
                        reason: val,
                      ),
                    );
                    await refresh();
                  }
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text("No Reason"),
              Radio(
                value: "No Reason",
                groupValue: selectedRadio,
                onChanged: (val) async {
                  if (val != null) {
                    await addMembers(
                      members: MembersModel(
                        id: membersList.value[index].id,
                        member: membersList.value[index].member,
                        check: membersList.value[index].check,
                        reason: val,
                      ),
                    );
                    await refresh();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
