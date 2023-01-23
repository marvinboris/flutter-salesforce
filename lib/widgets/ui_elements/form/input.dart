import 'package:flutter/material.dart';

class UIFormInput extends StatelessWidget {
  final IconData? icon;
  final Widget? addon;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;

  const UIFormInput({
    super.key,
    this.icon,
    this.addon,
    this.labelText,
    this.hintText,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Container(
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(300),
        color: Colors.white,
        border: Border.all(color: const Color(0x99C0C0C0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          icon != null
              ? Container(
                  padding: const EdgeInsets.only(left: 34.11, right: 15.42),
                  child: Row(children: [
                    Icon(icon!, color: const Color(0x7f5F5F5F)),
                    const SizedBox(width: 13.48),
                    Container(
                      width: 4.58,
                      height: 4.58,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(217, 217, 217, 1),
                        borderRadius: BorderRadius.circular(4.58),
                      ),
                    ),
                  ]),
                )
              : Container(),
          addon != null
              ? Container(
                  padding: const EdgeInsets.only(left: 34.11, right: 16.7),
                  child: addon!,
                )
              : Container(),
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: labelText,
                hintText: hintText,
                hintStyle: const TextStyle(color: Color(0x375F5F5F)),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Euclid Circular A',
              ),
              validator: validator,
              onSaved: onSaved,
            ),
          ),
        ],
      ),
    );
  }
}
