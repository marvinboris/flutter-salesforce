import 'package:flutter/material.dart';

import '../title.dart';

class UISectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool white;
  final Widget? addon;
  final bool margin;

  const UISectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.white = false,
    this.addon,
    this.margin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: white ? 0 : 32, right: white ? 0 : 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              margin ? const SizedBox(height: 8) : Container(),
              UITitle(
                title,
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: white ? Colors.white : null,
              ),
              UITitle(
                subtitle,
                fontFamily: 'Euclid Circular A',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: white ? Colors.white.withOpacity(.8) : null,
              ),
            ],
          ),
          addon ?? Container(),
        ],
      ),
    );
  }
}
