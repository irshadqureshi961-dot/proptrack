import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/account_repository.dart';

class PositionSizeCalculatorScreen extends ConsumerStatefulWidget {
  const PositionSizeCalculatorScreen({super.key});

  @override
  ConsumerState<PositionSizeCalculatorScreen> createState() => _PositionSizeCalculatorScreenState();
}

class _PositionSizeCalculatorScreenState extends ConsumerState<PositionSizeCalculatorScreen> {
  final _riskPercentController = TextEditingController(text: '1.0');
  final _entryPriceController = TextEditingController();
  final _stopLossController = TextEditingController();
  final _pipValueController = TextEditingController(text: '10.0'); // Standard lot per pip

  double? _calculatedLotSize;
  double? _riskAmount;
  double? _pipsAtRisk;

  void _calculatePositionSize(double currentBalance) {
    final riskPercent = double.tryParse(_riskPercentController.text) ?? 0.0;
    final entryPrice = double.tryParse(_entryPriceController.text) ?? 0.0;
    final stopLoss = double.tryParse(_stopLossController.text) ?? 0.0;
    final pipValue = double.tryParse(_pipValueController.text) ?? 10.0;

    if (entryPrice <= 0 || stopLoss <= 0 || riskPercent <= 0) {
      return;
    }

    final calculatedRiskAmount = currentBalance * (riskPercent / 100);
    final pips = (entryPrice - stopLoss).abs() * 10000; // Standard 4-digit pip multiplier

    if (pips > 0) {
      final lotSize = calculatedRiskAmount / (pips * (pipValue / 10));
      setState(() {
        _riskAmount = calculatedRiskAmount;
        _pipsAtRisk = pips;
        _calculatedLotSize = lotSize;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121824),
        title: const Text('Risk & Position Calculator', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: accountsAsync.when(
        data: (accounts) {
          if (accounts.isEmpty) {
            return const Center(
              child: Text('No accounts available.', style: TextStyle(color: Colors.grey)),
            );
          }

          final activeAccount = accounts.first;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAccountSummaryCard(activeAccount),
                const SizedBox(height: 16),
                _buildCalculatorForm(activeAccount.currentBalance),
                if (_calculatedLotSize != null) ...[
                  const SizedBox(height: 16),
                  _buildResultsCard(),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
      ),
    );
  }

  Widget _buildAccountSummaryCard(dynamic account) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121824),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1F293D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ACTIVE ACCOUNT BALANCE', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text('\$${account.currentBalance.toStringAsFixed(2)}', style: const TextStyle(color: Color(0xFF10B981), fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCalculatorForm(double currentBalance) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121824),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1F293D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('CALCULATE LOT SIZE', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: _riskPercentController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Risk Percentage (%)',
              labelStyle: TextStyle(color: Colors.grey),
              suffixText: '%',
              suffixStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _entryPriceController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Entry Price (e.g., 1.0850)',
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _stopLossController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Stop Loss Price (e.g., 1.0820)',
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () => _calculatePositionSize(currentBalance),
              child: const Text('Calculate Position Size', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121824),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2563EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('RECOMMENDED POSITION SIZE', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(
            '${_calculatedLotSize?.toStringAsFixed(2)} Lots',
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Divider(color: Color(0xFF1F293D), height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Amount at Risk:', style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text('\$${_riskAmount?.toStringAsFixed(2)}', style: const TextStyle(color: Color(0xFFEF4444), fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Stop Loss Distance:', style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text('${_pipsAtRisk?.toStringAsFixed(1)} pips', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
