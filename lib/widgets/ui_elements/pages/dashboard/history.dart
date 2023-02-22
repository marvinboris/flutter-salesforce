import 'package:flutter/material.dart';

import '../../../../scoped_models/main.dart';

import '../../../../widgets/ui_elements/blocks/transaction.dart';
import '../../../../widgets/ui_elements/buttons.dart';
import '../../../../widgets/ui_elements/navigation/section_title.dart';

class DashboardHistory extends StatelessWidget {
  final MainModel model;

  const DashboardHistory(
    this.model, {
    super.key,
  });

  Widget _buildTransactionList(BuildContext context) =>
      MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: model.allTransactions.length,
          itemBuilder: (BuildContext context, int index) {
            final data = model.allTransactions[index];
            return UITransactionBlock(data);
          },
        ),
      );

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
