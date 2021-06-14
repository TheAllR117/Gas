import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
import 'package:gasfast/global/environment.dart';
import 'package:gasfast/src/models/errors/error_response.dart';
import 'package:gasfast/src/models/stripe/payment_intent_response.dart';
import 'package:gasfast/src/models/stripe/stripe_custom_response.dart';
import 'package:meta/meta.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  static String _secretKey =
      'sk_test_51IffgGLbSgEL15FoOGWcUOpl2JJdZV0MrqusP89GkHrnIac0PxaWpADBW51wggEB5jlB1FtPnK5HUXJkCTuzRoRm00vN6trVdV';
  String _apiKey =
      'pk_test_51IffgGLbSgEL15Fo4MvV6sOeV9TQP5Q3DFqhwsv50Tqjc1u4Bs2IQkINg4Bk1hrluebKaOuwrtycZ7sPT7FK2cY100G9Zx9Quj';

  /*static String _secretKey =
      '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';
  String _apiKey =
      'pk_live_51IffgGLbSgEL15FottRWg0QGtoeK7B4UnxnI71fsUOXrHsz9wLlSmbLmNp6qeCtvsPIxF2vZvWqJXRk10bWR11y800iNQLBhxs';*/
  // Create storage
  PaymentIntentResponse? pay;
  final _dio = new Dio();
  final _storage = new storage.FlutterSecureStorage();
  final headerOptions = new Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {'Authorization': 'Bearer ${StripeService._secretKey}'});
  //production
  void init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: _apiKey, androidPayMode: 'test', merchantId: 'test'));
  }

  Future<StripeCustomResponse> payWithExistingCard(
      {@required String? amount,
      @required String? currency,
      @required CreditCard? card}) async {
    try {
      final paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: card));

      print(
          'lalo  ${paymentMethod.card!.cvc} ${paymentMethod.type} ${paymentMethod.billingDetails} ${paymentMethod.created} ${paymentMethod.customerId} ${paymentMethod.id} ${paymentMethod.livemode}');

      final resp = await this._makePayment(
          amount: amount!, currency: currency!, paymentMethod: paymentMethod);

      return resp;

      // return StripeCustomResponse(ok: true);
    } catch (e) {
      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }

  Future<StripeCustomResponse> payWithNewCard({
    @required String? amount,
    @required String? currency,
  }) async {
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());

      print(
          'lalo  ${paymentMethod.card!.cvc} ${paymentMethod.type} ${paymentMethod.billingDetails} ${paymentMethod.created} ${paymentMethod.customerId} ${paymentMethod.id} ${paymentMethod.livemode}');

      final resp = await this._makePayment(
          amount: amount!, currency: currency!, paymentMethod: paymentMethod);

      return resp;

      // return StripeCustomResponse(ok: true);
    } catch (e) {
      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }

  Future payWithApplePayGooglePayCard({
    @required String? amount,
    @required String? currency,
  }) async {}

  Future<PaymentIntentResponse> _makePaymentIntent(
      {@required String? amount, @required String? currency}) async {
    try {
      final dio = new Dio();
      final data = {
        'amount': amount,
        'currency': currency,
      };

      final resp =
          await dio.post(_paymentApiUrl, data: data, options: headerOptions);

      print(resp.data);

      return PaymentIntentResponse.fromJson(resp.data);
    } catch (e) {
      print('Error en el intento ${e.toString()}');
      return PaymentIntentResponse(status: '400');
    }
  }

  Future<StripeCustomResponse> _makePayment(
      {@required String? amount,
      @required String? currency,
      @required PaymentMethod? paymentMethod}) async {
    try {
      final paymentIntent =
          await this._makePaymentIntent(amount: amount, currency: currency);

      final paymentResult = await StripePayment.confirmPaymentIntent(
          PaymentIntent(
              clientSecret: paymentIntent.clientSecret,
              paymentMethodId: paymentMethod!.id));

      pay = paymentIntent;

      if (paymentResult.status == 'succeeded') {
        return StripeCustomResponse(
            ok: true, msg: 'cobro realizado correctamente');
      } else {
        return StripeCustomResponse(
            ok: false, msg: 'fallo ${paymentResult.status}');
      }
    } catch (e) {
      print(e.toString());
      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }

  Future<ErrorResponse> makePaymentServer(
    // ignore: non_constant_identifier_names
    String? stripe_id,
    int? balance,
    String? currency,
    dynamic metadata,
    // ignore: non_constant_identifier_names
    String? amount_captured,
    // ignore: non_constant_identifier_names
    String? application_fee_amount,
    String? created,
    // ignore: non_constant_identifier_names
    String? failure_message,
    String? livemode,
    // ignore: non_constant_identifier_names
    String? payment_method,
  ) async {
    final token = await this._storage.read(key: 'token');

    _dio.options.headers["Authorization"] = "Bearer " + token!;
    final data = {
      'stripe_id': stripe_id,
      'balance': balance,
      'currency': currency,
      'metadata': metadata,
      'amount_captured': balance,
      'application_fee_amount': application_fee_amount,
      'created': created,
      'failure_message': failure_message,
      'livemode': livemode,
      'payment_method': payment_method,
    };

    final resp =
        await _dio.post('${Environment.apiUrl}/deposit/store', data: data);
    print('lalo $resp');

    ErrorResponse response = ErrorResponse.fromJson(resp.data);

    return response;
  }
}
