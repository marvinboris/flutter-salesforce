import 'package:flutter/material.dart';

import '../widgets/ui_elements/title.dart';

class PaymentCompleted extends StatefulWidget {
  const PaymentCompleted({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PaymentCompletedState();
  }
}

class _PaymentCompletedState extends State<PaymentCompleted> {
  Widget _buildButton(BuildContext context,
      {required String child,
      required IconData icon,
      Color? color,
      void Function()? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(280, 64),
        shadowColor: Colors.transparent,
        shape: const StadiumBorder(),
        backgroundColor: color != null
            ? color.withOpacity(.1)
            : Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 48),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            child,
            style: TextStyle(
              fontFamily: 'Euclid Circular A',
              color: color ?? Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 19,
            ),
          ),
          Icon(
            icon,
            size: 28,
            color: color != null
                ? color.withOpacity(.5)
                : Colors.white.withOpacity(.5),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(45),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 16),
                      blurRadius: 32,
                      color: Color(0x262E5C9E),
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(
                  top: 71,
                  bottom: 41,
                  left: 39,
                  right: 39,
                ),
                child: Column(
                  children: [
                    const UITitle(
                      'Payment Completed',
                      fontSize: 25,
                    ),
                    const SizedBox(height: 66),
                    Image.asset('images/check-circle.png', height: 73.83),
                    const SizedBox(height: 53),
                    const Text(
                      'Well done. Your payment was successfully processed. You will receive a notification shortly. Thanks for your trust',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Euclid Circular A',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 53),
                    _buildButton(
                      context,
                      child: 'View invoice',
                      icon: Icons.receipt_long_outlined,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 103),
              _buildButton(
                context,
                child: 'Go to dashboard',
                icon: Icons.arrow_forward_outlined,
                onPressed: () => Navigator.of(context).pushNamed('/'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
