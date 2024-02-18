import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:report/Functions/function.dart';
import 'package:report/Models/model.dart';
import 'package:report/Screen/add_members_screen.dart';
import 'package:report/Screen/home_page.dart';
import 'package:report/Screen/splash.dart';
import 'package:report/Widget/select_coordinators.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CoordinatorModelAdapter().typeId)) {
    Hive.registerAdapter(CoordinatorModelAdapter());
  }
  if (!Hive.isAdapterRegistered(MembersModelAdapter().typeId)) {
    Hive.registerAdapter(MembersModelAdapter());
  }
  if (!Hive.isAdapterRegistered(BatchModelAdapter().typeId)) {
    Hive.registerAdapter(BatchModelAdapter());
  }
  await refresh();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "homePage": (context) => const HomePage(),
        "Add": (context) => AddMembersScreen(),
        "select": (context) => const SelectCoordinators()
      },
      home: const SplashScreen(),
    );
  }
}
