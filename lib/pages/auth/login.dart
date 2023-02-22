// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
// ignore: import_of_legacy_library_into_null_safe

import './layout.dart';

import '../../widgets/ui_elements/form/input.dart';
import '../../widgets/ui_elements/buttons.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthLoginPageState();
  }
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  final Map<String, dynamic> _formData = {
    'email': '',
    'password': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmailField() {
    return UIFormInput(
      icon: Icons.email_outlined,
      hintText: 'commercial@geotrack.com',
      onSaved: (String? value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return UIFormInput(
      icon: Icons.key_outlined,
      hintText: '***********',
      onSaved: (String? value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ScopedModelDescendant(
      builder: (
        context,
        child,
        MainModel model,
      ) =>
          model.isLoading
              ? const Center(child: CircularProgressIndicator())
              : UISubmitElevatedButton(
                  'LOGIN',
                  maxWidth: 1000,
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 24,
                    color: Color(0x66FFFFFF),
                  ),
                  onPressed: () => _submitForm(
                    context,
                    model.authLogin,
                  ),
                ),
    );
  }

  void _submitForm(
    BuildContext context,
    Function authenticate,
  ) async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    final Map<String, dynamic> successInformation = await authenticate(
      _formData['email'],
      _formData['password'],
    );
    if (!successInformation['success']) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('An Error Occurred!'),
              content: Text(successInformation['message']),
              actions: [
                TextButton(
                  child: const Text('Okay'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      AuthLayout(
        title: 'Staff Login',
        subtitle: 'Login to admin',
        icon: SvgPicture.asset('images/iconly-glass-lock.svg', height: 61),
        containerWidget: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildEmailField(),
              const SizedBox(height: 18),
              _buildPasswordField(),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Forgot password ?",
                    style: TextStyle(
                      fontFamily: 'Euclid Circular A',
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/auth/reset'),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.zero)),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontFamily: 'Euclid Circular A',
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              _buildSubmitButton(context),
            ],
          ),
        ),
      );
}
