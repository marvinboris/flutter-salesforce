import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../scoped_models/main.dart';

class DashboardHeader extends StatelessWidget {
  final MainModel model;

  const DashboardHeader(
    this.model, {
    super.key,
  });

  Widget _buildUserPic() => SizedBox(
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
            model.user?.data['photo'] != null &&
                    !(model.user?.data['photo'] as String).endsWith('.svg')
                ? Image.network(
                    '${dotenv.env['APP_URL']}${model.user?.data['photo']}',
                    fit: BoxFit.cover,
                  )
                : Container(
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
      );

  Widget _buildGreetings() => Container(
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
                model.user?.data['name'],
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
      );

  Widget _buildNotificationsBtn() => Stack(
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
          const Icon(
            Icons.notifications_none,
            color: Colors.white,
            size: 33,
          ),
        ],
      );

  @override
  Widget build(
    BuildContext context,
  ) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserPic(),
          const SizedBox(width: 11),
          _buildGreetings(),
          Expanded(
            child: Container(),
          ),
          _buildNotificationsBtn(),
        ],
      );
}
