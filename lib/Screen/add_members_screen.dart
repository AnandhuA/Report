import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:report/Functions/function.dart';
import 'package:report/Models/model.dart';

class AddMembersScreen extends StatelessWidget {
  AddMembersScreen({super.key});

  final TextEditingController addController = TextEditingController();
  final TextEditingController batchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add",
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () async {
              if (batchController.text.isNotEmpty &&
                  membersList.value.length >= 2) {
                addBatch(
                  batch: BatchModel(
                    id: "1",
                    batch: batchController.text,
                  ),
                );
                add(
                  coodinator: CoordinatorModel(
                    id: "123",
                    one: membersList.value[0].member,
                    two: membersList.value[0].member,
                  ),
                );
                await refresh();
                Navigator.pushNamed(context, "select");
              } else if (batchController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text("Add Batch"),
                  backgroundColor: Colors.red,
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text("Add members"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text(
              "Add",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TextField(
              controller: batchController,
              decoration: const InputDecoration(
                label: Text("Batch"),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: membersList,
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: membersList.value.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        key: Key(membersList.value[index].id),
                        endActionPane: ActionPane(
                          extentRatio: 0.2,
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.red.shade100,
                              autoClose: true,
                              onPressed: (ctx) {
                                removeMember(
                                  member: membersList.value[index],
                                );
                                refresh();
                              },
                              foregroundColor: Colors.red,
                              icon: Icons.delete,
                              label: "Delete",
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Text(
                              membersList.value[index].member[0],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text(
                            membersList.value[index].member,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            TextField(
              controller: addController,
              textInputAction: TextInputAction.send,
              decoration: InputDecoration(
                label: const Text(
                  "Add Members",
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (addController.text.isNotEmpty) {
                      addMembers(
                        members: MembersModel(
                          id: DateTime.now().microsecondsSinceEpoch.toString(),
                          member: addController.text,
                          check: false,
                        ),
                      );
                      refresh();
                      addController.clear();
                    }
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  icon: const CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              onSubmitted: (String value) {
                if (value.isNotEmpty) {
                  addMembers(
                    members: MembersModel(
                      id: DateTime.now().microsecondsSinceEpoch.toString(),
                      member: value,
                      check: false,
                    ),
                  );
                  refresh();
                  addController.clear();
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
