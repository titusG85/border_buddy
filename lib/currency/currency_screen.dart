import 'package:flutter/material.dart';
import '../utils/app_localizations.dart'; // Import localization helper
import 'currency_controller.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final CurrencyController _controller = CurrencyController(); // Use the controller
  String _usdInput = '';
  double? _convertedAmount;
  bool _isUsdToPeso = true; // Tracks the conversion direction

  void _convertCurrency() async {
    if (_usdInput.isNotEmpty) {
      final inputAmount = double.tryParse(_usdInput);
      if (inputAmount != null) {
        final convertedAmount = await _controller.convertCurrency(inputAmount, _isUsdToPeso);
        setState(() {
          _convertedAmount = convertedAmount; // Assign the awaited result
        });
      }
    }
  }

  void _onKeyPressed(String value) {
    setState(() {
      if (value == 'C') {
        _usdInput = '';
      } else if (value == '⌫') {
        if (_usdInput.isNotEmpty) {
          _usdInput = _usdInput.substring(0, _usdInput.length - 1);
        }
      } else if (value == '.' && !_usdInput.contains('.')) {
        _usdInput += value; // Add decimal point only if it doesn't already exist
      } else if (RegExp(r'^\d$').hasMatch(value)) {
        _usdInput += value; // Add numeric values
      }
    });
  }

  void _toggleConversionDirection() {
    setState(() {
      _isUsdToPeso = !_isUsdToPeso;
      _usdInput = ''; // Clear input when toggling
      _convertedAmount = null; // Clear the converted amount
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Get localized strings

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.translate('currency_converter'), // Localized "Currency Converter"
          style: const TextStyle(fontFamily: 'Gravitas'),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                _usdInput.isEmpty
                    ? localizations.translate('enter_amount').replaceFirst(
                        '{currency}', _isUsdToPeso ? 'USD' : 'Pesos') // Localized "Enter amount in"
                    : '\$$_usdInput',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: Text(
                localizations.translate('convert_to').replaceFirst(
                    '{currency}', _isUsdToPeso ? 'Pesos' : 'USD'), // Localized "Convert to"
              ),
            ),
            const SizedBox(height: 16),
            if (_convertedAmount != null)
              Text(
                '${localizations.translate('amount_in').replaceFirst(
                    '{currency}', _isUsdToPeso ? 'Pesos' : 'USD')}: ${_convertedAmount!.toStringAsFixed(2)}', // Localized "Amount in"
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _toggleConversionDirection,
              child: Text(
                localizations.translate('swap_to').replaceFirst(
                    '{conversion_direction}',
                    _isUsdToPeso ? 'Pesos to USD' : 'USD to Pesos'), // Localized "Swap to"
              ),
            ),
            const Spacer(),
            _buildKeypad(),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['1', '2', '3'].map((value) => _buildKey(value)).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['4', '5', '6'].map((value) => _buildKey(value)).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['7', '8', '9'].map((value) => _buildKey(value)).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildKey('C'), // Clear button
            _buildKey('0'),
            _buildKey('.'), // Decimal point button
            _buildKey('⌫'), // Backspace button
          ],
        ),
        const SizedBox(height: 120),
      ],
    );
  }

  Widget _buildKey(String value) {
    return ElevatedButton(
      onPressed: () => _onKeyPressed(value),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        value,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}