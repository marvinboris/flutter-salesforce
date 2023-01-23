import 'package:flutter/material.dart';

class UISearchInput extends StatelessWidget {
  final String? Function(String?)? onSaved;

  const UISearchInput({
    super.key,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Container(
      width: 139,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(300),
        color: Theme.of(context).primaryColor.withOpacity(.1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 19, right: 16),
            child: Icon(
              Icons.search_outlined,
              color: Theme.of(context).primaryColor.withOpacity(.5),
            ),
          ),
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: const Color(0xff5F5F5F).withOpacity(.8),
                ),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: 'Euclid Circular A',
              ),
              onSaved: onSaved,
            ),
          ),
        ],
      ),
    );
  }
}
