import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final String? name;
  final String? photo;

  const DashboardHeader({
    super.key,
    this.name = 'Boris Marvins',
    this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 76,
          height: 76,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(300),
                ),
              ),
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(300),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 8,
                      color: Colors.black26,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.person,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 11),
        Container(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello,',
                style: TextStyle(
                  fontFamily: 'Euclid Circular A',
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  name!,
                  style: const TextStyle(
                    fontFamily: 'Euclid Circular B',
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0x33D9D9D9),
                borderRadius: BorderRadius.circular(300),
              ),
            ),
            photo != null
                ? Image.asset(photo!)
                : const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 33,
                  ),
          ],
        ),
      ],
    );
  }
}
