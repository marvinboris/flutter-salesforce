import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UISelectFlag extends StatelessWidget {
  final String? value;
  final Function(String?)? onChanged;
  List<Map<String, String?>> countries = [];

  UISelectFlag({
    super.key,
    this.value,
    this.onChanged,
    required this.countries,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        icon: const Icon(Icons.keyboard_arrow_down),
        value: value,
        onChanged: onChanged,
        items: countries
            .map(
              (Map<String, String?> value) => DropdownMenuItem(
                value: value['code'],
                child: Row(
                  children: [
                    Container(
                      width: 21.37,
                      height: 21.37,
                      margin: const EdgeInsets.only(right: 6.11),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21.37),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'icons/flags/png/${value['country']!.toLowerCase()}.png',
                            package: 'country_icons',
                          ),
                        ),
                      ),
                    ),
                    Text(
                      value['country']!,
                      style: const TextStyle(
                        fontFamily: 'Euclid Circular A',
                        fontSize: 13.74,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
