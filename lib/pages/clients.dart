import 'dart:math';

import 'package:flutter/material.dart';

import '../models/client.dart';

import '../widgets/ui_elements/blocks/client.dart';
import '../widgets/ui_elements/navigation/bottom_navigation_bar.dart';
import '../widgets/ui_elements/navigation/header.dart';
import '../widgets/ui_elements/navigation/section_title.dart';

class MyClientsPage extends StatefulWidget {
  const MyClientsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyClientsStatePage();
  }
}

class _MyClientsStatePage extends State<MyClientsPage> {
  Widget _buildClientList(
    BuildContext context,
  ) {
    final List<Client> clients = [
      Client(
        id: Random().toString(),
        name: 'Joseph Kamdem',
        location: 'Santa Lucia - DLA, Cite Cic',
        phone: '(237) 698 90 11 22 33',
        email: 'demo@contact.com',
        joinedAt: DateTime(2023, 3, 10),
        photo: 'joseph-kamdem.png',
      ),
      Client(
        id: Random().toString(),
        name: 'Chisela Mariolena',
        location: 'Santa Lucia - DLA...',
        phone: '(237) 698 90 11 22 33',
        email: 'demo@contact.com',
        joinedAt: DateTime(2023, 3, 10),
        photo: 'chisela-mariolena.png',
        status: ClientStatus.Inactive,
      ),
      Client(
        id: Random().toString(),
        name: 'Minetosina Bond',
        location: 'Bonanjo - DLA...',
        phone: '(237) 698 90 11 22 33',
        email: 'demo@contact.com',
        joinedAt: DateTime(2023, 3, 10),
        photo: 'minetosina-bond.png',
      ),
    ];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: clients.length,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
        child: UIClientBlock(clients[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: _buildClientList(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const UIBottomNavigationBar(),
    );
  }
}
