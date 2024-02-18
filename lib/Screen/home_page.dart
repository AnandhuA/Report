import 'package:flutter/material.dart';
import 'package:report/Functions/function.dart';
import 'package:report/Screen/audio.dart';
import 'package:report/Screen/edit_screen.dart';
import 'package:report/Screen/section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    tab = TabController(length: 2, vsync: this);
  }

  TabController? tab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report"),
        bottom: TabBar(
          controller: tab,
          tabs: const [
            Tab(
              text: "Audio",
            ),
            Tab(
              text: "Section",
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.only(top: 150),
          children: [
            const Center(
                child: Text(
              "Coordinators",
              style: TextStyle(fontSize: 20),
            )),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
              ),
              title: Text(list[0].one),
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
              ),
              title: Text(list[0].two),
            ),
            ListTile(
              leading: const Icon(
                Icons.person_add,
                color: Colors.blue,
              ),
              title: const Text(
                'Change Coordinators',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "select",
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.edit,
                color: Colors.blue,
              ),
              title: const Text(
                'Edit',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tab,
        children: const [
          Audio(),
          Section(),
        ],
      ),
    );
  }
}
