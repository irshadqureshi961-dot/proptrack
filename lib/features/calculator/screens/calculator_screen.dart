import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _balanceController = TextEditingController(text: "100000");
  final _riskController = TextEditingController(text: "1.0");
  final _stopLossController = TextEditingController(text: "20");

  double recommendedLotSize = 0.50;
  double cashAtRisk = 1000.00;

  void _calculatePositionSize() {
    double balance = double.tryParse(_balanceController.text) ?? 0.0;
    double riskPct = double.tryParse(_riskController.text) ?? 0.0;
    double stopLossPips = double.tryParse(_stopLossController.text) ?? 0.0;

    if (balance > 0 && riskPct > 0 && stopLossPips > 0) {
      double riskAmount = balance * (riskPct / 100);
      // Standard Forex Pip Value calculation ($10/pip per standard lot for USD pairs)
      double lotSize = riskAmount / (stopLossPips * 10);

      setState(() {
        cashAtRisk = riskAmount;
        recommendedLotSize = lotSize;
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
          children: [
            // Calculation Output Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF121824),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text('Recommended Lot Size', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text(
                    '${recommendedLotSize.toStringAsFixed(2)} Lots',
                    style: const TextStyle(color: Color(0xFF00E676), fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Cash at Risk: \$${cashAtRisk.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Form Inputs
            _buildInputField('Account Balance (\$)', _balanceController),
            const SizedBox(height: 16),
            _buildInputField('Risk Percentage (%)', _riskController),
            const SizedBox(height: 16),
            _buildInputField('Stop Loss (Pips)', _stopLossController),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF121824),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        onChanged: (_) => _calculatePositionSize(),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ),
    );
  }
}
