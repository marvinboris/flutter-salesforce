import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

import '../widgets/ui_elements/navigation/bottom_navigation_bar.dart';
import '../widgets/ui_elements/pages/dashboard/header.dart';
import '../widgets/ui_elements/pages/dashboard/history.dart';
import '../widgets/ui_elements/pages/dashboard/sales.dart';
import '../widgets/ui_elements/pages/dashboard/schedule.dart';

class DashboardPage extends StatefulWidget {
  final MainModel model;

  const DashboardPage(
    this.model, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _DashboardPageState();
  }
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    widget.model.fetchAppointments();
    widget.model.fetchClients();
    widget.model.fetchInvoices();
    widget.model.fetchMethods();
    widget.model.fetchProducts();
    widget.model.fetchShops();
    widget.model.fetchStops();
    widget.model.fetchTransactions();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      ScopedModelDescendant(
        builder: (
          context,
          child,
          MainModel model,
        ) =>
            Scaffold(
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
                  children: [
                    DashboardHeader(model),
                    const SizedBox(height: 43),
                    const DashboardSales(
                      realSales: 340000,
                      expectedSales: 340000,
                    ),
                    const SizedBox(height: 31),
                    DashboardSchedule(model),
                    const SizedBox(height: 31),
                    DashboardHistory(model),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: const UIBottomNavigationBar(white: true),
        ),
      );
}
