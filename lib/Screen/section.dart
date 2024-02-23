import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:report/Functions/function.dart';
import 'package:report/Widget/copy.dart';
import 'package:report/Widget/list_tile.dart';
import 'package:report/Widget/section_report.dart';
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
                          icon: Icon(
                            Icons.place_outlined,
                          ),
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
                          icon: Icon(
                            Icons.topic_outlined,
                          ),
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
                          icon: Icon(
                            Icons.note_add_outlined,
                          ),
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
                          icon: Icon(
                            Icons.person_outline,
                          ),
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
                                  return ListTileWidget(
                                    index: index,
                                    selectedRadio: selectedRadio,
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
                            backgroundColor: Colors.black,
                          ),
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
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SectionReport(
                      activityController: activityController,
                      date: date,
                      nameController: nameController,
                      reportController: reportController,
                      venueController: venueController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () {
                              copyToClipboardSection(
                                text: data,
                                venueController: venueController,
                                activityController: activityController,
                                reportController: reportController,
                                nameController: nameController,
                                date: date,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Text copied to clipboard',
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "Copy",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                data = "";
                              });
                            },
                            child: const Text(
                              "Back",
                              style: TextStyle(
                                color: Colors.white,
                              ),
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
}
