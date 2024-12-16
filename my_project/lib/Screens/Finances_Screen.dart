import 'package:flutter/material.dart';
import 'package:my_project/JSON/CurrencyHelper.dart';

class FinancesPage extends StatefulWidget {
  const FinancesPage({super.key});

  @override
  State<FinancesPage> createState() => _FinancesPageState();
}

class _FinancesPageState extends State<FinancesPage> {
  final CurrencyService _currencyService = CurrencyService();

  List<dynamic> _exchangeRates = [];
  String? _selectedCurrency;
  double _amount = 1.0;
  double _convertedAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchRates();
  }

  Future<void> _fetchRates() async {
    try {
      final rates = await _currencyService.fetchExchangeRates();
      setState(() {
        _exchangeRates = rates;
        _selectedCurrency = _exchangeRates.first['cc'] as String?;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Помилка завантаження даних: $e')),
      );
    }
  }

  void _convertCurrency() {
    final selectedRate = _exchangeRates
        .firstWhere((rate) => rate['cc'] == _selectedCurrency)['rate'];
    setState(() {
      _convertedAmount = _amount * (selectedRate as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Конвертор валют'),
      ),
      body: _exchangeRates.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Сума у валюті',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _amount = double.tryParse(value) ?? 1.0;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: _selectedCurrency,
                    items: _exchangeRates
                        .map<DropdownMenuItem<String>>(
                            (rate) => DropdownMenuItem<String>(
                                  value: rate['cc'] as String?,
                                  child: Text(
                                    '${rate['cc']} - ${rate['txt']}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCurrency = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _convertCurrency,
                    child: const Text('Конвертувати'),
                  ),
                  const SizedBox(height: 20),
                  if (_convertedAmount > 0)
                    Text(
                      'Результат: $_convertedAmount UAH',
                      style: const TextStyle(fontSize: 18),
                    ),
                ],
              ),
            ),
    );
  }
}
