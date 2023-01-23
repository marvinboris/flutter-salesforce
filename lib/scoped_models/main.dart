// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';

import './connected_products.dart';

class MainModel extends Model
    with
        ConnectedProducts,
        UsersModel,
        ProductsModel,
        ClientsModel,
        AppointmentsModel,
        UtilityModel {}
