import 'package:flutter/material.dart';

import '../../../../models/appointment.dart';

import '../../../../scoped_models/main.dart';

import '../../../../widgets/ui_elements/blocks/appointment.dart';
import '../../../../widgets/ui_elements/buttons.dart';
import '../../../../widgets/ui_elements/navigation/section_title.dart';

class DashboardSchedule extends StatelessWidget {
  final MainModel model;

  const DashboardSchedule(
    this.model, {
    super.key,
  });

  Widget _buildAppointmentList(
    BuildContext context,
    List<Appointment> appointments,
  ) =>
      MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: appointments.length,
          itemBuilder: (
            context,
            index,
          ) =>
              UIAppointmentBlock(
            appointments[index],
            weekly: true,
          ),
        ),
      );

  @override
  Widget build(
    BuildContext context,
  ) =>
      Column(
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
          _buildAppointmentList(
            context,
            model.allAppointments,
          ),
        ],
      );
}
