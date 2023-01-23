import 'package:flutter/material.dart';
import 'package:salesforce/widgets/ui_elements/blocks/client_shop.dart';

import '../models/client.dart';
import '../models/shop.dart';

import '../widgets/ui_elements/navigation/bottom_navigation_bar.dart';
import '../widgets/ui_elements/navigation/header.dart';
import '../widgets/ui_elements/navigation/section_title.dart';
import '../widgets/ui_elements/title.dart';

class ClientsShopsPage extends StatefulWidget {
  final Client client;
  final List<Shop> shops;

  const ClientsShopsPage(
    this.client,
    this.shops, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _ClientsShopsPageState();
  }
}

class _ClientsShopsPageState extends State<ClientsShopsPage> {
  Widget _buildDescription(
    BuildContext context, {
    required IconData icon,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
        const SizedBox(width: 10),
        UITitle(
          value,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontFamily: 'Euclid Circular A',
          fontSize: 18,
        ),
      ],
    );
  }

  Widget _buildHeaderAction(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDescription(
          context,
          icon: Icons.person_outlined,
          value: widget.client.name,
        ),
        const SizedBox(height: 26),
      ],
    );
  }

  Widget _buildShopList(
    BuildContext context,
  ) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.shops.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(top: index == 0 ? 0 : 32),
          child: UIClientShopBlock(
            widget.shops[index],
            big: true,
          ),
        ),
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
              title: 'Shops',
              action: _buildHeaderAction(context),
              actionText: 'Add Shop',
              actionIcon: Icons.add,
              actionPressed: () {},
            ),
            const SizedBox(height: 34),
            const UISectionTitle(
              title: 'Client’s Shops',
              subtitle: 'Manage Shops',
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: _buildShopList(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const UIBottomNavigationBar(),
    );
  }
}
