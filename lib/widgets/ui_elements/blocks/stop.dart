import 'package:flutter/material.dart';
import 'package:salesforce/widgets/helpers/dates.dart';

import '../../../models/stop.dart';

import '../../../widgets/ui_elements/title.dart';

class UIStopBlock extends StatelessWidget {
  final Stop data;

  const UIStopBlock(this.data, {super.key});

  Widget _buildLeft(
    BuildContext context,
  ) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(300),
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.place_outlined,
            size: 14,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Container(
          width: .5,
          height: 77,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  Widget _buildDescription(
    BuildContext context, {
    required IconData icon,
    required String value,
    required Color color,
    bool? main,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: color,
          size: 14,
        ),
        const SizedBox(width: 10),
        UITitle(
          value,
          fontWeight: main != null && main ? FontWeight.w500 : FontWeight.w400,
          fontFamily: 'Euclid Circular A',
          fontSize: main != null && main ? 14 : 12,
        ),
      ],
    );
  }

  Widget _buildCenter(
    BuildContext context,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.location,
              style: const TextStyle(
                fontFamily: 'Euclid Circular A',
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            _buildDescription(
              context,
              icon: Icons.notes_outlined,
              value: data.reason,
              color: Theme.of(context).secondaryHeaderColor,
              main: true,
            ),
            const SizedBox(height: 10),
            _buildDescription(
              context,
              icon: Icons.calendar_today_outlined,
              value: Dates.date(data.startTime),
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 10),
            _buildDescription(
              context,
              icon: Icons.access_time_outlined,
              value:
                  '${Dates.time(data.startTime)} - ${data.endTime != null ? Dates.time(data.endTime!) : DateTime.now().toIso8601String()}',
              color: const Color(0xffD68000),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRight(
    BuildContext context,
  ) {
    const Color color = Color(0xffD68000);
    return Container(
      width: 78,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withOpacity(.2),
        borderRadius: BorderRadius.circular(300),
      ),
      child: Text(
        data.endTime != null
            ? '${data.endTime?.difference(data.startTime).inMinutes} min'
            : '',
        style: const TextStyle(
          color: color,
          fontFamily: 'Euclid Circular A',
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLeft(context),
          const SizedBox(width: 17),
          _buildCenter(context),
          _buildRight(context),
        ],
      ),
    );
  }
}
