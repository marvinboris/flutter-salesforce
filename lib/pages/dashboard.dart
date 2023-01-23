import 'package:flutter/material.dart';

import '../widgets/ui_elements/navigation/bottom_navigation_bar.dart';
import '../widgets/ui_elements/pages/dashboard/header.dart';
import '../widgets/ui_elements/pages/dashboard/history.dart';
import '../widgets/ui_elements/pages/dashboard/sales.dart';
import '../widgets/ui_elements/pages/dashboard/schedule.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashboardPageState();
  }
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).secondaryHeaderColor,
                Theme.of(context).primaryColor,
              ]),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              left: 32,
              right: 32,
              top: 64,
              bottom: 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                DashboardHeader(),
                SizedBox(height: 43),
                DashboardSales(
                  realSales: 340000,
                  expectedSales: 340000,
                ),
                SizedBox(height: 31),
                DashboardSchedule(),
                SizedBox(height: 31),
                DashboardHistory(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const UIBottomNavigationBar(white: true),
    );
  }
}
