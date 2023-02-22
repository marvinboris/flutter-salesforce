import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/client.dart';

import '../scoped_models/main.dart';

import '../widgets/ui_elements/blocks/client.dart';
import '../widgets/ui_elements/navigation/bottom_navigation_bar.dart';
import '../widgets/ui_elements/navigation/header.dart';
import '../widgets/ui_elements/navigation/section_title.dart';

class MyClientsPage extends StatefulWidget {
  final MainModel model;

  const MyClientsPage(
    this.model, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _MyClientsStatePage();
  }
}

class _MyClientsStatePage extends State<MyClientsPage> {
  @override
  void initState() {
    widget.model.fetchClients();
    super.initState();
  }

  Widget _buildClientList(
    List<Client> clients,
  ) =>
      ListView.builder(
        shrinkWrap: true,
        itemCount: clients.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
          child: UIClientBlock(clients[index]),
        ),
      );

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
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 115),
            child: Column(
              children: [
                UIHeader(
                  title: 'My Clients',
                  subtitle:
                      'All your clients will be displayed on this page. Add or Edit client’s information',
                  actionText: 'Add Client',
                  actionIcon: Icons.add,
                  actionPressed: () =>
                      Navigator.of(context).pushNamed('/clients/add'),
                ),
                const SizedBox(height: 34),
                const UISectionTitle(
                  title: 'My Clients',
                  subtitle: 'Manage Clients',
                ),
                const SizedBox(height: 34),
                Container(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: _buildClientList(model.allClients),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const UIBottomNavigationBar(),
        ),
      );
}
