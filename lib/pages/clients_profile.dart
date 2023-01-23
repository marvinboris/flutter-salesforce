import 'dart:math';

import 'package:flutter/material.dart';

import '../models/appointment.dart';
import '../models/client.dart';
import '../models/shop.dart';

import '../widgets/helpers/dates.dart';
import '../widgets/ui_elements/blocks/appointment.dart';
import '../widgets/ui_elements/blocks/client_shop.dart';
import '../widgets/ui_elements/buttons.dart';
import '../widgets/ui_elements/navigation/bottom_navigation_bar.dart';
import '../widgets/ui_elements/navigation/header.dart';
import '../widgets/ui_elements/navigation/section_title.dart';
import '../widgets/ui_elements/title.dart';

class ClientsProfilePage extends StatefulWidget {
  final Client client;

  const ClientsProfilePage(
    this.client, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _ClientsProfilePageState();
  }
}

class _ClientsProfilePageState extends State<ClientsProfilePage> {
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
          color: Colors.white.withOpacity(.5),
          size: 18,
        ),
        const SizedBox(width: 10),
        UITitle(
          value,
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontFamily: 'Euclid Circular A',
          fontSize: 14,
        ),
      ],
    );
  }

  Widget _buildInfo(
    BuildContext context, {
    required String child,
    IconData? icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.3),
        borderRadius: BorderRadius.circular(300),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      child: Row(
        children: [
          Text(
            child,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'Euclid Circular A',
              fontSize: 14,
            ),
          ),
          icon != null
              ? Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: Icon(
                    icon,
                    size: 14,
                    color: Colors.white,
                  ),
                )
              : Container(),
        ],
      ),
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
          icon: Icons.place_outlined,
          value: widget.client.location,
        ),
        const SizedBox(height: 8),
        _buildDescription(
          context,
          icon: Icons.phone_outlined,
          value: widget.client.phone,
        ),
        const SizedBox(height: 8),
        _buildDescription(
          context,
          icon: Icons.mail_outlined,
          value: widget.client.email,
        ),
        const SizedBox(height: 17),
        Row(
          children: [
            _buildInfo(
              context,
              child: widget.client.status == ClientStatus.Active
                  ? 'Active'
                  : 'Inactive',
              icon: widget.client.status == ClientStatus.Active
                  ? Icons.check_circle_outlined
                  : null,
            ),
            const SizedBox(width: 10),
            _buildInfo(
              context,
              child: 'Since:  ${Dates.date(widget.client.joinedAt!)}',
            ),
          ],
        )
      ],
    );
  }

  Widget _buildAppointmentList(
    BuildContext context,
  ) {
    final List<Appointment> appointments = [
      Appointment(
        id: Random().toString(),
        date: DateTime(2023, 10, 18),
        name: 'Joseph Kamdem',
        shop: 'Santa Lucia',
        object: 'Stock replenish',
        location: 'DLA - Bonamoussadi, face...',
        company: 'Chococam Dla',
      ),
      Appointment(
        id: Random().toString(),
        date: DateTime(2023, 10, 16),
        name: 'Joseph Kamdem',
        shop: 'Santa Lucia',
        object: 'Stock replenish',
        location: 'DLA - Bonanjo messapresse...',
        company: 'Fashion Bestifier',
        status: AppointmentStatus.Done,
      ),
      Appointment(
        id: Random().toString(),
        date: DateTime(2023, 10, 14),
        name: 'Joseph Kamdem',
        shop: 'Santa Lucia',
        object: 'Stock replenish',
        location: 'DLA - Bonanjo messapresse...',
        company: 'Fashion Bestifier',
        status: AppointmentStatus.Cancelled,
      ),
    ];
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: appointments.length,
        itemBuilder: (context, index) => UIAppointmentBlock(
          appointments[index],
          client: true,
        ),
      ),
    );
  }

  Widget _buildShopList(
    BuildContext context,
  ) {
    final List<Shop> shops = [
      Shop(
        manager: 'Joseph Kamdem',
        name: 'Santa Lucia',
        location: 'Santa Lucia - DLA, Cite Cic',
        phone: '(237) 698 90 11 22 33',
        email: 'demo@contact.com',
        photo: 'santa-lucia.jpg',
      ),
      Shop(
        manager: 'Joseph Kamdem',
        name: 'Santa Lucia',
        location: 'Santa Lucia - DLA...',
        phone: '(237) 698 90 11 22 33',
        email: 'demo@contact.com',
        photo: 'santa-lucia.jpg',
      ),
      Shop(
        manager: 'Joseph Kamdem',
        name: 'Santa Lucia',
        location: 'Bonanjo - DLA...',
        phone: '(237) 698 90 11 22 33',
        email: 'demo@contact.com',
        photo: 'santa-lucia.jpg',
      ),
    ];
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: shops.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
          child: UIClientShopBlock(shops[index]),
        ),
      ),
    );
  }

  Widget _buildViewAll(
    BuildContext context, {
    required String href,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: UIIconTextButton(
        'VIEW ALL',
        color: Theme.of(context).primaryColor,
        icon: Icons.arrow_forward,
        onPressed: () => Navigator.of(context).pushNamed(href),
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
              title: widget.client.name,
              image: widget.client.photo != null
                  ? 'clients/${widget.client.photo}'
                  : null,
              action: _buildHeaderAction(context),
            ),
            const SizedBox(height: 34),
            UISectionTitle(
              title: 'Scheduled Meeting',
              subtitle: 'Appointments',
              addon: _buildViewAll(
                context,
                href: '/clients/schedule',
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: _buildAppointmentList(context),
            ),
            const SizedBox(height: 44),
            UISectionTitle(
              title: 'Client’s Shops',
              subtitle: 'Registered shops',
              addon: _buildViewAll(
                context,
                href: '/clients/${widget.client.id}/shops',
              ),
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
