import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/subjects.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/appointment.dart';
import '../models/client.dart';
import '../models/invoice.dart';
import '../models/method.dart';
import '../models/product.dart';
import '../models/shop.dart';
import '../models/stop.dart';
import '../models/transaction.dart';
import '../models/user.dart';

mixin ConnectedProducts on Model {
  List<Appointment> _appointments = [];
  String? _selectedAppointmentId;

  List<Client> _clients = [];
  String? _selectedClientId;

  List<Invoice> _invoices = [];
  String? _selectedInvoiceId;

  List<Method> _methods = [];
  String? _selectedMethodId;

  List<Product> _products = [];
  String? _selectedProductId;

  List<Shop> _shops = [];
  String? _selectedShopId;

  List<Stop> _stops = [];
  String? _selectedStopId;

  List<Transaction> _transactions = [];
  String? _selectedTransactionId;

  User? _authenticatedUser;

  bool _isLoading = false;

  final String APP_URL = dotenv.env['APP_URL']!;
  final String CORS = "https://api.allorigins.win/get?url=";

  String get PREFIX => '$APP_URL/api/backend/user/';

  List<Map<String, String?>> _countries = [];

  Map<String, String> get headers => {
        HttpHeaders.authorizationHeader: 'Bearer ${_authenticatedUser?.token}',
        'Content-Type': 'application/json; charset=UTF-8',
      };
}

mixin AppointmentsModel on ConnectedProducts {
  String get appointmentsPrefix => '${PREFIX}appointments';

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

    final Map<String, dynamic> data = {
      'name': name,
      'date': date,
      'shop': shop,
      'object': object,
      'location': location,
      'company': company,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(appointmentsPrefix),
        body: jsonEncode(data),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      data.addEntries({'id': responseData['id']}.entries);
      _appointments.add(Appointment.fromJson(data));

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

    final Map<String, dynamic> data = {
      'name': name,
      'date': date,
      'shop': shop,
      'object': object,
      'location': location,
      'company': company,
    };

    try {
      final http.Response response = await http.put(
        Uri.parse('$appointmentsPrefix/$selectedAppointmentId'),
        body: jsonEncode(data),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      data.addEntries({'id': selectedAppointmentId!}.entries);
      _appointments[selectedAppointmentIndex] = Appointment.fromJson(data);

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
      final http.Response response = await http.delete(
        Uri.parse('$appointmentsPrefix/$deletedAppointmentId'),
        headers: headers,
      );

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

  Future<void> fetchAppointments() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.get(
        Uri.parse(appointmentsPrefix),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final List<Appointment> fetchedAppointmentList = [];
      final Map<String, dynamic>? appointmentListData =
          jsonDecode(response.body);
      if (appointmentListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      for (var appointmentData
          in (appointmentListData['appointments'] as List<dynamic>)) {
        fetchedAppointmentList.add(Appointment.fromJson(appointmentData));
      }
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

  void selectAppointment(String appointmentId) {
    _selectedAppointmentId = appointmentId;
    notifyListeners();
  }
}

mixin ClientsModel on ConnectedProducts {
  String get clientsPrefix => '${PREFIX}clients';

  List<Client> get allClients => List.from(_clients);
  String? get selectedClientId => _selectedClientId;
  int get selectedClientIndex =>
      _clients.indexWhere((Client client) => client.id == _selectedClientId);
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

    final Map<String, dynamic> data = {
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
        Uri.parse(clientsPrefix),
        body: jsonEncode(data),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      data.addEntries({'id': responseData['id']}.entries);
      _clients.add(Client.fromJson(data));

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

    final Map<String, dynamic> data = {
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
        Uri.parse('$clientsPrefix/$selectedClientId'),
        body: jsonEncode(data),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      data.addEntries({'id': selectedClientId!}.entries);
      _clients[selectedClientIndex] = Client.fromJson(data);

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
      final http.Response response = await http.delete(
        Uri.parse('$clientsPrefix/$deletedClientId'),
        headers: headers,
      );

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

  Future<void> fetchClients() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.get(
        Uri.parse(clientsPrefix),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final List<Client> fetchedClientList = [];
      final Map<String, dynamic>? clientListData = jsonDecode(response.body);
      if (clientListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      for (var clientData in (clientListData['clients'] as List<dynamic>)) {
        fetchedClientList.add(Client.fromJson(clientData));
      }
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
}

mixin InvoicesModel on ConnectedProducts {
  String get invoicesPrefix => '${PREFIX}invoices';

  List<Invoice> get allInvoices => List.from(_invoices);
  String? get selectedInvoiceId => _selectedInvoiceId;
  int get selectedInvoiceIndex => _invoices
      .indexWhere((Invoice invoice) => invoice.id == _selectedInvoiceId);
  Invoice? get selectedInvoice {
    if (_selectedInvoiceId == null) return null;
    return _invoices
        .firstWhere((Invoice invoice) => invoice.id == _selectedInvoiceId);
  }

  Future<bool> addInvoice({
    required String amount,
    required String location,
    required String client,
    required String number,
    required String dateTime,
    required String method,
    status = InvoiceStatus.Pending,
  }) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> data = {
      'amount': amount,
      'client': client,
      'number': number,
      'dateTime': dateTime,
      'location': location,
      'method': method,
      'status': status,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(invoicesPrefix),
        body: jsonEncode(data),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      data.addEntries({'id': responseData['id']}.entries);
      _invoices.add(Invoice.fromJson(data));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateInvoice({
    required String amount,
    required String location,
    required String client,
    required String number,
    required String dateTime,
    required String method,
    status = InvoiceStatus.Pending,
  }) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> data = {
      'amount': amount,
      'client': client,
      'number': number,
      'dateTime': dateTime,
      'location': location,
      'method': method,
      'status': status,
    };

    try {
      final http.Response response = await http.put(
        Uri.parse('$invoicesPrefix/$selectedInvoiceId'),
        body: jsonEncode(data),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      data.addEntries({'id': selectedInvoiceId!}.entries);
      _invoices[selectedInvoiceIndex] = Invoice.fromJson(data);

      _isLoading = false;
      _selectedInvoiceId = null;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteInvoice() async {
    _isLoading = true;
    final deletedInvoiceId = selectedInvoiceId;
    _invoices.removeAt(selectedInvoiceIndex);
    _selectedInvoiceId = null;
    notifyListeners();

    try {
      final http.Response response = await http.delete(
        Uri.parse('$invoicesPrefix/$deletedInvoiceId'),
        headers: headers,
      );

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

  Future<void> fetchInvoices() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.get(
        Uri.parse(invoicesPrefix),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final List<Invoice> fetchedInvoiceList = [];
      final Map<String, dynamic>? invoiceListData = jsonDecode(response.body);
      if (invoiceListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      for (var invoiceData in (invoiceListData['invoices'] as List<dynamic>)) {
        fetchedInvoiceList.add(Invoice.fromJson(invoiceData));
      }
      _invoices = fetchedInvoiceList;

      _isLoading = false;
      notifyListeners();
      _selectedInvoiceId = null;
      return;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return;
    }
  }

  void selectInvoice(String invoiceId) {
    _selectedInvoiceId = invoiceId;
    notifyListeners();
  }
}

mixin MethodsModel on ConnectedProducts {
  String get methodsPrefix => '${PREFIX}methods';

  List<Method> get allMethods => List.from(_methods);
  String? get selectedMethodId => _selectedMethodId;
  int get selectedMethodIndex =>
      _methods.indexWhere((Method method) => method.id == _selectedMethodId);
  Method? get selectedMethod {
    if (_selectedMethodId == null) return null;
    return _methods
        .firstWhere((Method method) => method.id == _selectedMethodId);
  }

  Future<void> fetchMethods() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.get(
        Uri.parse(methodsPrefix),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final List<Method> fetchedMethodList = [];
      final Map<String, dynamic>? methodListData = jsonDecode(response.body);
      if (methodListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      for (var methodData in (methodListData['methods'] as List<dynamic>)) {
        fetchedMethodList.add(Method.fromJson(methodData));
      }
      _methods = fetchedMethodList;

      _isLoading = false;
      notifyListeners();
      _selectedMethodId = null;
      return;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return;
    }
  }
}

mixin ProductsModel on ConnectedProducts {
  String get productsPrefix => '${PREFIX}products';

  List<Product> get allProducts => List.from(_products);
  String? get selectedProductId => _selectedProductId;
  int get selectedProductIndex => _products
      .indexWhere((Product product) => product.id == _selectedProductId);
  Product? get selectedProduct {
    if (_selectedProductId == null) return null;
    return _products
        .firstWhere((Product product) => product.id == _selectedProductId);
  }

  Future<bool> addProduct({
    required String title,
    required double price,
    required String promo,
  }) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> data = {
      'title': title,
      'price': price,
      'promo': promo,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(productsPrefix),
        body: jsonEncode(data),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      data.addEntries({'id': responseData['id']}.entries);
      _products.add(Product.fromJson(data));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProduct({
    required String title,
    required double price,
    required String promo,
  }) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> data = {
      'title': title,
      'price': price,
      'promo': promo,
    };

    try {
      final http.Response response = await http.put(
        Uri.parse('$productsPrefix/$selectedProductId'),
        body: jsonEncode(data),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      data.addEntries({'id': selectedProductId!}.entries);
      _products[selectedProductIndex] = Product.fromJson(data);

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
      final http.Response response = await http.delete(
        Uri.parse('$productsPrefix/$deletedProductId'),
        headers: headers,
      );

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

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.get(
        Uri.parse(productsPrefix),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final List<Product> fetchedProductList = [];
      final Map<String, dynamic>? productListData = jsonDecode(response.body);
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      for (var productData in (productListData['products'] as List<dynamic>)) {
        fetchedProductList.add(Product.fromJson(productData));
      }
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
}

mixin ShopsModel on ConnectedProducts {
  String get shopsPrefix => '${PREFIX}shops';

  List<Shop> get allShops => List.from(_shops);
  String? get selectedShopId => _selectedShopId;
  int get selectedShopIndex =>
      _shops.indexWhere((Shop shop) => shop.id == _selectedShopId);
  Shop? get selectedShop {
    if (_selectedShopId == null) return null;
    return _shops.firstWhere((Shop shop) => shop.id == _selectedShopId);
  }

  Future<bool> addShop({
    required String manager,
    required String name,
    required String location,
    required String phone,
    required String email,
    required String photo,
    status = InvoiceStatus.Pending,
  }) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> data = {
      'manager': manager,
      'location': location,
      'phone': phone,
      'email': email,
      'name': name,
      'photo': photo,
      'status': status,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(shopsPrefix),
        body: jsonEncode(data),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      data.addEntries({'id': responseData['id']}.entries);
      _shops.add(Shop.fromJson(data));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateShop({
    required String manager,
    required String name,
    required String location,
    required String phone,
    required String email,
    required String photo,
    status = InvoiceStatus.Pending,
  }) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> data = {
      'manager': manager,
      'location': location,
      'phone': phone,
      'email': email,
      'name': name,
      'photo': photo,
      'status': status,
    };

    try {
      final http.Response response = await http.put(
        Uri.parse('$shopsPrefix/$selectedShopId'),
        body: jsonEncode(data),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      data.addEntries({'id': selectedShopId!}.entries);
      _shops[selectedShopIndex] = Shop.fromJson(data);

      _isLoading = false;
      _selectedShopId = null;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteShop() async {
    _isLoading = true;
    final deletedShopId = selectedShopId;
    _shops.removeAt(selectedShopIndex);
    _selectedShopId = null;
    notifyListeners();

    try {
      final http.Response response = await http.delete(
        Uri.parse('$shopsPrefix/$deletedShopId'),
        headers: headers,
      );

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

  Future<void> fetchShops() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.get(
        Uri.parse(shopsPrefix),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final List<Shop> fetchedShopList = [];
      final Map<String, dynamic>? shopListData = jsonDecode(response.body);
      if (shopListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      for (var shopData in (shopListData['shops'] as List<dynamic>)) {
        fetchedShopList.add(Shop.fromJson(shopData));
      }
      _shops = fetchedShopList;

      _isLoading = false;
      notifyListeners();
      _selectedShopId = null;
      return;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return;
    }
  }

  void selectShop(String shopId) {
    _selectedShopId = shopId;
    notifyListeners();
  }
}

mixin StopsModel on ConnectedProducts {
  String get stopsPrefix => '${PREFIX}stops';

  List<Stop> get allStops => List.from(_stops);
  String? get selectedStopId => _selectedStopId;
  int get selectedStopIndex =>
      _stops.indexWhere((Stop stop) => stop.id == _selectedStopId);
  Stop? get selectedStop {
    if (_selectedStopId == null) return null;
    return _stops.firstWhere((Stop stop) => stop.id == _selectedStopId);
  }

  Future<bool> addStop({
    required String location,
    required String reason,
    required String startTime,
    String? endTime,
  }) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> data = {
      'location': location,
      'reason': reason,
      'startTime': startTime,
      'endTime': endTime,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(stopsPrefix),
        body: jsonEncode(data),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      data.addEntries({'id': responseData['id']}.entries);
      _stops.add(Stop.fromJson(data));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateStop({
    required String location,
    required String reason,
    required String startTime,
    String? endTime,
  }) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> data = {
      'location': location,
      'reason': reason,
      'startTime': startTime,
      'endTime': endTime,
    };

    try {
      final http.Response response = await http.put(
        Uri.parse('$stopsPrefix/$selectedStopId'),
        body: jsonEncode(data),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      data.addEntries({'id': selectedStopId!}.entries);
      _stops[selectedStopIndex] = Stop.fromJson(data);

      _isLoading = false;
      _selectedStopId = null;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteStop() async {
    _isLoading = true;
    final deletedStopId = selectedStopId;
    _stops.removeAt(selectedStopIndex);
    _selectedStopId = null;
    notifyListeners();

    try {
      final http.Response response = await http.delete(
        Uri.parse('$stopsPrefix/$deletedStopId'),
        headers: headers,
      );

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

  Future<void> fetchStops() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.get(
        Uri.parse(stopsPrefix),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final List<Stop> fetchedStopList = [];
      final Map<String, dynamic>? stopListData = jsonDecode(response.body);
      if (stopListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      for (var stopData in (stopListData['stops'] as List<dynamic>)) {
        fetchedStopList.add(Stop.fromJson(stopData));
      }
      _stops = fetchedStopList;

      _isLoading = false;
      notifyListeners();
      _selectedStopId = null;
      return;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return;
    }
  }

  void selectStop(String stopId) {
    _selectedStopId = stopId;
    notifyListeners();
  }
}

mixin TransactionsModel on ConnectedProducts {
  String get transactionsPrefix => '${PREFIX}transactions';

  List<Transaction> get allTransactions => List.from(_transactions);
  String? get selectedTransactionId => _selectedTransactionId;
  int get selectedTransactionIndex => _transactions.indexWhere(
      (Transaction transaction) => transaction.id == _selectedTransactionId);
  Transaction? get selectedTransaction {
    if (_selectedTransactionId == null) return null;
    return _transactions.firstWhere(
        (Transaction transaction) => transaction.id == _selectedTransactionId);
  }

  Future<bool> addTransaction({
    required String client,
    required String product,
    required int qty,
  }) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> data = {
      'client': client,
      'product': product,
      'qty': qty,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(transactionsPrefix),
        body: jsonEncode(data),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      data.addEntries({
        'id': responseData['id'],
        'date': responseData['createdAt']
      }.entries);
      _transactions.add(Transaction.fromJson(data));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateTransaction({
    required String client,
    required String product,
    required int qty,
  }) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> data = {
      'client': client,
      'product': product,
      'qty': qty,
    };

    try {
      final http.Response response = await http.put(
        Uri.parse('$transactionsPrefix/$selectedTransactionId'),
        body: jsonEncode(data),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      data.addEntries({
        'id': selectedTransactionId!,
        'date': responseData['createdAt']
      }.entries);
      _transactions[selectedTransactionIndex] = Transaction.fromJson(data);

      _isLoading = false;
      _selectedTransactionId = null;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteTransaction() async {
    _isLoading = true;
    final deletedTransactionId = selectedTransactionId;
    _transactions.removeAt(selectedTransactionIndex);
    _selectedTransactionId = null;
    notifyListeners();

    try {
      final http.Response response = await http.delete(
        Uri.parse('$transactionsPrefix/$deletedTransactionId'),
        headers: headers,
      );

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

  Future<void> fetchTransactions() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.get(
        Uri.parse(transactionsPrefix),
        headers: headers,
      );

      if (![200, 201].contains(response.statusCode)) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final List<Transaction> fetchedTransactionList = [];
      final Map<String, dynamic>? transactionListData =
          jsonDecode(response.body);
      if (transactionListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      for (var transactionData
          in (transactionListData['transactions'] as List<dynamic>)) {
        fetchedTransactionList.add(Transaction.fromJson(transactionData));
      }
      _transactions = fetchedTransactionList;

      _isLoading = false;
      notifyListeners();
      _selectedTransactionId = null;
      return;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return;
    }
  }

  void selectTransaction(String transactionId) {
    _selectedTransactionId = transactionId;
    notifyListeners();
  }
}

mixin UsersModel on ConnectedProducts {
  Timer? _authTimer;
  final PublishSubject<bool> _userSubject = PublishSubject();

  User? get user => _authenticatedUser;
  PublishSubject<bool> get userSubject => _userSubject;

  Future<Map<String, dynamic>> authLogin(
    String email,
    String password,
  ) async {
    _isLoading = true;
    notifyListeners();

    final response = await http.post(
      Uri.parse('$APP_URL/api/auth/user/login'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    bool hasError = true;
    String message = 'Something went wrong';
    if (responseData.containsKey('token')) {
      hasError = false;
      message = 'Authenticated succeeded!';
      _authenticatedUser = User(
        token: responseData['token'],
        data: responseData['data'],
      );

      final int expiresAt = responseData['expiresAt'];
      final DateTime expiryTime =
          DateTime.fromMillisecondsSinceEpoch(expiresAt);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['token']);
      prefs.setString('data', jsonEncode(responseData['data']));
      prefs.setString('expiryTime', expiryTime.toIso8601String());

      setAuthTimeout(expiresAt - DateTime.now().millisecondsSinceEpoch);
      _userSubject.add(true);
    } else {
      message = responseData['message']['content'];
    }

    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? data = prefs.getString('data');
    final String? expiryTimeString = prefs.getString('expiryTime');

    List countries = [];
    final String prefix = '${CORS}http://country.io/';

    try {
      final http.Response phoneRes =
          await http.get(Uri.parse('${prefix}phone.json'));
      final http.Response namesRes =
          await http.get(Uri.parse('${prefix}names.json'));

      final Map<String, String> phone =
          Map.castFrom(jsonDecode(jsonDecode(phoneRes.body)['contents']));
      final Map<String, String> names =
          Map.castFrom(jsonDecode(jsonDecode(namesRes.body)['contents']));

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

      final int tokenLifespan = parsedExpiryTime.difference(now).inSeconds;
      _authenticatedUser = User(
        data: jsonDecode(data!),
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
    prefs.remove('data');
  }

  void setAuthTimeout(int time) {
    _authTimer = Timer(Duration(seconds: time), logout);
  }
}

mixin UtilityModel on ConnectedProducts {
  bool get isLoading => _isLoading;
  List<Map<String, String?>> get countries => _countries;
}
