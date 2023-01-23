import 'package:flutter/material.dart';

import '../../../../models/transaction.dart';

import '../../../../widgets/ui_elements/blocks/transaction.dart';
import '../../../../widgets/ui_elements/buttons.dart';
import '../../../../widgets/ui_elements/navigation/section_title.dart';

class DashboardHistory extends StatelessWidget {
  const DashboardHistory({
    super.key,
  });

  Widget _buildTransactionList(BuildContext context) {
    final List<Transaction> transactions = [
      Transaction(
        amount: 320500,
        name: 'Mr. John Doe',
        date: DateTime(2023, 4, 16),
        qty: 4,
        product: 'Martina Chocolate 1kg',
      ),
      Transaction(
        amount: 92500,
        name: 'Alvina Doniato',
        date: DateTime(2023, 4, 14),
        qty: 23,
        product: 'White Chocolate (Vanilla)',
      ),
      Transaction(
        amount: 92500,
        name: 'Kamdem Geraldo',
        date: DateTime(2023, 4, 10),
        qty: 19,
        product: 'Cocoa Butter with peanuts',
      ),
    ];

    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (BuildContext context, int index) {
            final data = transactions[index];
            return UITransactionBlock(data);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        UISectionTitle(
          title: 'Payment History',
          subtitle: 'View client transactions',
          white: true,
          addon: Container(
            margin: const EdgeInsets.only(top: 4),
            child: UIIconTextButton(
              'VIEW ALL',
              icon: Icons.arrow_forward,
              onPressed: () => Navigator.of(context).pushNamed('/history'),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildTransactionList(context),
      ],
    );
  }
}
