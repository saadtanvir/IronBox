import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class StripePaymentServices {
  String _publishableKey =
      "pk_test_51ImhJVJte8ZzwOOniikhq39OWIg1LvKU4pRBM8bd3U4TCSFx5RNjKA47xI0MafKx6npCt4ceKXGpJhKytYFmvf4l00AUpqlNjU";
  String _secretKey =
      "sk_test_51ImhJVJte8ZzwOOnY2iTwmsGrQPrkWlu065r4jqWsyXZaazbh4fHgxO8WdIpspBGOxzMBj5Pq5djOV2jFFf50bcW006VUjyog4";
  String _paymentIntentUrl =
      "${GlobalConfiguration().get("stripe_base_url")}/v1/payment_intents";

  PaymentMethod _paymentMethod = PaymentMethod();

  void initializeStripePayments() {
    StripePayment.setOptions(StripeOptions(publishableKey: _publishableKey));
  }

  Future<bool> payWithNewCard(String amount, String currency) async {
    try {
      _paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      print("payment method id: ${_paymentMethod.id}");
      var paymentIntent = await _createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent["client_secret"],
          paymentMethodId: _paymentMethod.id));
      print("payment confirmed");
      print(response);

      if (response.status.toLowerCase() == "succeeded") {
        return true;
      } else {
        print("Payment Confirmation Failed !");
        return false;
      }
    } catch (e) {
      print("Stripe Payment Services Error: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>> _createPaymentIntent(
      String amount, String currency) async {
    Map<String, dynamic> body = {
      "amount": amount,
      "currency": currency,
      "payment_method_types[]": 'card',
    };
    Map<String, String> headers = {
      "Authorization": "Bearer ${_secretKey}",
      "Content-Type": "application/x-www-form-urlencoded"
    };

    try {
      var response =
          await http.post(_paymentIntentUrl, body: body, headers: headers);

      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        print("Payment Intent Failed !");
        return {};
      }
    } catch (e) {
      print("Create Payment Intent Error: $e");
      return {};
    }
  }
}
