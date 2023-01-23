import 'package:flutter/material.dart';
import 'package:salesforce/widgets/ui_elements/title.dart';

import '../widgets/ui_elements/navigation/bottom_navigation_bar.dart';
import '../widgets/ui_elements/navigation/header.dart';
import '../widgets/ui_elements/navigation/section_title.dart';

class DuePaymentPage extends StatefulWidget {
  const DuePaymentPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DuePaymentPageState();
  }
}

class _DuePaymentPageState extends State<DuePaymentPage> {
  final Map<String, dynamic> _formData = {
    'paymentMethod': 'Credit / Debit Card',
    'name': '',
    'cardNumber': '',
    'expDate': '',
    'cvv': '',
  };

  Widget _buildSelectField(
    BuildContext context,
    List<String> list,
    String value,
    void Function(String?)? onChanged,
  ) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        value: value,
        onChanged: onChanged,
        items: list
            .map(
              (value) => DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Euclid Circular A',
                    fontSize: 14,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    String? labelText,
    String? hintText,
    String? Function(String?)? validator,
    String? Function(String?)? onSaved,
  }) {
    return TextFormField(
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
    );
  }

  Widget _buildFormInputField(
    BuildContext context, {
    required Widget child,
    IconData? icon,
    Color? color = const Color(0x33D9D9D9),
  }) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(300),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          icon != null
              ? Container(
                  padding: const EdgeInsets.only(left: 19, right: 16),
                  child: Icon(
                    icon,
                    color: const Color(0xb2444040),
                  ),
                )
              : const SizedBox(width: 29),
          Expanded(
            child: child,
          ),
          const SizedBox(width: 11),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSearchField(
    BuildContext context,
  ) {
    final List<String> paymentMethods = [
      'Credit / Debit Card',
      'Mobile Payment',
    ];
    return _buildFormInputField(
      context,
      child: _buildSelectField(
        context,
        paymentMethods,
        _formData['paymentMethod'],
        (String? value) => setState(() {
          _formData['paymentMethod'] = value;
        }),
      ),
      icon: Icons.credit_card_outlined,
      color: Theme.of(context).primaryColor.withOpacity(.1),
    );
  }

  Widget _buildButton(
    BuildContext context,
    IconData icon,
    void Function()? onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(24, 24),
        shape: const CircleBorder(),
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).secondaryHeaderColor.withOpacity(.1),
      ),
      child: Icon(
        icon,
        color: Theme.of(context).secondaryHeaderColor,
        size: 12,
      ),
    );
  }

  Widget _buildSeparator(
    BuildContext context,
  ) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: .5,
            color: Theme.of(context).primaryColor.withOpacity(.2),
          ),
        ),
        Container(
          height: 5,
          width: 42,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(300),
          ),
        ),
        Expanded(
          child: Container(
            height: .5,
            color: Theme.of(context).primaryColor.withOpacity(.2),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentForm(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UITitle(
                  'Payment Gateway',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 14),
                Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(300),
                  ),
                ),
              ],
            ),
            Image.asset('images/visa-card-logo.png', height: 20),
          ],
        ),
        const SizedBox(height: 25),
        _buildPaymentMethodSearchField(context),
        const SizedBox(height: 33),
        _buildSeparator(context),
        const SizedBox(height: 26),
        _buildFormInputField(
          context,
          child: _buildInputField(
            context,
            hintText: 'Card holder’s name',
          ),
        ),
        const SizedBox(height: 7),
        _buildFormInputField(
          context,
          icon: Icons.credit_card_outlined,
          child: _buildInputField(
            context,
            hintText: 'Card number',
          ),
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            Expanded(
              child: _buildFormInputField(
                context,
                child: _buildInputField(
                  context,
                  hintText: '12/2025',
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildFormInputField(
                context,
                child: _buildInputField(
                  context,
                  hintText: 'CVV',
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 115),
        child: Column(
          children: [
            UIHeader(
              title: 'Due Amount',
              subtitle: 'Please select a payment method to complete payment',
              actionText: 'New Invoice',
              actionIcon: Icons.add,
              actionPressed: () => Navigator.of(context)
                  .pushReplacementNamed('/payment/success'),
            ),
            const SizedBox(height: 26),
            const UISectionTitle(
              title: 'Select Payment Method',
              subtitle: 'Choose payment method',
            ),
            const SizedBox(height: 55),
            Container(
              margin: const EdgeInsets.only(
                left: 32,
                right: 32,
              ),
              padding: const EdgeInsets.only(
                top: 20,
                left: 32,
                right: 32,
                bottom: 45,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: _buildPaymentForm(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const UIBottomNavigationBar(),
    );
  }
}
