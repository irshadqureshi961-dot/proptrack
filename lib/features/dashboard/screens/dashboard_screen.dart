import 'package:flutter/material.dart';
import '../../trades/widgets/log_trade_sheet.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedAccount = "FTMO \$100K Challenge";
  double accountBalance = 100000.00;
  double currentEquity = 104250.00;

  void _showAddAccountSheet() {
    final firmController = TextEditingController();
    final balanceController = TextEditingController();
    final dailyLossController = TextEditingController(text: "5.0");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF121824),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Prop Account', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: firmController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Prop Firm Name (e.g. FTMO, Apex)', labelStyle: TextStyle(color: Colors.grey)),
            ),
            TextField(
              controller: balanceController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Starting Balance (\$)', labelStyle: TextStyle(color: Colors.grey)),
            ),
            TextField(
              controller: dailyLossController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Max Daily Loss (%)', labelStyle: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676), minimumSize: const Size.fromHeight(48)),
              onPressed: () {
                if (firmController.text.isNotEmpty) {
                  setState(() {
                    selectedAccount = firmController.text;
                    accountBalance = double.tryParse(balanceController.text) ?? 100000.00;
                    currentEquity = accountBalance;
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Save Account', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double profitLoss = currentEquity - accountBalance;
    double profitPct = (profitLoss / accountBalance) * 100;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Account Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(selectedAccount, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text('Account #849201 • Active', style: TextStyle(color: Color(0xFF00E676), fontSize: 12)),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, color: Color(0xFF00E676), size: 28),
                    onPressed: _showAddAccountSheet,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Enhanced Equity & Balance Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFF121824), borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Account Balance', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            Text('\$${accountBalance.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Current Equity', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            Text('\$${currentEquity.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    const Divider(color: Color(0xFF1E2638), height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Profit / Loss: ${profitLoss >= 0 ? '+' : ''}\$${profitLoss.toStringAsFixed(2)} (${profitPct.toStringAsFixed(2)}%)',
                            style: TextStyle(color: profitLoss >= 0 ? const Color(0xFF00E676) : Colors.red, fontWeight: FontWeight.bold)),
                        const Text('Max DD: 1.8% / 10.0%', style: TextStyle(color: Colors.orange, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Risk Rules
              const Text('Risk & Objectives', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildProgressCard('Max Daily Loss', '\$350 / \$5,000 (0.7%)', 0.07),
              const SizedBox(height: 12),
              _buildProgressCard('Profit Target', '\$4,250 / \$10,000', 0.425),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF00E676),
        onPressed: () => showModalBottomSheet(context: context, builder: (_) => const LogTradeSheet()),
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text('Log Trade', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildProgressCard(String title, String subtitle, double percent) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF121824), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: percent, backgroundColor: const Color(0xFF1E2638), color: const Color(0xFF00E676)),
        ],
      ),
    );
  }
}
