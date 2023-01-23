import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../models/appointment.dart';

import '../../../../widgets/ui_elements/blocks/appointment.dart';
import '../../../../widgets/ui_elements/buttons.dart';
import '../../../../widgets/ui_elements/navigation/section_title.dart';

class DashboardSchedule extends StatelessWidget {
  const DashboardSchedule({
    super.key,
  });

  Widget _buildAppointmentList(BuildContext context) {
    final List<Appointment> appointments = [
      Appointment(
        id: Random().toString(),
        date: DateTime(2023, 10, 18),
        name: 'Mr Jean Clenon M.',
        shop: '',
        object: 'Stock replenish',
        location: 'DLA - Bonamoussadi, face...',
        company: 'Chococam Dla',
      ),
      Appointment(
        id: Random().toString(),
        date: DateTime(2023, 10, 16),
        name: 'Mrs Hernestine H.',
        shop: '',
        object: 'Stock replenish',
        location: 'DLA - Bonanjo messapresse...',
        company: 'Fashion Bestifier',
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
          weekly: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        UISectionTitle(
          title: 'Weekly Schedule',
          subtitle: 'Your work plan',
          white: true,
          addon: Container(
            margin: const EdgeInsets.only(top: 4),
            child: UIIconTextButton(
              'VIEW ALL',
              icon: Icons.arrow_forward,
              onPressed: () => Navigator.of(context).pushNamed('/schedule'),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildAppointmentList(context),
      ],
    );
  }
}
