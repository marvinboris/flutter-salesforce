import 'package:flutter/material.dart';
import 'package:salesforce/widgets/helpers/dates.dart';

import '../../../models/appointment.dart';

class UIAppointmentBlock extends StatelessWidget {
  final Appointment data;
  final bool weekly;
  final bool client;

  const UIAppointmentBlock(
    this.data, {
    super.key,
    this.weekly = false,
    this.client = false,
  });

  Widget _buildDay(
    BuildContext context,
  ) {
    Color color = weekly ? Colors.white : Theme.of(context).primaryColor;
    return Container(
      width: 76,
      padding: const EdgeInsets.only(
        top: 10,
        left: 8,
        right: 8,
        bottom: 6,
      ),
      decoration: BoxDecoration(
        color: (weekly ? Colors.white : Theme.of(context).primaryColor)
            .withOpacity(.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(.5), width: 2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(),
              Text(
                Dates.weekDay(data.date),
                style: TextStyle(
                  fontFamily: 'Euclid Circular A',
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1,
                ),
              ),
              Icon(
                Icons.circle,
                color: color,
                size: 10,
              ),
            ],
          ),
          Text(
            Dates.twoDigits(data.date.day),
            style: TextStyle(
              color: color,
              fontSize: 32,
              fontFamily: 'Euclid Circular A',
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          Text(
            Dates.month(data.date),
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontFamily: 'Euclid Circular A',
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    double size = 30,
    IconData icon = Icons.edit_calendar_outlined,
  }) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pushNamed('/schedule/${data.id}'),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        fixedSize: Size(size, size),
        shadowColor: Colors.transparent,
        backgroundColor: size == 30
            ? Theme.of(context).primaryColor
            : Colors.white.withOpacity(0.1),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 14,
      ),
    );
  }

  Widget _buildStatus(
    BuildContext context,
  ) {
    Color color =
        Color(data.status == AppointmentStatus.Done ? 0xff219222 : 0xffE0362B);
    return Container(
      height: 30,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        top: 6,
        bottom: 5,
        left: 15,
        right: 15,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(300),
      ),
      child: Text(
        data.status == AppointmentStatus.Done ? "Done" : "Cancelled",
        style: TextStyle(
          color: color,
          fontFamily: 'Euclid Circular A',
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildAddon(
    BuildContext context,
  ) {
    return weekly
        ? _buildButton(context, size: 24, icon: Icons.chevron_right)
        : data.status == AppointmentStatus.Incoming
            ? _buildButton(context)
            : _buildStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    Color color = weekly ? Colors.white : Theme.of(context).primaryColor;
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 12, bottom: 12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 8),
            blurRadius: 16,
            color:
                weekly ? Colors.white.withOpacity(.1) : const Color(0x149775FA),
          ),
        ],
        color: weekly ? Colors.white.withOpacity(.1) : Colors.white,
      ),
      child: Row(
        children: [
          _buildDay(context),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        client ? data.shop : data.name,
                        style: TextStyle(
                          fontFamily: 'Euclid Circular A',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: weekly ? Colors.white : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 21),
                    _buildAddon(context),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const SizedBox(width: 18, height: 18),
                          Icon(
                            Icons.edit_note_outlined,
                            color: weekly
                                ? Colors.white.withOpacity(.7)
                                : const Color(0xff9B73FA),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      weekly ? data.company : data.object,
                      style: TextStyle(
                        fontFamily: 'Euclid Circular A',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: weekly ? Colors.white.withOpacity(.9) : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const SizedBox(width: 18, height: 18),
                          weekly
                              ? Container()
                              : Icon(
                                  Icons.location_on_outlined,
                                  color: color,
                                  size: 16,
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      weekly ? data.object : data.location,
                      style: TextStyle(
                        fontFamily: 'Euclid Circular A',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: weekly ? Colors.white.withOpacity(.9) : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
