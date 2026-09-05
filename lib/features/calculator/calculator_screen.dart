import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _balanceController = TextEditingController(text: '100000');
  final _riskPercentController = TextEditingController(text: '1.0');
  final _stopLossPipsController = TextEditingController(text: '20');

  double _calculatedLots = 0.50;
  double _riskAmount = 1000.00;

  void _calculate() {
    final balance = double.tryParse(_balanceController.text) ?? 0;
    final riskPercent = double.tryParse(_riskPercentController.text) ?? 0;
    final slPips = double.tryParse(_stopLossPipsController.text) ?? 0;

    if (balance <= 0 || riskPercent <= 0 || slPips <= 0) return;

    final cashAtRisk = balance * (riskPercent / 100);
    // Standard forex pip value calculation base ($10 per pip per standard lot)
    final lotSize = cashAtRisk / (slPips * 10);

    setState(() {
      _riskAmount = cashAtRisk;
      _calculatedLots = lotSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Position Size Calculator',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF121824),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF1E2638)),
            ),
            child: Column(
              children: [
                const Text('Recommended Lot Size', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Text(
                  '${_calculatedLots.toStringAsFixed(2)} Lots',
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF00E676)),
                ),
                const SizedBox(height: 8),
                Text(
                  'Cash at Risk: \$${_riskAmount.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _balanceController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            onChanged: (_) => _calculate(),
            decoration: const InputDecoration(
              labelText: 'Account Balance (\USD)',
              labelStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Color(0xFF121824),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _riskPercentController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            onChanged: (_) => _calculate(),
            decoration: const InputDecoration(
              labelText: 'Risk Percentage (%)',
              labelStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Color(0xFF121824),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _stopLossPipsController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            onChanged: (_) => _calculate(),
            decoration: const InputDecoration(
              labelText: 'Stop Loss (Pips)',
              labelStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Color(0xFF121824),
            ),
          ),
        ],
      ),
    );
  }
}
