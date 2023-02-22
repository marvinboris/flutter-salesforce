import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../models/client.dart';

import '../title.dart';

class UIClientBlock extends StatelessWidget {
  final Client data;

  const UIClientBlock(
    this.data, {
    super.key,
  });

  Widget _buildEditButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pushNamed('/clients/${data.id}'),
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).primaryColor,
        shape: const StadiumBorder(),
        fixedSize: const Size(139, 40),
        padding: const EdgeInsets.all(0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.edit_outlined,
            size: 14,
            color: Colors.white.withOpacity(.5),
          ),
          const SizedBox(width: 9),
          const Text(
            'Edit Client',
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
          size: 18,
        ),
        const SizedBox(width: 10),
        UITitle(
          value,
          fontWeight: main != null && main ? FontWeight.w600 : FontWeight.w400,
          fontFamily: 'Euclid Circular A',
          fontSize: main != null && main ? 18 : 14,
        ),
      ],
    );
  }

  Widget _buildLeftSide(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDescription(
          context,
          icon: Icons.person_outlined,
          value: data.name,
          color: Theme.of(context).secondaryHeaderColor,
          main: true,
        ),
        const SizedBox(height: 10),
        _buildDescription(
          context,
          icon: Icons.place_outlined,
          value: data.location,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 10),
        _buildDescription(
          context,
          icon: Icons.phone_outlined,
          value: data.phone,
          color: const Color(0xffD68000),
        ),
        const SizedBox(height: 10),
        _buildDescription(
          context,
          icon: Icons.mail_outlined,
          value: data.email,
          color: const Color(0xff93BF15),
        ),
        const SizedBox(height: 15),
        _buildEditButton(context),
      ],
    );
  }

  Widget _buildRightSide(
    BuildContext context,
  ) {
    final Color color =
        Color(data.status == ClientStatus.Active ? 0xff93BF15 : 0xffE0362B);
    return Column(
      children: [
        SizedBox(
          width: 82,
          height: 66,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            children: [
              Container(
                width: 82,
                height: 66,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  image: data.photo != null && !data.photo!.endsWith('.svg')
                      ? DecorationImage(
                          image: NetworkImage(
                            '${dotenv.env['APP_URL']}${data.photo!}',
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              data.photo != null
                  ? Container()
                  : const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 82,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withOpacity(.1),
            borderRadius: BorderRadius.circular(300),
          ),
          child: Text(
            data.status == ClientStatus.Active ? "Active" : "Inactive",
            style: TextStyle(
              fontFamily: 'Euclid Circular A',
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: color,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 21,
        bottom: 26,
        left: 30,
        right: 20,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildLeftSide(context)),
          const SizedBox(width: 23),
          _buildRightSide(context),
        ],
      ),
    );
  }
}
