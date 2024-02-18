import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:report/Functions/function.dart';
import 'package:report/Models/model.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController addController = TextEditingController();

  final TextEditingController batchController = TextEditingController();
  String? selectedValue1;
  String? selectedValue2;

  @override
  void initState() {
    if (batchList.isNotEmpty) {
      batchController.text = batchList[0].batch;
    }
    if (list.isNotEmpty) {
      selectedValue1 = list[0].one;
      selectedValue2 = list[0].two;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit")),
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
            TextField(
              controller: addController,
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
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 20,
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () async {
                  if (batchController.text.isNotEmpty &&
                      membersList.value.length >= 2) {
                    await addBatch(
                      batch: BatchModel(
                        id: "1",
                        batch: batchController.text,
                      ),
                    );
                    await refresh();
                    Navigator.pop(context);
                  } else if (batchController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text("Add batch"),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text("Add members"),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
