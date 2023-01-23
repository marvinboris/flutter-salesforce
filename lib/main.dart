import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import './models/shop.dart';
import './models/appointment.dart';
import './models/client.dart';

import './scoped_models/main.dart';

import './pages/auth/login.dart';
import './pages/clients.dart';
import './pages/clients_appointment.dart';
import './pages/clients_create.dart';
import './pages/clients_profile.dart';
import './pages/clients_shops.dart';
import './pages/dashboard.dart';
import './pages/payment.dart';
import './pages/payment_completed.dart';
import './pages/schedule.dart';
import './pages/invoice.dart';

void main() {
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
          backgroundColor: const Color(0xfff9f9f9),
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: const MaterialColor(0xff4f86f4, {
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
          })).copyWith(
              secondary: const MaterialColor(0xff9b73fa, {
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
          })),
          buttonTheme: const ButtonThemeData(buttonColor: Color(0xff4F87F4)),
        ),
        routes: {
          '/': (BuildContext context) => const AuthLoginPage(),
          '/dashboard': (BuildContext context) => const DashboardPage(),
          '/schedule': (BuildContext context) => const MySchedulePage(),
          '/invoice': (BuildContext context) => const ManageInvoicePage(),
          '/clients': (BuildContext context) => const MyClientsPage(),
          '/clients/add': (BuildContext context) => const CreateClientPage(),
          '/payment': (BuildContext context) => const DuePaymentPage(),
          '/payment/success': (BuildContext context) =>
              const PaymentCompleted(),
        },
        onGenerateRoute: (RouteSettings settings) {
          // if (!_isAuthenticated) {
          //   return MaterialPageRoute(
          //     builder: (BuildContext context) => AuthPage(),
          //   );
          // }

          final List<String> pathElements = (settings.name ?? '').split('/');

          if (pathElements[0] != '') return null;
          if (pathElements[1] == 'schedule') {
            final String appointmentId = pathElements[2];
            // final Appointment appointment = _model.allAppointments.firstWhere(
            //     (Appointment appointment) => appointment.id == appointmentId);
            final Appointment appointment = Appointment(
              id: Random().toString(),
              date: DateTime(2023, 6, 14, 17, 45, 23),
              name: 'Mr Jean Clenon M.',
              shop: '',
              object: 'Stock replenish',
              location:
                  'DLA - Bonamoussadi, face Hotel la fourchette, a 200m de la route principale.',
              company: 'Chococam Dla',
              status: AppointmentStatus.Done,
            );
            return MaterialPageRoute(
              builder: (BuildContext context) =>
                  ClientsAppointmentPage(appointment),
            );
          }
          if (pathElements[1] == 'clients') {
            final String clientId = pathElements[2];
            // final Client client = _model.allClients.firstWhere(
            //     (Client client) => client.id == clientId);
            final Client client = Client(
              id: Random().toString(),
              name: 'Joseph Kamdem',
              email: 'demo@contact.com',
              phone: '(237) 698 90 11 22 33',
              joinedAt: DateTime(2023, 3, 10),
              location: 'Santa Lucia - DLA, Cite Cic',
              photo: 'irene-strong-v2aKnjMbP_k-unsplash.jpg',
            );
            final List<Shop> shops = [
              Shop(
                email: 'demo@contact.com',
                location: 'DLA, Cite Cic',
                manager: 'Joseph Kamdem',
                name: 'Santa Lucia',
                phone: '(237) 698 90 11 22 33',
                photo: 'fikri-rasyid-ezeC8-clZSs-unsplash.jpg',
              ),
              Shop(
                email: 'demo@contact.com',
                location: 'DLA, Bonamoussadi',
                manager: 'Joseph Kamdem',
                name: 'Santa Lucia',
                phone: '(237) 698 90 11 22 33',
                photo: 'nrd-D6Tu_L3chLE-unsplash.jpg',
              ),
            ];
            if (pathElements.length > 3) {
              if (pathElements[3] == 'shops') {
                return MaterialPageRoute(
                    builder: (context) => ClientsShopsPage(client, shops));
              }
            }
            return MaterialPageRoute(
              builder: (context) => ClientsProfilePage(client),
            );
          }

          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => !_isAuthenticated
                ? const AuthLoginPage()
                : const DashboardPage(),
          );
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
