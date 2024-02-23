import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:report/Functions/function.dart';
import 'package:report/Widget/audio_report.dart';
import 'package:report/Widget/copy.dart';
import 'package:report/Widget/list_tile.dart';

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
                              return ListTileWidget(
                                index: index,
                                selectedRadio: selectedRadio,
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
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            data = "data";
                          });
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
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AudioReport(date: date),
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
                                copyToClipboardAudio(
                                  text: data,
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
      ),
    );
  }
}
