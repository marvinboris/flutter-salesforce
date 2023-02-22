import 'package:flutter/material.dart';

import '../../../models/transaction.dart';

import '../../../widgets/ui_elements/title.dart';

class UITransactionBlock extends StatelessWidget {
  final Transaction data;

  const UITransactionBlock(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14, left: 20, right: 19, bottom: 17),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: UITitle(
                  data.client,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 21),
              SizedBox(
                width: 105,
                child: Row(
                  children: [
                    const Text(
                      'XAF',
                      style: TextStyle(
                        fontFamily: 'Euclid Circular A',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: UITitle(
                        '${(data.qty / 1000).toStringAsFixed(1)}k',
                        color: const Color(0xff00A141),
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            data.product,
            style: const TextStyle(
              fontFamily: 'Euclid Circular A',
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(
                '${data.date?.day}.${data.date?.month}.${data.date?.year}',
                style: const TextStyle(
                  fontFamily: 'Euclid Circular A',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 14),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Qty : ',
                    style: TextStyle(
                      fontFamily: 'Euclid Circular A',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    data.qty.toString(),
                    style: const TextStyle(
                      fontFamily: 'Euclid Circular A',
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
