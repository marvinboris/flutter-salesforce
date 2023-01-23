import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UISubmitElevatedButton extends StatelessWidget {
  final String? child;
  final Widget? icon;
  final Function()? onPressed;
  double? maxWidth = 230.0;

  UISubmitElevatedButton(
    this.child, {
    super.key,
    this.icon,
    this.onPressed,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).secondaryHeaderColor,
          ],
        ),
        borderRadius: BorderRadius.circular(300),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(0, 60.0),
          maximumSize: Size(maxWidth!, 60.0),
          shape: const StadiumBorder(),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            Text(
              child!,
              style: const TextStyle(
                fontFamily: 'Euclid Circular A',
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            icon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 6,
                        color: Color(0xffD9D9D9),
                      ),
                      const SizedBox(width: 11),
                      icon!,
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class UISelectElevatedButton extends StatelessWidget {
  final String? child;
  final IconData? icon;
  final Color? color;
  final double? maxWidth;
  final double? height;

  UISelectElevatedButton(
    this.child, {
    super.key,
    this.icon,
    this.color,
    this.maxWidth = 91,
    this.height = 36,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor =
        color == Colors.white ? Theme.of(context).primaryColor : Colors.white;

    // ignore: todo
    // TODO: implement build
    return SizedBox(
      width: maxWidth,
      height: height,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          minimumSize: Size(0, height!),
          padding: const EdgeInsets.only(left: 9, right: 9),
          backgroundColor: color ?? Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? Icon(
                    icon,
                    color: textColor,
                    size: 16,
                  )
                : Container(),
            icon != null ? const SizedBox(width: 5) : Container(),
            Text(
              child!,
              style: TextStyle(
                fontFamily: 'Euclid Circular B',
                fontWeight: FontWeight.w700,
                color: textColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UISelectTextButton extends StatelessWidget {
  final String? child;
  final Function()? onPressed;

  const UISelectTextButton(this.child, {super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(
          left: 23.72,
          top: 14,
          right: 23.72,
          bottom: 14,
        ),
      ),
      child: Text(
        child!,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(68, 64, 64, 1),
        ),
      ),
    );
  }
}

class UIIconTextButton extends StatelessWidget {
  final String? child;
  final IconData? icon;
  final Color? color;
  final Function()? onPressed;

  const UIIconTextButton(
    this.child, {
    super.key,
    this.icon,
    this.color = Colors.white,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = color!.withOpacity(.8);

    // ignore: todo
    // TODO: implement build
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            child!,
            style: TextStyle(
              fontFamily: 'Euclid Circular A',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
          icon != null
              ? Icon(
                  icon,
                  color: textColor,
                  size: 20,
                )
              : Container(),
        ],
      ),
    );
  }
}
