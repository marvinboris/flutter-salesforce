import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/ui_elements/title.dart';

class AuthLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget containerWidget;
  final SvgPicture icon;

  const AuthLayout(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.containerWidget,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).secondaryHeaderColor,
                Theme.of(context).primaryColor,
              ]),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 30,
              right: 24,
              child: SvgPicture.asset('images/bg-welcome.svg'),
            ),
            Container(
              padding: const EdgeInsets.only(left: 34, right: 34, top: 109),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const UITitle(
                    'Welcome to',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  const UITitle(
                    'Geotrack',
                    fontSize: 45,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 38),
                  Stack(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.only(top: 42, left: 24, right: 24),
                        height: 311,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45.0),
                          color: const Color(0xffF8F8F8),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(46, 92, 158, .15),
                              offset: Offset(0, 16),
                              blurRadius: 32,
                              spreadRadius: 0,
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 42, left: 24, right: 24),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      UITitle(
                                        title,
                                        fontSize: 28,
                                      ),
                                      UITitle(
                                        subtitle,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, right: 44),
                                  height: 57,
                                  width: 61,
                                  child: icon,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Container(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: Container(
                              padding: const EdgeInsets.only(
                                bottom: 39,
                                left: 34,
                                right: 34,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0x1c9B73FA),
                                        offset: Offset(0, 16),
                                        blurRadius: 32),
                                  ]),
                              child: Column(children: [
                                Container(
                                  width: 69,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).secondaryHeaderColor,
                                        Theme.of(context).primaryColor,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(300),
                                  ),
                                  margin: const EdgeInsets.only(
                                      top: 26, bottom: 26),
                                ),
                                containerWidget,
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
