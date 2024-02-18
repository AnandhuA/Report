import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:report/Functions/function.dart';
import 'package:report/Models/model.dart';
import 'package:report/Widget/reason.dart';

class Audio extends StatefulWidget {
  const Audio({super.key});

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  String data = "";

  String date = DateFormat('dd MMM yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: data.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: membersList,
                        builder: (context, value, child) {
                          return ListView.builder(
                            itemCount: membersList.value.length,
                            itemBuilder: (context, index) {
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
                                        color: membersList.value[index].check
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
                                              id: membersList.value[index].id,
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
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () {
                          setState(() {
                            data = "data";
                          });
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("🎙Audio  Report🎙️"),
                      Text("💻 Batch : ${batchList[0].batch}"),
                      Text("📆 $date"),
                      const Text("   "),
                      const Text("🧑‍✈️Coordinators"),
                      Text("🧑‍💻${list[0].one}"),
                      Text("👨‍💻${list[0].two}"),
                      const Text("   "),
                      const Text("-------------------------------------"),
                      const Text("   "),
                      const Text("Submitted"),
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
                      const Text("Not Submitted"),
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
      ),
    );
  }

  void _copyToClipboard(String text) {
    List<String> lines = [
      '🎙Audio Submission Report🎙️',
      '💻 Batch : ${batchList[0].batch}',
      '📆 $date',
      '‎ ',
      '🧑‍✈️Coordinators',
      '‎ ',
      '🧑‍💻 ${list[0].one}',
      '👨‍💻${list[0].two}',
      '-------------------------------------',
      '‎ ',
      'Submitted',
      '‎ ',
    ];

    for (int i = 0; i < membersList.value.length; i++) {
      if (membersList.value[i].check == true) {
        lines.add('✅ ${membersList.value[i].member}');
      }
    }

    lines.addAll([
      '‎ ',
      '‎ '
          'Not Submitted',
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

    String finalText = lines.join('\n');

    Clipboard.setData(ClipboardData(text: finalText));
  }
}
