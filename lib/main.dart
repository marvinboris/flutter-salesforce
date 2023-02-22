import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scoped_model/scoped_model.dart';

import './scoped_models/main.dart';

import './pages/auth/login.dart';
import './pages/clients.dart';
import './pages/clients_appointment.dart';
import './pages/clients_create.dart';
import './pages/clients_profile.dart';
import './pages/clients_shops.dart';
import './pages/dashboard.dart';
import './pages/invoice.dart';
import './pages/payment.dart';
import './pages/payment_completed.dart';
import './pages/schedule.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

//Setting SystmeUIMode
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );

  await dotenv.load(fileName: "dotenv");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });

    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Euclid Circular A',
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: const Color(0xff5F5F5F),
                displayColor: const Color(0xff5F5F5F),
              ),
          primaryColor: const Color(0xff4F87F4),
          secondaryHeaderColor: const Color(0xff9B73FA),
          buttonTheme: const ButtonThemeData(
            buttonColor: Color(0xff4F87F4),
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: const MaterialColor(
              0xff4f86f4,
              {
                50: Color(0xffe5f2ff),
                100: Color(0xffc1deff),
                200: Color(0xff9acaff),
                300: Color(0xff74b5ff),
                400: Color(0xff5da4ff),
                500: Color(0xff5095ff),
                600: Color(0xff4f86f4),
                700: Color(0xff4c73df),
                800: Color(0xff4862cc),
                900: Color(0xff4241ac),
              },
            ),
          )
              .copyWith(
                secondary: const MaterialColor(
                  0xff9b73fa,
                  {
                    50: Color(0xfff0e7fe),
                    100: Color(0xffd6c4fc),
                    200: Color(0xffba9dfa),
                    300: Color(0xff9b73fa),
                    400: Color(0xff8251f8),
                    500: Color(0xff6732ed),
                    600: Color(0xff5a2de7),
                    700: Color(0xff4824de),
                    800: Color(0xff331fd6),
                    900: Color(0xff0012c7),
                  },
                ),
              )
              .copyWith(
                background: const Color(0xfff9f9f9),
              ),
        ),
        routes: {
          '/': (BuildContext context) =>
              _isAuthenticated ? DashboardPage(_model) : const AuthLoginPage(),
          '/schedule': (BuildContext context) =>
              _isAuthenticated ? const MySchedulePage() : const AuthLoginPage(),
          '/invoice': (BuildContext context) => _isAuthenticated
              ? ManageInvoicePage(_model)
              : const AuthLoginPage(),
          '/clients': (BuildContext context) =>
              _isAuthenticated ? MyClientsPage(_model) : const AuthLoginPage(),
          '/clients/add': (BuildContext context) => _isAuthenticated
              ? const CreateClientPage()
              : const AuthLoginPage(),
          '/payment': (BuildContext context) =>
              _isAuthenticated ? DuePaymentPage(_model) : const AuthLoginPage(),
          '/payment/success': (BuildContext context) => _isAuthenticated
              ? const PaymentCompleted()
              : const AuthLoginPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated) {
            return MaterialPageRoute(
              builder: (BuildContext context) => const AuthLoginPage(),
            );
          }

          final List<String> pathElements = (settings.name ?? '').split('/');

          if (pathElements[0] != '') return null;
          if (pathElements[1] == 'schedule') {
            final String appointmentId = pathElements[2];
            final appointment =
                _model.allAppointments.firstWhere((a) => a.id == appointmentId);
            return MaterialPageRoute(
              builder: (
                BuildContext context,
              ) =>
                  ClientsAppointmentPage(
                appointment,
                _model,
              ),
            );
          }
          if (pathElements[1] == 'clients') {
            final String clientId = pathElements[2];
            final client =
                _model.allClients.firstWhere((c) => c.id == clientId);
            if (pathElements.length > 3) {
              if (pathElements[3] == 'shops') {
                return MaterialPageRoute(
                  builder: (context) => ClientsShopsPage(
                    client,
                    _model.allShops,
                  ),
                );
              }
            }
            return MaterialPageRoute(
              builder: (context) => ClientsProfilePage(
                client,
              ),
            );
          }

          return null;
        },
        onUnknownRoute: (
          RouteSettings settings,
        ) =>
            MaterialPageRoute(
          builder: (
            BuildContext context,
          ) =>
              !_isAuthenticated ? const AuthLoginPage() : DashboardPage(_model),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
