import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesforce/widgets/helpers/dates.dart';

import '../../../models/invoice.dart';

import '../title.dart';

class UIInvoiceBlock extends StatelessWidget {
  final Invoice data;

  const UIInvoiceBlock(
    this.data, {
    super.key,
  });

  Widget _buildViewButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).primaryColor,
        shape: const StadiumBorder(),
        fixedSize: const Size(89, 40),
        padding: const EdgeInsets.all(0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.remove_red_eye_outlined,
            size: 18,
            color: Colors.white,
          ),
          SizedBox(width: 9),
          Text(
            'View',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Euclid Circular A',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(width: 32),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    data.number,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontFamily: 'Euclid Circular A',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const SizedBox(width: 5),
                  Container(
                    width: 146,
                    height: .5,
                    color: const Color(0x665F5F5F),
                  ),
                ],
              )
            ],
          ),
        ),
        _buildViewButton(context),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _buildDescription(
    BuildContext context,
    IconData icon,
    String value,
    bool main,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0x4d5F5F5F),
          size: 18,
        ),
        const SizedBox(width: 10),
        UITitle(
          value,
          fontWeight: main ? FontWeight.w600 : FontWeight.w500,
          fontFamily: 'Euclid Circular A',
          fontSize: main ? 16 : 14,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(width: 32),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDescription(
                    context,
                    Icons.person_outlined,
                    data.client,
                    true,
                  ),
                  const SizedBox(height: 4),
                  _buildDescription(
                    context,
                    Icons.place_outlined,
                    data.location,
                    false,
                  ),
                  const SizedBox(height: 4),
                  _buildDescription(
                    context,
                    Icons.calendar_month_outlined,
                    '${Dates.date(data.dateTime)} - ${Dates.time(data.dateTime)}',
                    false,
                  ),
                  const SizedBox(height: 5),
                ],
              ),
              Icon(
                Icons.receipt_long_outlined,
                color: Theme.of(context).primaryColor.withOpacity(.1),
                size: 50,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _buildAmount(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Theme.of(context).primaryColor.withOpacity(.1),
          width: 50,
          height: 1,
        ),
        const SizedBox(width: 9),
        UITitle(
          '${NumberFormat('###,###.00').format(data.amount)} XAF',
          fontFamily: 'Euclid Circular A',
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(width: 15),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(300),
          ),
        ),
        Expanded(
          child: Container(
            color: Theme.of(context).primaryColor.withOpacity(.1),
            height: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    final Color color = Color(data.status == InvoiceStatus.Pending
        ? 0xffD68000
        : data.status == InvoiceStatus.Cancelled
            ? 0xffE0362B
            : 0xff158516);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 58),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(300),
            color: Theme.of(context).secondaryHeaderColor.withOpacity(.1),
          ),
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 6,
            right: 15,
            left: 11,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.money_outlined,
                color: Theme.of(context).secondaryHeaderColor,
                size: 14,
              ),
              const SizedBox(width: 5),
              UITitle(
                data.method,
                fontFamily: 'Euclid Circular A',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ],
          ),
        ),
        const SizedBox(width: 7),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(300),
            color: color.withOpacity(.1),
          ),
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 6,
            right: 15,
            left: 11,
          ),
          child: UITitle(
            data.status == InvoiceStatus.Pending
                ? 'Pending'
                : data.status == InvoiceStatus.Cancelled
                    ? 'Cancelled'
                    : 'Completed',
            fontFamily: 'Euclid Circular A',
            fontWeight: data.status == InvoiceStatus.Pending
                ? FontWeight.w500
                : FontWeight.w400,
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 18,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 8),
            blurRadius: 16,
            color: Color(0x149775FA),
          ),
        ],
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context),
          const SizedBox(height: 14),
          _buildBody(context),
          _buildAmount(context),
          const SizedBox(height: 5),
          _buildFooter(context),
        ],
      ),
    );
  }
}
