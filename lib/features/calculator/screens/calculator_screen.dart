import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _accountBalanceController = TextEditingController(text: '100000');
  final _riskPercentageController = TextEditingController(text: '1.0');
  final _stopLossPipsController = TextEditingController(text: '20');
  
  String _selectedPair = 'EURUSD';
  double _calculatedLotSize = 0.50;
  double _calculatedRiskAmount = 1000.0;

  final List<String> _pairs = ['EURUSD', 'GBPUSD', 'USDJPY', 'XAUUSD', 'AUDUSD'];

  void _calculatePosition() {
    double balance = double.tryParse(_accountBalanceController.text) ?? 100000;
    double riskPercent = double.tryParse(_riskPercentageController.text) ?? 1.0;
    double stopLoss = double.tryParse(_stopLossPipsController.text) ?? 20;

    if (stopLoss > 0) {
      double riskAmount = balance * (riskPercent / 100);
      // Basic standard lot formula calculation (1 lot = $10/pip for standard FX pairs)
      double lotSize = riskAmount / (stopLoss * 10);

      setState(() {
        _calculatedRiskAmount = riskAmount;
        _calculatedLotSize = double.parse(lotSize.toStringAsFixed(2));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E14),
        title: const Text('Position Size Calculator', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Result Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF121824),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF1E2638)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Recommended Lot Size', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text('$_calculatedLotSize Lots', style: const TextStyle(color: Color(0xFF00E676), fontSize: 26, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Total Risk Amount', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text('\$${_calculatedRiskAmount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Form Inputs
            const Text('Account Balance (\$)'),
            const SizedBox(height: 8),
            TextField(
              controller: _accountBalanceController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('100000'),
              onChanged: (_) => _calculatePosition(),
            ),
            const SizedBox(height: 16),

            const Text('Risk (%)'),
            const SizedBox(height: 8),
            TextField(
              controller: _riskPercentageController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('1.0'),
              onChanged: (_) => _calculatePosition(),
            ),
            const SizedBox(height: 16),

            const Text('Stop Loss (Pips)'),
            const SizedBox(height: 8),
            TextField(
              controller: _stopLossPipsController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('20'),
              onChanged: (_) => _calculatePosition(),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: const Color(0xFF121824),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    );
  }
}
