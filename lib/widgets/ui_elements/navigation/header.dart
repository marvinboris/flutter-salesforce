import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../widgets/ui_elements/title.dart';

class UIHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? image;
  final Widget? action;
  final String? actionText;
  final IconData? actionIcon;
  final void Function()? actionPressed;

  const UIHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.image,
    this.action,
    this.actionText,
    this.actionIcon,
    this.actionPressed,
  });

  Widget _buildBackButton(
    BuildContext context,
  ) =>
      ElevatedButton(
        onPressed: () => Navigator.of(context).maybePop(),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              image != null ? Colors.black.withOpacity(.4) : Colors.white,
          shadowColor: Colors.transparent,
          fixedSize: const Size(44, 44),
          shape: const CircleBorder(),
        ),
        child: Icon(
          Icons.arrow_back,
          color: image != null ? Colors.white : Theme.of(context).primaryColor,
          size: 24,
        ),
      );

  Widget _buildRightButton(
    BuildContext context,
  ) =>
      ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: image != null
              ? Colors.black.withOpacity(.4)
              : Colors.white.withOpacity(.19),
          shadowColor: Colors.transparent,
          fixedSize: const Size(44, 44),
          shape: const CircleBorder(),
        ),
        child: Icon(
          image != null ? Icons.edit_outlined : Icons.notifications_outlined,
          color: Colors.white,
          size: 24,
        ),
      );

  Widget _buildDefaultAction(
    BuildContext context,
  ) =>
      ElevatedButton(
        onPressed: actionPressed ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: const StadiumBorder(),
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.only(left: 21, right: 16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              actionIcon,
              size: 16,
              color: Theme.of(context).primaryColor.withOpacity(.4),
            ),
            const SizedBox(width: 7),
            UITitle(
              actionText!,
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      );

  Widget _buildMainContent(
    BuildContext context,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          UITitle(
            title,
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 14),
          subtitle != null
              ? Text(
                  subtitle!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Euclid Circular A',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : Container(),
          action ?? Container(),
          const SizedBox(height: 24),
          actionText != null ? _buildDefaultAction(context) : Container()
        ],
      );

  @override
  Widget build(
    BuildContext context,
  ) {
    BorderRadius borderRadius = const BorderRadius.only(
      bottomLeft: Radius.circular(45),
      bottomRight: Radius.circular(45),
    );
    return Container(
      height: 268,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).secondaryHeaderColor,
            Theme.of(context).primaryColor,
          ],
        ),
        image: image != null
            ? DecorationImage(
                image: NetworkImage('${dotenv.env['APP_URL']}/${image}'),
                fit: BoxFit.cover,
              )
            : null,
        borderRadius: borderRadius,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: image != null ? Colors.black.withOpacity(.4) : null,
        ),
        child: Stack(children: [
          Positioned(
            child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                borderRadius: borderRadius,
              ),
              child: SvgPicture.asset(
                'images/manage-header.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 64,
              left: 32,
              right: 32,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 5),
                    _buildBackButton(context),
                  ],
                ),
                const SizedBox(width: 23),
                Expanded(
                  child: _buildMainContent(context),
                ),
                const SizedBox(width: 23),
                _buildRightButton(context),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
