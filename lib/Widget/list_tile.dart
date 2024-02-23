import 'package:flutter/material.dart';
import 'package:report/Functions/function.dart';
import 'package:report/Models/model.dart';
import 'package:report/Widget/reason.dart';

class ListTileWidget extends StatefulWidget {
  final int index;
  final String selectedRadio;
  const ListTileWidget({
    super.key,
    required this.index,
    required this.selectedRadio
  });

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() {
              membersList.value[widget.index].check =
                  !membersList.value[widget.index].check;
            });
          },
          leading: CircleAvatar(
            backgroundColor: membersList.value[widget.index].check
                ? Colors.green.shade200
                : Colors.red.shade200,
            child: Text(
              membersList.value[widget.index].member[0],
            ),
          ),
          title: Text(
            membersList.value[widget.index].member,
            style: TextStyle(
              color: membersList.value[widget.index].check
                  ? Colors.black
                  : Colors.red.shade500,
            ),
          ),
          trailing: Checkbox(
            activeColor: Colors.green,
            value: membersList.value[widget.index].check,
            onChanged: (value) async {
              if (value != null) {
                await addMembers(
                  members: MembersModel(
                    id: membersList.value[widget.index].id,
                    member: membersList.value[widget.index].member,
                    check: value,
                  ),
                );
                await refresh();
              }
            },
          ),
        ),
        !membersList.value[widget.index].check
            ? Reason(
                index: widget.index,
                selectedRadio:widget.selectedRadio,
              )
            : const SizedBox(),
        const Divider()
      ],
    );
  }
}
