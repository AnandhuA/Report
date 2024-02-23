import 'package:flutter/material.dart';
import 'package:report/Functions/function.dart';
import 'package:report/Widget/time.dart';

class SectionReport extends StatelessWidget {
  final String date;
  final TextEditingController venueController;
  final TextEditingController activityController;
  final TextEditingController reportController;
  final TextEditingController nameController;
  const SectionReport({
    super.key,
    required this.activityController,
    required this.date,
    required this.nameController,
    required this.reportController,
    required this.venueController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const Text(
          "🙋‍♂️Participants:",
        ),
        const Text("   "),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: membersList.value.length,
          itemBuilder: (context, index) {
            return membersList.value[index].check
                ? Text(
                    "✅${membersList.value[index].member}",
                  )
                : const SizedBox();
          },
        ),
        const Text("     "),
        const Text(
          "🙅🏻‍♀Absentees 🛑:",
        ),
        const Text("     "),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: membersList.value.length,
          itemBuilder: (context, index) {
            return !membersList.value[index].check
                ? membersList.value[index].reason == "No Reason"
                    ? Text(
                        "❌${membersList.value[index].member}",
                      )
                    : Text(
                        "❌${membersList.value[index].member} (${membersList.value[index].reason})",
                      )
                : const SizedBox();
          },
        ),
        const Text(" "),
        const Text(
          " Prepared by",
        ),
        Text(
          nameController.text,
        ),
      ],
    );
  }
}
