import 'package:flutter/material.dart';
import 'package:report/Functions/function.dart';
import 'package:report/Models/model.dart';

class SelectCoordinators extends StatefulWidget {
  const SelectCoordinators({super.key});

  @override
  State<SelectCoordinators> createState() => _SelectStateCoordinators();
}

class _SelectStateCoordinators extends State<SelectCoordinators> {
  String? selectedValue1;
  String? selectedValue2;
  String first = "";
  String second = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Coordinators"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: 'Select',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            value: selectedValue1,
            onChanged: (String? newValue) {
              setState(() {
                selectedValue1 = newValue;
              });
            },
            items: membersList.value
                .map<DropdownMenuItem<String>>((MembersModel value) {
              return DropdownMenuItem<String>(
                value: value.id,
                child: Text(value.member),
                onTap: () {
                  first = value.member;
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: 'Select',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            value: selectedValue2,
            onChanged: (String? newValue) {
              setState(() {
                selectedValue2 = newValue;
              });
            },
            items: membersList.value
                .map<DropdownMenuItem<String>>((MembersModel value) {
              return DropdownMenuItem<String>(
                value: value.id,
                child: Text(value.member),
                onTap: () {
                  second = value.member;
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () async {
                if (first != second &&
                    selectedValue1 != null &&
                    selectedValue2 != null) {
                  final coodinator = CoordinatorModel(
                    id: "123",
                    one: first,
                    two: second,
                  );
                  await add(coodinator: coodinator);
                  await refresh();
                  Navigator.pushNamedAndRemoveUntil(
                      context, "homePage", (route) => false);
                } else if (selectedValue1 == selectedValue2) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text("Same Coordinators"),
                    backgroundColor: Colors.red,
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text(" Select "),
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
          )
        ]),
      ),
    );
  }
}
