import 'package:flutter/material.dart';

import '../../../models/shop.dart';

import '../title.dart';

class UIClientShopBlock extends StatelessWidget {
  final Shop data;
  final bool big;

  const UIClientShopBlock(
    this.data, {
    super.key,
    this.big = false,
  });

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

  Widget _buildEditButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.black.withOpacity(.4),
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

  Widget _buildDot(
    BuildContext context, {
    bool white = false,
  }) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(300),
        // color: white ? Colors.white : Colors.black.withOpacity(.6),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
          fixedSize: const Size(10, 10),
          shadowColor: Colors.transparent,
          backgroundColor: white ? Colors.white : Colors.black.withOpacity(.6),
        ),
        child: const SizedBox(
          width: 0,
          height: 0,
        ),
      ),
    );
  }

  Widget _buildTop(
    BuildContext context,
  ) {
    return SizedBox(
      height: 181,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 181,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              image: data.photo != null
                  ? DecorationImage(
                      image: AssetImage('images/shops/${data.photo!}'),
                      fit: BoxFit.cover,
                    )
                  : null,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          data.photo != null
              ? Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(
                    top: 11,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.4),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: _buildEditButton(context),
                )
              : const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 24,
                ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(context, white: true),
                const SizedBox(width: 4),
                _buildDot(context),
                const SizedBox(width: 4),
                _buildDot(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeft(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        big
            ? Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: _buildDescription(
                  context,
                  icon: Icons.person_outlined,
                  value: data.manager,
                  color: Theme.of(context).secondaryHeaderColor,
                  main: true,
                ),
              )
            : Container(),
        _buildDescription(
          context,
          icon: big ? Icons.place_outlined : Icons.business_outlined,
          value: big ? '${data.name} - ${data.location}' : data.name,
          color: big
              ? Theme.of(context).primaryColor
              : Theme.of(context).secondaryHeaderColor,
          main: !big,
        ),
        const SizedBox(height: 10),
        _buildDescription(
          context,
          icon: big ? Icons.phone_outlined : Icons.place_outlined,
          value: big ? data.phone : data.location,
          color: big ? const Color(0xffD68000) : Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 10),
        _buildDescription(
          context,
          icon: big ? Icons.mail_outlined : Icons.phone_outlined,
          value: big ? data.email : data.phone,
          color: Color(big ? 0xff93BF15 : 0xffD68000),
        ),
      ],
    );
  }

  Widget _buildRight(
    BuildContext context,
  ) {
    final Color color =
        Color(data.status == ShopStatus.Active ? 0xff93BF15 : 0xffE0362B);
    return big
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300),
              color: color.withOpacity(.1),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Text(
              data.status == ShopStatus.Active ? "Active" : "Inactive",
              style: TextStyle(
                color: color,
                fontFamily: 'Euclid Circular A',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          )
        : SizedBox(
            width: 85,
            height: 85,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.center,
              children: [
                Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    image: data.photo != null
                        ? DecorationImage(
                            image: AssetImage('images/shops/${data.photo!}'),
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
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 21,
        bottom: 22,
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
      child: Column(
        children: [
          big
              ? Container(
                  margin: const EdgeInsets.only(bottom: 34),
                  child: _buildTop(context),
                )
              : Container(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildLeft(context)),
              const SizedBox(width: 10),
              _buildRight(context),
            ],
          )
        ],
      ),
    );
  }
}
