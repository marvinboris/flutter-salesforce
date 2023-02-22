import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

import '../widgets/helpers/validators.dart';
import '../widgets/ui_elements/buttons.dart';
import '../widgets/ui_elements/form/select_flag.dart';
import '../widgets/ui_elements/navigation/bottom_navigation_bar.dart';
import '../widgets/ui_elements/navigation/header.dart';
import '../widgets/ui_elements/title.dart';

class CreateClientPage extends StatefulWidget {
  const CreateClientPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateClientPageState();
  }
}

class _CreateClientPageState extends State<CreateClientPage> {
  final Map<String, dynamic> _clientsInfoFormData = {
    'firstName': '',
    'lastName': '',
    'code': '',
    'phone': '',
    'nid': '',
    'photo': '',
  };
  final GlobalKey<FormState> _clientsInfoFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    _clientsInfoFormData['code'] = '237';
  }

  Widget _buildInputField(
    BuildContext context, {
    IconData? icon,
    Widget? prepend,
    Widget? append,
    String? labelText,
    String? hintText,
    String? Function(String?)? validator,
    String? Function(String?)? onSaved,
  }) =>
      Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(300),
        ),
        child: Row(
          children: [
            const SizedBox(width: 31),
            icon != null
                ? Icon(
                    icon,
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(.5),
                    size: 24,
                  )
                : Container(),
            prepend ?? Container(),
            icon != null ? const SizedBox(width: 11) : Container(),
            icon != null
                ? Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(300),
                      color: const Color(0xffD9D9D9),
                    ),
                  )
                : Container(),
            icon != null ? const SizedBox(width: 21) : Container(),
            prepend != null ? const SizedBox(width: 16.7) : Container(),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: labelText,
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Color(0x375F5F5F)),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Euclid Circular A',
                ),
                validator: validator,
                onSaved: onSaved,
              ),
            ),
            append ?? Container(),
            const SizedBox(width: 8),
          ],
        ),
      );

  Widget _buildSubmitButton(
    BuildContext context,
  ) =>
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).secondaryHeaderColor,
              Theme.of(context).primaryColor,
            ],
          ),
          borderRadius: BorderRadius.circular(300),
        ),
        child: UISubmitElevatedButton(
          'SAVE',
          maxWidth: 1000,
          icon: const Icon(
            Icons.arrow_forward,
            size: 24,
            color: Color(0x66FFFFFF),
          ),
          onPressed: () => _submitForm(context),
        ),
      );

  Widget _buildForm(
    BuildContext context, {
    required String title,
    required String subtitle,
    Widget? addon,
    required Widget child,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(45),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 16),
              blurRadius: 32,
              color: Color(0x1c9B73FA),
            ),
          ],
        ),
        padding: const EdgeInsets.only(
          top: 25,
          left: 45,
          right: 45,
          bottom: 38,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UITitle(
                      title,
                      fontSize: 25,
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontFamily: 'Euclid Circular A',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: 41,
                      height: 8,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).secondaryHeaderColor,
                            Theme.of(context).primaryColor,
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 8,
                            color: Color(0x309775FA),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(300),
                      ),
                    )
                  ],
                ),
                addon ?? Container(),
              ],
            ),
            const SizedBox(height: 38),
            child
          ],
        ),
      );

  void _submitForm(
    BuildContext context,
  ) async {
    Navigator.of(context).pushNamed('/dashboard');
    return;
    if (!_clientsInfoFormKey.currentState!.validate()) return;
    _clientsInfoFormKey.currentState?.save();
    // final Map<String, dynamic> successInformation = await authenticate(
    //     _clientsInfoFormData['username'], _clientsInfoFormData['password']);
    // if (!successInformation['success']) {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: const Text('An Error Occurred!'),
    //           content: Text(successInformation['message']),
    //           actions: [
    //             TextButton(
    //               child: const Text('Okay'),
    //               onPressed: () => Navigator.of(context).pop(),
    //             )
    //           ],
    //         );
    //       });
    // }
  }

  Widget _buildClientsInfoFormAddon(
    BuildContext context,
  ) =>
      SizedBox(
        width: 82,
        height: 82,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(300),
                border: Border.all(
                  color:
                      Theme.of(context).secondaryHeaderColor.withOpacity(.16),
                  width: 4,
                ),
              ),
              child: _clientsInfoFormData['photo'] != ''
                  ? Image.asset(_clientsInfoFormData['photo'])
                  : Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(300),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
            ),
            Container(
              width: 82,
              height: 82,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.3),
                borderRadius: BorderRadius.circular(300),
              ),
              child: Container(
                width: 82,
                height: 82,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 33),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.black.withOpacity(.3),
                    shape: const StadiumBorder(),
                    fixedSize: const Size(51, 24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.edit_outlined,
                        size: 10,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      UITitle(
                        'Edit',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildFirstNameInputField(
    BuildContext context,
  ) =>
      _buildInputField(
        context,
        hintText: 'First Name',
        icon: Icons.person_outlined,
        onSaved: (String? value) {
          _clientsInfoFormData['firstName'] = value;
        },
      );

  Widget _buildLastNameInputField(
    BuildContext context,
  ) =>
      _buildInputField(
        context,
        hintText: 'Last Name',
        icon: Icons.person_outlined,
        onSaved: (String? value) {
          _clientsInfoFormData['lastName'] = value;
        },
      );

  Widget _buildPhoneInputField(
    BuildContext context, {
    required List<Map<String, String?>> countries,
  }) =>
      _buildInputField(
        context,
        hintText: '054 430 3333',
        prepend: UISelectFlag(
          countries: countries,
          value: _clientsInfoFormData['code'],
          onChanged: (String? value) {
            setState(() {
              _clientsInfoFormData['code'] = value;
            });
          },
        ),
        validator: (String? value) =>
            !Validators.isPhone(value) ? 'Invalid phone number.' : null,
        onSaved: (String? value) {
          _clientsInfoFormData['phone'] = value;
        },
      );

  Widget _buildNidInputField(
    BuildContext context,
  ) =>
      _buildInputField(
        context,
        hintText: 'NID image',
        icon: Icons.badge_outlined,
        append: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: Theme.of(context).primaryColor,
              fixedSize: const Size(38, 38),
              shape: const CircleBorder(),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 18,
            )),
        onSaved: (String? value) {
          _clientsInfoFormData['nid'] = value;
        },
      );

  Widget _buildClientsInfoForm(
    BuildContext context,
  ) =>
      _buildForm(
        context,
        title: 'Client’s info',
        subtitle: 'Create client',
        addon: _buildClientsInfoFormAddon(context),
        child: Column(
          children: [
            _buildFirstNameInputField(context),
            const SizedBox(height: 10),
            _buildLastNameInputField(context),
            const SizedBox(height: 10),
            ScopedModelDescendant(
              builder: (context, child, MainModel model) {
                return _buildPhoneInputField(context,
                    countries: model.countries);
              },
            ),
            const SizedBox(height: 10),
            _buildNidInputField(context),
            const SizedBox(height: 35),
            _buildSubmitButton(context),
          ],
        ),
      );

  Widget _buildCompanyInfoForm(
    BuildContext context,
  ) =>
      _buildForm(
        context,
        title: 'Company info',
        subtitle: 'Company details',
        child: Column(
          children: [
            _buildInputField(context),
          ],
        ),
      );

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              const UIHeader(
                title: 'Create Client',
                subtitle: 'To create a client, please fill in the form below.',
              ),
              Container(
                padding: const EdgeInsets.only(top: 197),
                child: Column(
                  children: [
                    _buildClientsInfoForm(context),
                    const SizedBox(height: 32),
                    _buildCompanyInfoForm(context),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const UIBottomNavigationBar(),
      );
}
