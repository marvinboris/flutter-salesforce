import 'package:flutter/material.dart';

import '../models/appointment.dart';

import '../scoped_models/main.dart';

import '../widgets/helpers/dates.dart';
import '../widgets/ui_elements/blocks/stop.dart';
import '../widgets/ui_elements/navigation/bottom_navigation_bar.dart';
import '../widgets/ui_elements/navigation/header.dart';
import '../widgets/ui_elements/navigation/section_title.dart';
import '../widgets/ui_elements/title.dart';

class ClientsAppointmentPage extends StatelessWidget {
  final Appointment appointment;
  final MainModel model;

  const ClientsAppointmentPage(
    this.appointment,
    this.model, {
    super.key,
  });

  Widget _buildDescription(
    BuildContext context, {
    required IconData icon,
    required String value,
    bool detail = false,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.white.withOpacity(.5),
            size: 14,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: UITitle(
              value,
              color: Colors.white,
              fontWeight: detail ? FontWeight.w400 : FontWeight.w500,
              fontFamily: 'Euclid Circular A',
              fontSize: detail ? 12 : 14,
            ),
          ),
        ],
      );

  Widget _buildInfo(
    BuildContext context, {
    required String child,
    IconData? icon,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.3),
          borderRadius: BorderRadius.circular(300),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 7,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              child,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'Euclid Circular A',
                fontSize: 12,
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

  Widget _buildHeaderAction(
    BuildContext context,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescription(
            context,
            icon: Icons.notes_outlined,
            value: appointment.object,
          ),
          const SizedBox(height: 8),
          _buildDescription(
            context,
            icon: Icons.place_outlined,
            value: appointment.location,
            detail: true,
          ),
          const SizedBox(height: 8),
          _buildDescription(
            context,
            icon: Icons.calendar_today_outlined,
            value:
                '${Dates.longDate(appointment.date)} - ${Dates.time(appointment.date)}',
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: _buildInfo(
              context,
              child: appointment.status == AppointmentStatus.Done
                  ? "Completed"
                  : appointment.status == AppointmentStatus.Cancelled
                      ? "Cancelled"
                      : "Incoming",
              icon: appointment.status == AppointmentStatus.Done
                  ? Icons.check_circle_outlined
                  : null,
            ),
          ),
        ],
      );

  Widget _buildStartButton(
    BuildContext context,
  ) =>
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          fixedSize: const Size(110, 37),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.black.withOpacity(.5),
        ),
        child: Row(
          children: [
            const SizedBox(width: 7),
            const Icon(
              Icons.navigation_outlined,
              size: 14,
              color: Colors.white,
            ),
            const SizedBox(width: 7),
            Container(
              width: .5,
              height: 37,
              color: Colors.white.withOpacity(.5),
            ),
            const SizedBox(width: 15),
            const UITitle(
              'Start',
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ],
        ),
      );

  Widget _buildLocationMap(
    BuildContext context,
  ) =>
      Container(
        height: 196,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('images/map.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.4),
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          child: _buildStartButton(context),
        ),
      );

  Widget _buildAddStopButton(
    BuildContext context,
  ) =>
      Container(
        margin: const EdgeInsets.only(top: 7),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor: Theme.of(context).primaryColor,
            shape: const StadiumBorder(),
            fixedSize: const Size(139, 48),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 14,
                color: Colors.white.withOpacity(.5),
              ),
              const SizedBox(width: 7),
              const Text(
                'Add Stop',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Euclid Circular A',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildTimeTracking(
    BuildContext context,
  ) =>
      MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: model.allStops.length,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.only(top: index == 0 ? 0 : 7),
            child: UIStopBlock(model.allStops[index]),
          ),
        ),
      );

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 115),
          child: Column(
            children: [
              UIHeader(
                title: appointment.name,
                action: _buildHeaderAction(context),
              ),
              const SizedBox(height: 34),
              const UISectionTitle(
                title: 'Location',
                subtitle: 'Client’s location',
              ),
              const SizedBox(height: 26),
              Container(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: _buildLocationMap(context),
              ),
              const SizedBox(height: 38),
              UISectionTitle(
                title: 'Daily Itinery',
                subtitle: 'Time tracking',
                addon: _buildAddStopButton(context),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: _buildTimeTracking(context),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const UIBottomNavigationBar(),
      );
}
