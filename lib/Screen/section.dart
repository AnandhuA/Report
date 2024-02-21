import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:report/Functions/function.dart';
import 'package:report/Models/model.dart';
import 'package:report/Widget/reason.dart';
import 'package:report/Widget/time.dart';

class Section extends StatefulWidget {
  const Section({super.key});

  @override
  State<Section> createState() => _SectionState();
}

class _SectionState extends State<Section> {
  String data = "";
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  TextEditingController reportController = TextEditingController();

  String date = DateFormat('dd MMM yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: data.isEmpty
            ? SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter venue";
                          }
                          return null;
                        },
                        controller: venueController,
                        decoration: const InputDecoration(
                          hintText: "Venue",
                          icon: Icon(Icons.place_outlined),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const TimePickerWidegt(),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter activity";
                          }
                          return null;
                        },
                        controller: activityController,
                        decoration: const InputDecoration(
                          hintText: "Activity",
                          icon: Icon(Icons.topic_outlined),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter report";
                          }
                          return null;
                        },
                        controller: reportController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: "Report",
                          icon: Icon(Icons.note_add_outlined),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter name";
                          }
                          return null;
                        },
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: "Reported by",
                          icon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ValueListenableBuilder(
                        valueListenable: membersList,
                        builder: (context, value, child) {
                          return SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                membersList.value.length,
                                (index) {
                                  String selectedRadio =
                                      membersList.value[index].reason;
                                  return Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          setState(() {
                                            membersList.value[index].check =
                                                !membersList.value[index].check;
                                          });
                                        },
                                        leading: CircleAvatar(
                                          backgroundColor:
                                              membersList.value[index].check
                                                  ? Colors.green.shade200
                                                  : Colors.red.shade200,
                                          child: Text(
                                            membersList.value[index].member[0],
                                          ),
                                        ),
                                        title: Text(
                                          membersList.value[index].member,
                                          style: TextStyle(
                                            color:
                                                membersList.value[index].check
                                                    ? Colors.black
                                                    : Colors.red.shade500,
                                          ),
                                        ),
                                        trailing: Checkbox(
                                          activeColor: Colors.green,
                                          value: membersList.value[index].check,
                                          onChanged: (value) async {
                                            if (value != null) {
                                              await addMembers(
                                                members: MembersModel(
                                                  id: membersList
                                                      .value[index].id,
                                                  member: membersList
                                                      .value[index].member,
                                                  check: value,
                                                ),
                                              );
                                              await refresh();
                                            }
                                          },
                                        ),
                                      ),
                                      !membersList.value[index].check
                                          ? Reason(
                                              index: index,
                                              selectedRadio: selectedRadio,
                                            )
                                          : const SizedBox(),
                                      const Divider()
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (getSelectedTime().isNotEmpty) {
                                setState(() {
                                  data = "data";
                                });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Text("Select Time"),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("📃 Session Report"),
                    const Text(" "),
                    Text("📅 $date"),
                    Text("⏰ Time : ${getSelectedTime()}"),
                    Text("📍 Venue : ${venueController.text}"),
                    const Text(" "),
                    Text(" Batch : ${batchList[0].batch}"),
                    const Text(" "),
                    const Text("🧑‍✈️Coordinators"),
                    const Text("   "),
                    Text("🧑‍💻${list[0].one}"),
                    Text("👨‍💻${list[0].two}"),
                    const Text("-------------------------------------"),
                    Text("Activity : ${activityController.text}"),
                    const Text("   "),
                    Text(reportController.text),
                    const Text(" "),
                    const Text("🙋‍♂️Participants:"),
                    const Text("   "),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: membersList.value.length,
                      itemBuilder: (context, index) {
                        return membersList.value[index].check
                            ? Text("✅${membersList.value[index].member}")
                            : const SizedBox();
                      },
                    ),
                    const Text("     "),
                    const Text("🙅🏻‍♀Absentees 🛑:"),
                    const Text("     "),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: membersList.value.length,
                      itemBuilder: (context, index) {
                        return !membersList.value[index].check
                            ? membersList.value[index].reason == "No Reason"
                                ? Text("❌${membersList.value[index].member}")
                                : Text(
                                    "❌${membersList.value[index].member} (${membersList.value[index].reason})",
                                  )
                            : const SizedBox();
                      },
                    ),
                    const Text(" "),
                    const Text(" Prepared by"),
                    Text(nameController.text),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {
                              _copyToClipboard(data);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Text copied to clipboard'),
                                ),
                              );
                            },
                            child: const Text(
                              "Copy",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {
                              setState(() {
                                data = "";
                              });
                            },
                            child: const Text(
                              "Back",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }

  void _copyToClipboard(String text) {
    List<String> lines = [
      '📃 Session Report',
      '‎ ',
      '📅 $date',
      '⏰ Time : ${getSelectedTime()}',
      '📍 Venue : ${venueController.text}',
      '‎ ',
      ' Batch : ${batchList[0].batch}'
          '‎ ',
      '🧑‍✈️Coordinators',
      '‎ ',
      '🧑‍💻${list[0].one}',
      '👨‍💻${list[0].two}',
      '-------------------------------------',
      'Activity : ${activityController.text}',
      '‎ ',
      '${reportController.text} ',
      '‎ ',
      '🙋‍♂️Participants:',
      '‎ ',
    ];

    for (int i = 0; i < membersList.value.length; i++) {
      if (membersList.value[i].check == true) {
        lines.add('✅ ${membersList.value[i].member}');
      }
    }

    lines.addAll([
      '‎ ',
      '‎ ',
      '🙅🏻‍♀Absentees 🛑:',
      '‎ ',
    ]);

    for (int i = 0; i < membersList.value.length; i++) {
      if (membersList.value[i].check == false) {
        if (membersList.value[i].reason == "No Reason") {
          lines.add('❌ ${membersList.value[i].member}');
        } else {
          lines.add(
              '❌ ${membersList.value[i].member} (${membersList.value[i].reason})');
        }
      }
    }
    lines.addAll([
      '‎ ',
      '‎ ',
      'Prepared by',
      '‎ ',
      '${nameController.text} ',
    ]);

    String finalText = lines.where((line) => line.isNotEmpty).join('\n');

    Clipboard.setData(ClipboardData(text: finalText));
  }
}
