import 'dart:convert'; // For JSON decoding
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<double?> fetchConversionRate() async {
  final url = 'https://hexarate.paikama.co/api/rates/latest/USD?target=MXN';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    try {
      // Parse the JSON response
      final jsonResponse = json.decode(response.body);
      final conversionRate = jsonResponse['data']['mid'];
      if (conversionRate != null) {
        return conversionRate.toDouble(); // Ensure it's a double
      } else {
        debugPrint('Conversion rate not found in response.');
      }
    } catch (e) {
      debugPrint('Error parsing JSON: $e');
    }
  } else {
    debugPrint('Failed to fetch the page. Status code: ${response.statusCode}');
  }

  return null;
}

void main() async {
  final rate = await fetchConversionRate();
  if (rate != null) {
    debugPrint('Conversion Rate: $rate MXN per USD');
  } else {
    debugPrint('Failed to fetch the conversion rate.');
  }
}