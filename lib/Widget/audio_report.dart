import 'package:flutter/material.dart';
import 'package:report/Functions/function.dart';

class AudioReport extends StatelessWidget {
  final String date;
  const AudioReport({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
