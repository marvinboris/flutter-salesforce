import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:salesforce/models/appointment.dart';
import 'package:salesforce/models/client.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProducts on Model {
  List<Product> _products = [];
  List<Client> _clients = [];
  List<Appointment> _appointments = [];
  String? _selectedProductId;
  String? _selectedClientId;
  String? _selectedAppointmentId;
  User? _authenticatedUser;
  bool _isLoading = false;

  final String PREFIX = '/api/';
  final String CORS = "https://api.allorigins.win/get?url=";

  List<Map<String, String?>> _countries = [];
}

mixin AppointmentsModel on ConnectedProducts {
  List<Appointment> get allAppointments => List.from(_appointments);
  String? get selectedAppointmentId => _selectedAppointmentId;
  int get selectedAppointmentIndex {
    return _appointments.indexWhere(
        (Appointment appointment) => appointment.id == _selectedAppointmentId);
  }

  Appointment? get selectedAppointment {
    if (_selectedAppointmentId == null) return null;
    return _appointments.firstWhere(
        (Appointment appointment) => appointment.id == _selectedAppointmentId);
  }

  Future<bool> addAppointment({
    required String date,
    required String name,
    required String shop,
    required String object,
    required String location,
    required String company,
  }) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> appointmentData = {
      'name': name,
      'date': date,
      'shop': shop,
      'object': object,
      'location': location,
      'company': company,
    };

    try {
      final http.Response response = await http.post(
          Uri.parse(
              'https://flutter-products-28b39-default-rtdb.firebaseio.com/appointments.json?auth=${_authenticatedUser?.token}'),
          body: json.encode(appointmentData));

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = json.decode(response.body);
      final Appointment newAppointment = Appointment(
        id: responseData['name'],
        date: DateTime.parse(date),
        name: name,
        shop: shop,
        object: object,
        location: location,
        company: company,
      );
      _appointments.add(newAppointment);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateAppointment({
    required String date,
    required String name,
    required String shop,
    required String object,
    required String location,
    required String company,
  }) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'name': name,
      'date': date,
      'shop': shop,
      'object': object,
      'location': location,
      'company': company,
    };
    try {
      final http.Response response = await http.put(
          Uri.parse(
              'https://flutter-products-28b39-default-rtdb.firebaseio.com/appointments/$selectedAppointmentId.json?auth=${_authenticatedUser?.token}'),
          body: json.encode(updateData));

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Appointment updatedAppointment = Appointment(
        id: selectedAppointmentId!,
        date: DateTime.parse(date),
        name: name,
        shop: shop,
        object: object,
        location: location,
        company: company,
      );
      _appointments[selectedAppointmentIndex] = updatedAppointment;

      _isLoading = false;
      _selectedAppointmentId = null;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteAppointment() async {
    _isLoading = true;
    final deletedAppointmentId = selectedAppointmentId;
    _appointments.removeAt(selectedAppointmentIndex);
    _selectedAppointmentId = null;
    notifyListeners();

    try {
      final http.Response response = await http.delete(Uri.parse(
          'https://flutter-products-28b39-default-rtdb.firebaseio.com/products/$deletedAppointmentId.json?auth=${_authenticatedUser?.token}'));

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchAppointments({onlyForUser = false}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.get(
        Uri.parse(
            'https://flutter-products-28b39-default-rtdb.firebaseio.com/products.json?auth=${_authenticatedUser?.token}'),
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final List<Appointment> fetchedAppointmentList = [];
      final Map<String, dynamic>? appointmentListData =
          json.decode(response.body);
      if (appointmentListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      appointmentListData
          .forEach((String appointmentId, dynamic appointmentData) {
        final Appointment appointment = Appointment(
          id: appointmentId,
          date: DateTime.parse(appointmentData['date']),
          name: appointmentData['name'],
          shop: appointmentData['shop'],
          object: appointmentData['object'],
          location: appointmentData['location'],
          company: appointmentData['company'],
        );
        fetchedAppointmentList.add(appointment);
      });
      _appointments = fetchedAppointmentList;

      _isLoading = false;
      notifyListeners();
      _selectedAppointmentId = null;
      return;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return;
    }
  }

  void selectAppointment(String productId) {
    _selectedAppointmentId = productId;
    notifyListeners();
  }

  void toggleDisplayMode() {
    notifyListeners();
  }
}

mixin ClientsModel on ConnectedProducts {
  List<Client> get allClients => List.from(_clients);
  String? get selectedClientId => _selectedClientId;
  int get selectedClientIndex {
    return _clients
        .indexWhere((Client client) => client.id == _selectedClientId);
  }

  Client? get selectedClient {
    if (_selectedClientId == null) return null;
    return _clients
        .firstWhere((Client client) => client.id == _selectedClientId);
  }

  Future<bool> addClient({
    required String id,
    required String name,
    required String location,
    required String phone,
    required String email,
    required String joinedAt,
    String? photo,
    status = ClientStatus.Active,
  }) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> clientData = {
      'name': name,
      'phone': phone,
      'email': email,
      'joinedAt': joinedAt,
      'location': location,
      'photo': photo,
      'status': status,
    };

    try {
      final http.Response response = await http.post(
          Uri.parse(
              'https://flutter-products-28b39-default-rtdb.firebaseio.com/clients.json?auth=${_authenticatedUser?.token}'),
          body: json.encode(clientData));

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = json.decode(response.body);
      final Client newClient = Client(
        id: responseData['name'],
        name: name,
        phone: phone,
        email: email,
        joinedAt: DateTime.parse(joinedAt),
        location: location,
        photo: photo,
        status: status,
      );
      _clients.add(newClient);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateClient({
    required String name,
    required String location,
    required String phone,
    required String email,
    required String joinedAt,
    String? photo,
    status = ClientStatus.Active,
  }) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'name': name,
      'phone': phone,
      'email': email,
      'joinedAt': joinedAt,
      'location': location,
      'photo': photo,
      'status': status,
    };
    try {
      final http.Response response = await http.put(
          Uri.parse(
              'https://flutter-products-28b39-default-rtdb.firebaseio.com/clients/$selectedClientId.json?auth=${_authenticatedUser?.token}'),
          body: json.encode(updateData));

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Client updatedClient = Client(
        id: selectedClientId!,
        name: name,
        phone: phone,
        email: email,
        joinedAt: DateTime.parse(joinedAt),
        location: location,
        photo: photo,
        status: status,
      );
      _clients[selectedClientIndex] = updatedClient;

      _isLoading = false;
      _selectedClientId = null;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteClient() async {
    _isLoading = true;
    final deletedClientId = selectedClientId;
    _clients.removeAt(selectedClientIndex);
    _selectedClientId = null;
    notifyListeners();

    try {
      final http.Response response = await http.delete(Uri.parse(
          'https://flutter-products-28b39-default-rtdb.firebaseio.com/products/$deletedClientId.json?auth=${_authenticatedUser?.token}'));

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchClients({onlyForUser = false}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.get(
        Uri.parse(
            'https://flutter-products-28b39-default-rtdb.firebaseio.com/products.json?auth=${_authenticatedUser?.token}'),
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final List<Client> fetchedClientList = [];
      final Map<String, dynamic>? clientListData = json.decode(response.body);
      if (clientListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      clientListData.forEach((String clientId, dynamic clientData) {
        final Client client = Client(
          id: clientId,
          name: clientData['name'],
          phone: clientData['phone'],
          email: clientData['email'],
          joinedAt: clientData['joinedAt'],
          location: clientData['location'],
          photo: clientData['photo'],
          status: clientData['status'],
        );
        fetchedClientList.add(client);
      });
      _clients = fetchedClientList;

      _isLoading = false;
      notifyListeners();
      _selectedClientId = null;
      return;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return;
    }
  }

  void selectClient(String clientId) {
    _selectedClientId = clientId;
    notifyListeners();
  }

  void toggleDisplayMode() {
    notifyListeners();
  }
}

mixin ProductsModel on ConnectedProducts {
  bool _showFavorites = false;

  List<Product> get allProducts => List.from(_products);
  String? get selectedProductId => _selectedProductId;
  int get selectedProductIndex {
    return _products
        .indexWhere((Product product) => product.id == _selectedProductId);
  }

  Product? get selectedProduct {
    if (_selectedProductId == null) return null;
    return _products
        .firstWhere((Product product) => product.id == _selectedProductId);
  }

  bool get displayFavoritesOnly => _showFavorites;

  Future<bool> addProduct(
      String title, String description, String image, double price) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://www.history.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTc3OTk5Njc1MTU5MjI1OTY1/valentines-day-chocolate-gettyimages-923430892.jpg',
      'price': price,
      'userEmail': _authenticatedUser?.email,
      'userId': _authenticatedUser?.id,
    };

    try {
      final http.Response response = await http.post(
          Uri.parse(
              'https://flutter-products-28b39-default-rtdb.firebaseio.com/products.json?auth=${_authenticatedUser?.token}'),
          body: json.encode(productData));

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
        id: responseData['name'],
        title: title,
        price: price,
      );
      _products.add(newProduct);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProduct(
      String title, String description, String image, double price) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image':
          'https://www.history.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTc3OTk5Njc1MTU5MjI1OTY1/valentines-day-chocolate-gettyimages-923430892.jpg',
      'price': price,
    };
    try {
      final http.Response response = await http.put(
          Uri.parse(
              'https://flutter-products-28b39-default-rtdb.firebaseio.com/products/$selectedProductId.json?auth=${_authenticatedUser?.token}'),
          body: json.encode(updateData));

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Product updatedProduct = Product(
        id: selectedProductId!,
        title: title,
        price: price,
      );
      _products[selectedProductIndex] = updatedProduct;

      _isLoading = false;
      _selectedProductId = null;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteProduct() async {
    _isLoading = true;
    final deletedProductId = selectedProductId;
    _products.removeAt(selectedProductIndex);
    _selectedProductId = null;
    notifyListeners();

    try {
      final http.Response response = await http.delete(Uri.parse(
          'https://flutter-products-28b39-default-rtdb.firebaseio.com/products/$deletedProductId.json?auth=${_authenticatedUser?.token}'));

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchProducts({onlyForUser = false}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.get(
        Uri.parse(
            'https://flutter-products-28b39-default-rtdb.firebaseio.com/products.json?auth=${_authenticatedUser?.token}'),
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final List<Product> fetchedProductList = [];
      final Map<String, dynamic>? productListData = json.decode(response.body);
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
          id: productId,
          title: productData['title'],
          price: productData['price'],
        );
        fetchedProductList.add(product);
      });
      _products = fetchedProductList;

      _isLoading = false;
      notifyListeners();
      _selectedProductId = null;
      return;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return;
    }
  }

  void selectProduct(String productId) {
    _selectedProductId = productId;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UsersModel on ConnectedProducts {
  Timer? _authTimer;
  final PublishSubject<bool> _userSubject = PublishSubject();

  User? get user => _authenticatedUser;
  PublishSubject<bool> get userSubject => _userSubject;

  Future<Map<String, dynamic>> authLogin(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // ignore: constant_identifier_names
    const String API_KEY = 'AIzaSyCdTpsAch89S6qFpz5gNzuMVRYa6hjhZcg';
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    http.Response response;
    final Uri uri = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$API_KEY');
    response = await http.post(
      uri,
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong';
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authenticated succeeded!';
      _authenticatedUser = User(
        id: responseData['localId'],
        email: email,
        token: responseData['idToken'],
      );

      final int expiresIn = int.parse(responseData['expiresIn']);
      final DateTime now = DateTime.now();
      final DateTime expiryTime = now.add(Duration(seconds: expiresIn));

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', responseData['localId']);
      prefs.setString('expiryTime', expiryTime.toIso8601String());

      setAuthTimeout(expiresIn);
      _userSubject.add(true);
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This email was not found.';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'The password is invalid.';
    }

    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  Future<Map<String, dynamic>> authSignup(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // ignore: constant_identifier_names
    const String API_KEY = 'AIzaSyCdTpsAch89S6qFpz5gNzuMVRYa6hjhZcg';
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    http.Response response;
    Uri uri = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$API_KEY');
    response = await http.post(
      uri,
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong';
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authenticated succeeded!';
      _authenticatedUser = User(
        id: responseData['localId'],
        email: email,
        token: responseData['idToken'],
      );

      final int expiresIn = int.parse(responseData['expiresIn']);
      final DateTime now = DateTime.now();
      final DateTime expiryTime = now.add(Duration(seconds: expiresIn));

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', responseData['localId']);
      prefs.setString('expiryTime', expiryTime.toIso8601String());

      setAuthTimeout(expiresIn);
      _userSubject.add(true);
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email already exists.';
    }

    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? expiryTimeString = prefs.getString('expiryTime');

    List countries = [];
    try {
      final http.Response phoneRes =
          await http.get(Uri.parse('${CORS}http://country.io/phone.json'));
      final http.Response namesRes =
          await http.get(Uri.parse('${CORS}http://country.io/names.json'));

      final Map<String, String> phone =
          Map.castFrom(json.decode(json.decode(phoneRes.body)['contents']));
      final Map<String, String> names =
          Map.castFrom(json.decode(json.decode(namesRes.body)['contents']));

      // ignore: avoid_function_literals_in_foreach_calls
      countries = phone.keys
          .map((key) =>
              ({'country': key, 'code': phone[key], 'name': names[key]}))
          .toList();
      countries.sort((a, b) => a['country'].compareTo(b['country']));
    } catch (e) {
      countries = [];
      if (kDebugMode) {
        print(e);
      }
    }
    _countries = List.from(countries);

    if (token != null) {
      final DateTime now = DateTime.now();
      final DateTime parsedExpiryTime = DateTime.parse(expiryTimeString!);
      if (parsedExpiryTime.isBefore(now)) {
        _authenticatedUser = null;
        notifyListeners();
        return;
      }

      final String userEmail = prefs.getString('userEmail')!;
      final String userId = prefs.getString('userId')!;
      final int tokenLifespan = parsedExpiryTime.difference(now).inSeconds;
      _authenticatedUser = User(
        id: userId,
        email: userEmail,
        token: token,
      );

      _userSubject.add(true);
      setAuthTimeout(tokenLifespan);
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  void logout() async {
    _authenticatedUser = null;
    _authTimer?.cancel();

    _userSubject.add(false);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
  }

  void setAuthTimeout(int time) {
    _authTimer = Timer(Duration(seconds: time), logout);
  }
}

mixin UtilityModel on ConnectedProducts {
  bool get isLoading => _isLoading;
  List<Map<String, String?>> get countries => _countries;
}
