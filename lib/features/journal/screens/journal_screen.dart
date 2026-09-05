import 'package:flutter/material.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final List<Map<String, String>> withdrawals = [
    {'date': '2026-08-15', 'amount': '\$2,500.00', 'note': 'First FTMO Payout (80% Split)'},
  ];

  void _showWithdrawalModal() {
    final amountController = TextEditingController();
    final noteController = TextEditingController();

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
            const Text('Record Virtual Payout / Withdrawal', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Payout Amount (\$)', labelStyle: TextStyle(color: Colors.grey)),
            ),
            TextField(
              controller: noteController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Notes / Profit Split Details', labelStyle: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676), minimumSize: const Size.fromHeight(48)),
              onPressed: () {
                if (amountController.text.isNotEmpty) {
                  setState(() {
                    withdrawals.insert(0, {
                      'date': DateTime.now().toString().split(' ')[0],
                      'amount': '\$${amountController.text}',
                      'note': noteController.text.isEmpty ? 'Prop Firm Withdrawal' : noteController.text,
                    });
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Log Withdrawal Record', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E14),
        title: const Text('Trade Journal & Payouts', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet, color: Color(0xFF00E676)),
            onPressed: _showWithdrawalModal,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF121824), borderRadius: BorderRadius.circular(12)),
                    child: const Column(
                      children: [
                        Text('Total Trades', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        SizedBox(height: 4),
                        Text('3', style: TextStyle(color: Colors.blueAccent, fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF121824), borderRadius: BorderRadius.circular(12)),
                    child: const Column(
                      children: [
                        Text('Win Rate', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        SizedBox(height: 4),
                        Text('66.7%', style: TextStyle(color: Color(0xFF00E676), fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Payout / Withdrawal Log', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: _showWithdrawalModal,
                  child: const Text('+ Record Payout', style: TextStyle(color: Color(0xFF00E676))),
                )
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: withdrawals.length,
              itemBuilder: (context, index) {
                final item = withdrawals[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFF121824), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['note']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text(item['date']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                      Text(item['amount']!, style: const TextStyle(color: Color(0xFF00E676), fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
