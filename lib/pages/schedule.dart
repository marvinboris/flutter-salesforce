import 'dart:math';

import 'package:flutter/material.dart';
import 'package:salesforce/widgets/ui_elements/navigation/section_title.dart';

import '../models/appointment.dart';

import '../widgets/ui_elements/blocks/appointment.dart';
import '../widgets/ui_elements/form/search.dart';
import '../widgets/ui_elements/navigation/bottom_navigation_bar.dart';
import '../widgets/ui_elements/navigation/header.dart';
import '../widgets/ui_elements/title.dart';

class MySchedulePage extends StatefulWidget {
  const MySchedulePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MySchedulePageState();
  }
}

class _MySchedulePageState extends State<MySchedulePage> {
  Widget _buildWeekList(
    BuildContext context,
  ) {
    const int weekNumber = 23;
    const int itemCount = 52 - weekNumber + 1;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(
              left: index == 0 ? 32 : 0,
              right: index == itemCount - 1 ? 32 : 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              shadowColor: Colors.transparent,
              backgroundColor: index == 0
                  ? Theme.of(context).secondaryHeaderColor
                  : Theme.of(context).secondaryHeaderColor.withOpacity(.1),
            ),
            onPressed: () {},
            child: Row(children: [
              Icon(
                Icons.calendar_month_outlined,
                size: 18,
                color: index == 0
                    ? Colors.white.withOpacity(.5)
                    : Theme.of(context).secondaryHeaderColor.withOpacity(.5),
              ),
              const SizedBox(width: 8),
              Text(
                'Week ${weekNumber + index}',
                style: TextStyle(
                  color: index == 0
                      ? Colors.white
                      : Theme.of(context).secondaryHeaderColor,
                  fontFamily: 'Euclid Circular A',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentList(
    BuildContext context,
  ) {
    final List<Appointment> appointments = [
      Appointment(
        id: Random().toString(),
        date: DateTime(2023, 10, 18),
        name: 'Mr Jean Clenon M.',
        shop: 'Mahima',
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
        name: 'James Howare',
        shop: 'Sesam Market',
        object: 'Stock replenish',
        location: 'DLA - Bonanjo messapresse...',
        company: 'Fashion Bestifier',
        status: AppointmentStatus.Cancelled,
      ),
      Appointment(
        id: Random().toString(),
        date: DateTime(2023, 10, 12),
        name: 'Calisto Miea',
        shop: 'Carrefour Market',
        object: 'Stock replenish',
        location: 'DLA - Bonanjo messapresse...',
        company: 'Fashion Bestifier',
        status: AppointmentStatus.Done,
      ),
      Appointment(
        id: Random().toString(),
        date: DateTime(2023, 10, 9),
        name: 'Joseph Kamdem',
        shop: 'Santa Lucia',
        object: 'Stock replenish',
        location: 'DLA - Bonapriso Orange cm..',
        company: 'Fashion Bestifier',
        status: AppointmentStatus.Done,
      ),
      Appointment(
        id: Random().toString(),
        date: DateTime(2023, 10, 7),
        name: 'Calisto Miea',
        shop: 'Carrefour Market',
        object: 'Goods return',
        location: 'DLA - Bonaberi Ndobo...',
        company: 'Fashion Bestifier',
        status: AppointmentStatus.Cancelled,
      ),
      Appointment(
        id: Random().toString(),
        date: DateTime(2023, 10, 6),
        name: 'Perrera Consalo',
        shop: 'Meno',
        object: 'Business Metting',
        location: 'DLA - Ndokoti Brasserie',
        company: 'SABC',
      ),
    ];
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: appointments.length,
        itemBuilder: (context, index) =>
            UIAppointmentBlock(appointments[index]),
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
              title: 'My Schedule',
              subtitle: 'Create or manage your weekly appointments',
              actionText: 'Add New',
              actionIcon: Icons.add,
              actionPressed: () {},
            ),
            const SizedBox(height: 26),
            const UISectionTitle(
              title: 'Weekly Schedule',
              subtitle: 'Your work plan',
              addon: UISearchInput(),
              margin: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              child: _buildWeekList(context),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(height: 6),
                      UITitle(
                        'From 6 - 18 / 2022',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      UITitle(
                        'Wednesday - Tuesday',
                        fontFamily: 'Euclid Circular A',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(.1),
                      shadowColor: Colors.transparent,
                      fixedSize: const Size(44, 44),
                      shape: const CircleBorder(),
                    ),
                    child: Icon(
                      Icons.filter_list_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 37),
            Container(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: _buildAppointmentList(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const UIBottomNavigationBar(),
    );
  }
}
