import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gasfast/global/environment.dart';
import 'package:gasfast/src/helpers/debouncer.dart';
import 'package:gasfast/src/models/balance/send_balance_responce.dart';
import 'package:gasfast/src/models/contact/contact_list_response.dart';
import 'package:gasfast/src/models/contact/contact_search_response.dart';
import 'package:gasfast/src/models/errors/error_response.dart';
import 'package:gasfast/src/models/moves/deposit_response.dart';

class ContactService {
  // Singleton
  ContactService._privateConstructor();
  static final ContactService _instance = ContactService._privateConstructor();
  factory ContactService() {
    return _instance;
  }

  ErrorResponse? error;

  // Create storage
  final _storage = new FlutterSecureStorage();
  final _dio = new Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 400));

  PartnerL? partnerL;

  String? message;

  final StreamController<ContacSearchResponse> _contactStreamController =
      new StreamController<ContacSearchResponse>.broadcast();

  Stream<ContacSearchResponse> get sugerenciasStreamController =>
      this._contactStreamController.stream;

  void dispose() {
    _contactStreamController.close();
  }

  Future<ContacSearchResponse> getResultsByQuery(String search) async {
    final token = await this._storage.read(key: 'token');

    _dio.options.headers["Authorization"] = "Bearer " + token!;
    final url = '${Environment.apiUrl}/partner/show';

    try {
      final resp = await this._dio.get(url, queryParameters: {
        'membership': search,
      });

      //print(resp.data);
      message = resp.data['message'];
      final searchResponse = ContacSearchResponse.fromJson(resp.data);

      return searchResponse;
    } catch (e) {
      return ContacSearchResponse(ok: false);
    }
  }

  void getSugerenciasPorQuery(String busqueda) async {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final resultados = await this.getResultsByQuery(value!);
      this._contactStreamController.add(resultados);
      print(resultados.partner);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());
  }

  Future<ErrorResponse> addContact(String id) async {
    final token = await this._storage.read(key: 'token');

    _dio.options.headers["Authorization"] = "Bearer " + token!;
    final url = '${Environment.apiUrl}/partner/store';

    try {
      final resp = await this._dio.post(url, queryParameters: {
        'id': id,
      });

      final responseResponse = ErrorResponse.fromJson(resp.data);
      //print(resp.data);

      return responseResponse;
    } catch (e) {
      return ErrorResponse(ok: false, message: e.toString());
    }
  }

  Future<ErrorResponse> deleteContact(String id) async {
    final token = await this._storage.read(key: 'token');

    _dio.options.headers["Authorization"] = "Bearer " + token!;
    final url = '${Environment.apiUrl}/partner/destroy';

    try {
      final resp = await this._dio.post(url, queryParameters: {
        'id': id,
      });

      final responseResponse = ErrorResponse.fromJson(resp.data);

      return responseResponse;
    } catch (e) {
      return ErrorResponse(ok: false, message: e.toString());
    }
  }

  Future<List<PartnerL>> contactList() async {
    final token = await this._storage.read(key: 'token');

    _dio.options.headers["Authorization"] = "Bearer " + token!;
    final url = '${Environment.apiUrl}/partner';

    try {
      final resp = await this._dio.get(url);
      final responseResponse = ContactListResponse.fromJson(resp.data);
      print(resp.data);
      return responseResponse.partners!;
    } catch (e) {
      return [];
    }
  }

  Future<DepositResponse> deposittList() async {
    final token = await this._storage.read(key: 'token');

    _dio.options.headers["Authorization"] = "Bearer " + token!;
    final url = '${Environment.apiUrl}/deposit';

    try {
      final resp = await this._dio.get(url, queryParameters: {
        'start': '2021-01-01',
        'end': '2021-07-19',
      });
      final responseResponse = DepositResponse.fromJson(resp.data);
      print(resp.data);
      return responseResponse;
    } catch (e) {
      return DepositResponse(ok: false, deposits: []);
    }
  }

  Future<SendBalanceResponse> sendBalance(String id, String balance) async {
    final token = await this._storage.read(key: 'token');

    _dio.options.headers["Authorization"] = "Bearer " + token!;
    final url = '${Environment.apiUrl}/shared/store';

    try {
      final resp = await this
          ._dio
          .post(url, queryParameters: {'id': id, 'balance': balance});

      final responseResponse = SendBalanceResponse.fromJson(resp.data);

      //print(responseResponse);
      return responseResponse;
    } catch (e) {
      return SendBalanceResponse(ok: false, message: e.toString());
    }
  }

  Future<ErrorResponse> payment(
      String response,
      String gasoline,
      String payment,
      String liters,
      String sale,
      // ignore: non_constant_identifier_names
      String dispatcher_id,
      // ignore: non_constant_identifier_names
      String no_bomb,
      // ignore: non_constant_identifier_names
      String no_island) async {
    final token = await this._storage.read(key: 'token');

    _dio.options.headers["Authorization"] = "Bearer " + token!;
    final url = '${Environment.apiUrl}/sales/store';

    try {
      final resp = await this._dio.post(url, queryParameters: {
        'response': response,
        'gasoline': gasoline,
        'payment': payment,
        'liters': liters,
        'sale': sale,
        'dispatcher_id': dispatcher_id,
        'no_bomb': no_bomb,
        'no_island': no_island
      });

      final responseResponse = ErrorResponse.fromJson(resp.data);
      //print(responseResponse.message);

      return responseResponse;
    } catch (e) {
      return ErrorResponse(ok: false, message: e.toString());
    }
  }

  bool validateStatus(Response<dynamic> data) {
    if (data.statusCode == 200) {
      return true;
    } else if (data.statusCode! >= 500) {
      return false;
    } else {
      return false;
    }
  }
}
