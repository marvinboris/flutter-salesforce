import 'package:flutter/material.dart';

class UIBottomNavigationBar extends StatelessWidget {
  final bool? white;

  const UIBottomNavigationBar({
    super.key,
    this.white,
  });

  Widget _buildNavigationBarItem(
      BuildContext context, String href, IconData icon) {
    final bool isWhite = white != null && white!;

    return IconButton(
      enableFeedback: false,
      onPressed: () => Navigator.of(context).pushNamed(href),
      icon: Icon(
        icon,
        color: isWhite ? Theme.of(context).primaryColor : Colors.white,
        size: 28,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isWhite = white != null && white!;

    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: isWhite ? Colors.white : Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(26),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed('/dashboard'),
            style: ElevatedButton.styleFrom(
              backgroundColor: isWhite
                  ? Theme.of(context).secondaryHeaderColor
                  : Colors.white,
              padding: const EdgeInsets.only(
                top: 8,
                left: 6,
                right: 21,
                bottom: 8,
              ),
              minimumSize: const Size(0, 44),
              shape: const StadiumBorder(),
            ),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(300),
                        color: isWhite
                            ? Colors.white
                            : Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                    Icon(
                      Icons.home_outlined,
                      color: isWhite
                          ? Theme.of(context).secondaryHeaderColor
                          : Colors.white,
                      size: 16,
                    )
                  ],
                ),
                const SizedBox(width: 13),
                Text(
                  'Home',
                  style: TextStyle(
                    color: isWhite
                        ? Colors.white
                        : Theme.of(context).secondaryHeaderColor,
                    fontFamily: 'Euclid Circular B',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          _buildNavigationBarItem(
            context,
            '/invoice',
            Icons.receipt_long_outlined,
          ),
          _buildNavigationBarItem(
            context,
            '/schedule',
            Icons.calendar_month_outlined,
          ),
          _buildNavigationBarItem(
            context,
            '/clients',
            Icons.person_outlined,
          ),
        ],
      ),
    );
  }
}
