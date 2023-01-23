import 'package:flutter/material.dart';

class UITitle extends Text {
  final String child;
  final String fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? color;

  const UITitle(
    this.child, {
    super.key,
    this.fontFamily = 'Euclid Circular B',
    this.fontSize = 16,
    this.fontWeight = FontWeight.w700,
    this.textAlign,
    this.color,
  }) : super('');

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Text(
      child,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
