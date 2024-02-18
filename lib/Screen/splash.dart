import 'package:flutter/material.dart';
import 'package:report/Functions/function.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    check(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "images/311567732_495713189237721_7924565859957481057_n.jpg",
          width: 150,
        ),
      ),
    );
  }

  void check(context) async {
    await refresh();
    if (list.isEmpty || membersList.value.isEmpty || batchList.isEmpty) {
      Navigator.pushReplacementNamed(context, "Add");
    } else {
      Navigator.pushReplacementNamed(context, "homePage");
    }
  }
}
