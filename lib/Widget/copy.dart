import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:report/Functions/function.dart';
import 'package:report/Widget/time.dart';

void copyToClipboardSection({
  required String text,
  required TextEditingController venueController,
  required TextEditingController activityController,
  required TextEditingController reportController,
  required TextEditingController nameController,
  required String date,
}) {
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
      lines.add(
        '✅ ${membersList.value[i].member}',
      );
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
        lines.add(
          '❌ ${membersList.value[i].member}',
        );
      } else {
        lines.add(
          '❌ ${membersList.value[i].member} (${membersList.value[i].reason})',
        );
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

  Clipboard.setData(ClipboardData(
    text: finalText,
  ));
}

void copyToClipboardAudio({
  required String text,
  required String date,
}) {
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
