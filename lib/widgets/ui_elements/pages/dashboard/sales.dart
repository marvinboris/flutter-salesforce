import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/ui_elements/buttons.dart';
import '../../../../widgets/ui_elements/title.dart';

class DashboardSales extends StatelessWidget {
  final double? realSales;
  final double? expectedSales;

  const DashboardSales({
    super.key,
    this.realSales = 0,
    this.expectedSales = 0,
  });

  @override
  Widget build(BuildContext context) {
    bool isCompleted = realSales! >= expectedSales!;

    return Container(
      padding: const EdgeInsets.only(
        top: 21,
        left: 26,
        bottom: 21,
        right: 18,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 16),
              blurRadius: 32,
              color: Color(0x1c9B73FA),
            ),
          ],
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UITitle(
                    "Today’s Sales",
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  const UITitle(
                    "Daily Report",
                    fontFamily: 'Euclid Circular A',
                    fontSize: 14,
                  ),
                  const SizedBox(height: 11),
                  Container(
                    width: 46,
                    height: 6,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).secondaryHeaderColor,
                          Theme.of(context).primaryColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(300),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 8,
                          color: Color(0x309775FA),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              UISelectElevatedButton(
                'Clock In',
                color: const Color(0xff93BF15),
                icon: Icons.access_time,
              ),
            ],
          ),
          const SizedBox(height: 19),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              UITitle(
                NumberFormat('###,###.00').format(realSales!),
                fontSize: 35,
              ),
              const SizedBox(width: 7),
              Container(
                padding: const EdgeInsets.only(bottom: 9),
                child: const UITitle(
                  'XAF',
                  fontFamily: 'Euclid Circular A',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          UITitle(
            '/ ${NumberFormat('###,###.00').format(expectedSales!)} XAF',
            fontFamily: 'Euclid Circular A',
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 9,
                  bottom: 9,
                  left: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(isCompleted ? 0x1f05B806 : 0x1aFF0F00),
                ),
                child: Row(
                  children: [
                    Text(
                      isCompleted ? 'Completed' : 'Not reached',
                      style: TextStyle(
                        fontFamily: 'Euclid Circular A',
                        color: Color(isCompleted ? 0xff0D900E : 0xffE0362B),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      isCompleted
                          ? Icons.check_circle_outline
                          : Icons.incomplete_circle,
                      color: Color(isCompleted ? 0xff0D900E : 0xffE0362B),
                      size: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 44,
                height: 44,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(300),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
