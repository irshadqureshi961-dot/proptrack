import 'package:flutter/material.dart';
import '../../trades/widgets/log_trade_sheet.dart';

class AccountModel {
  String name;
  String accountType; // 1 Step, 2 Step, Funded, Instant
  double startingBalance;
  double currentEquity;
  double maxDailyLossPct;
  double profitTarget;
  String drawdownType; // Equity based, Static
  String startDate;
  bool isDisabled;

  AccountModel({
    required this.name,
    required this.accountType,
    required this.startingBalance,
    required this.currentEquity,
    required this.maxDailyLossPct,
    required this.profitTarget,
    required this.drawdownType,
    required this.startDate,
    this.isDisabled = false,
  });
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<AccountModel> accounts = [
    AccountModel(
      name: "FTMO \$100K Challenge",
      accountType: "2 Step",
      startingBalance: 100000.0,
      currentEquity: 104250.0,
      maxDailyLossPct: 5.0,
      profitTarget: 10000.0,
      drawdownType: "Equity based",
      startDate: "2026-08-01",
    ),
  ];

  int selectedAccountIndex = 0;

  void _checkAccountStatus(AccountModel account) {
    double maxDailyLossAmount = account.startingBalance * (account.maxDailyLossPct / 100);
    double currentLoss = account.startingBalance - account.currentEquity;
    
    if (currentLoss >= maxDailyLossAmount) {
      account.isDisabled = true;
    }
  }

  void _showAddAccountSheet() {
    final firmController = TextEditingController();
    final balanceController = TextEditingController(text: "100000");
    final dailyLossController = TextEditingController(text: "5.0");
    final profitTargetController = TextEditingController(text: "10000");
    final startDateController = TextEditingController(text: DateTime.now().toString().split(' ')[0]);

    String selectedType = "2 Step";
    String selectedDrawdown = "Equity based";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF121824),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20, left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
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
                const SizedBox(height: 12),

                // Account Type Dropdown
                DropdownButtonFormField<String>(
                  value: selectedType,
                  dropdownColor: const Color(0xFF1E2638),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Account Type', labelStyle: TextStyle(color: Colors.grey)),
                  items: ['1 Step', '2 Step', 'Funded', 'Instant'].map((String type) {
                    return DropdownMenuItem<String>(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (val) => setModalState(() => selectedType = val!),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: balanceController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Starting Balance (\$)', labelStyle: TextStyle(color: Colors.grey)),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: dailyLossController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Max Daily Loss (%)', labelStyle: TextStyle(color: Colors.grey)),
                ),
                const SizedBox(height: 12),

                // Drawdown Type Dropdown
                DropdownButtonFormField<String>(
                  value: selectedDrawdown,
                  dropdownColor: const Color(0xFF1E2638),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Drawdown Type', labelStyle: TextStyle(color: Colors.grey)),
                  items: ['Equity based', 'Static'].map((String type) {
                    return DropdownMenuItem<String>(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (val) => setModalState(() => selectedDrawdown = val!),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: startDateController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Account Starting Date (YYYY-MM-DD)', labelStyle: TextStyle(color: Colors.grey)),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: profitTargetController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Profit Target (\$)', labelStyle: TextStyle(color: Colors.grey)),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676), minimumSize: const Size.fromHeight(48)),
                  onPressed: () {
                    if (firmController.text.isNotEmpty) {
                      double bal = double.tryParse(balanceController.text) ?? 100000.0;
                      double target = double.tryParse(profitTargetController.text) ?? 10000.0;
                      double dailyLoss = double.tryParse(dailyLossController.text) ?? 5.0;

                      AccountModel newAcc = AccountModel(
                        name: firmController.text,
                        accountType: selectedType,
                        startingBalance: bal,
                        currentEquity: bal,
                        maxDailyLossPct: dailyLoss,
                        profitTarget: target,
                        drawdownType: selectedDrawdown,
                        startDate: startDateController.text,
                      );

                      _checkAccountStatus(newAcc);

                      setState(() {
                        accounts.add(newAcc);
                        selectedAccountIndex = accounts.length - 1;
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Save Account', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteCurrentAccount() {
    if (accounts.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot delete the only active account.")),
      );
      return;
    }

    setState(() {
      accounts.removeAt(selectedAccountIndex);
      selectedAccountIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    AccountModel currentAcc = accounts[selectedAccountIndex];
    _checkAccountStatus(currentAcc);

    double profitLoss = currentAcc.currentEquity - currentAcc.startingBalance;
    double profitPct = (profitLoss / currentAcc.startingBalance) * 100;
    double dailyLossLimitAmount = currentAcc.startingBalance * (currentAcc.maxDailyLossPct / 100);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Account Selection Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<int>(
                    value: selectedAccountIndex,
                    dropdownColor: const Color(0xFF121824),
                    underline: const SizedBox(),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                    items: List.generate(accounts.length, (index) {
                      return DropdownMenuItem(
                        value: index,
                        child: Text(
                          accounts[index].name,
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
                    onChanged: (index) {
                      if (index != null) {
                        setState(() => selectedAccountIndex = index);
                      }
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 24),
                        onPressed: _deleteCurrentAccount,
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: Color(0xFF00E676), size: 28),
                        onPressed: _showAddAccountSheet,
                      ),
                    ],
                  ),
                ],
              ),
              
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: currentAcc.isDisabled ? Colors.red.withOpacity(0.2) : const Color(0xFF00E676).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  currentAcc.isDisabled
                      ? 'ACCOUNT DISABLED (Loss Limit Breached)'
                      : '${currentAcc.accountType} • ${currentAcc.drawdownType} • Active',
                  style: TextStyle(
                    color: currentAcc.isDisabled ? Colors.red : const Color(0xFF00E676),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Metrics Card
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
                            const Text('Starting Balance', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            Text('\$${currentAcc.startingBalance.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Current Equity', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            Text('\$${currentAcc.currentEquity.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    const Divider(color: Color(0xFF1E2638), height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('P/L: ${profitLoss >= 0 ? '+' : ''}\$${profitLoss.toStringAsFixed(2)} (${profitPct.toStringAsFixed(2)}%)',
                            style: TextStyle(color: profitLoss >= 0 ? const Color(0xFF00E676) : Colors.red, fontWeight: FontWeight.bold)),
                        Text('Start: ${currentAcc.startDate}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Rules & Progress
              const Text('Risk & Objectives', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildProgressCard('Max Daily Loss (${currentAcc.maxDailyLossPct}%)', '\$0 / \$${dailyLossLimitAmount.toStringAsFixed(0)}', 0.0),
              const SizedBox(height: 12),
              _buildProgressCard('Profit Target', '\$${profitLoss > 0 ? profitLoss.toStringAsFixed(0) : "0"} / \$${currentAcc.profitTarget.toStringAsFixed(0)}', (profitLoss / currentAcc.profitTarget).clamp(0.0, 1.0)),
            ],
          ),
        ),
      ),
      floatingActionButton: currentAcc.isDisabled
          ? null
          : FloatingActionButton.extended(
              backgroundColor: const Color(0xFF00E676),
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (_) => LogTradeSheet(
                  onTradeAdded: (tradeData) {},
                ),
              ),
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
