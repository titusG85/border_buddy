import 'package:border_buddy/currency/currency_fetcher.dart';

class CurrencyController {
  late final Future<double> conversionFuture;
  late final Future<double> usdToPesoRateFuture;
  late final Future<double> pesoToUsdRateFuture;

  CurrencyController() {
    conversionFuture = fetchConversionRate().then((conversion) {
      if (conversion == null) {
        throw Exception('Failed to fetch conversion rate');
      }
      return conversion;
    });
    usdToPesoRateFuture = conversionFuture;
    pesoToUsdRateFuture = conversionFuture.then((rate) => 1 / rate);
  }

  Future<double> convertCurrency(double amount, bool isUsdToPeso) async {
    final rate = isUsdToPeso ? await usdToPesoRateFuture : await pesoToUsdRateFuture;
    return amount * rate;
  }
}