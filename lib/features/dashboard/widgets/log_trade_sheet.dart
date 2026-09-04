import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/account_repository.dart';

class LogTradeSheet extends ConsumerStatefulWidget {
  final String accountId;
  const LogTradeSheet({super.key, required this.accountId});

  @override
  ConsumerState<LogTradeSheet> createState() => _LogTradeSheetState();
}

class _LogTradeSheetState extends ConsumerState<LogTradeSheet> {
  final _formKey = GlobalKey<FormState>();
  final _symbolController = TextEditingController(text: 'EUR/USD');
  final _lotSizeController = TextEditingController(text: '1.0');
  final _pnlController = TextEditingController();
  String _tradeType = 'BUY';

  void _saveTrade() async {
    if (_formKey.currentState!.validate()) {
      final pnl = double.parse(_pnlController.text);
      await ref.read(accountsProvider.notifier).logTrade(
        accountId: widget.accountId,
        symbol: _symbolController.text,
        type: _tradeType,
        lotSize: double.parse(_lotSizeController.text),
        pnl: pnl,
      );
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF121824),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Log Completed Trade',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _symbolController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Asset (e.g. EUR/USD, XAU/USD)',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _tradeType == 'BUY' ? const Color(0xFF10B981) : Colors.grey[800],
                    ),
                    onPressed: () => setState(() => _tradeType = 'BUY'),
                    child: const Text('BUY'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _tradeType == 'SELL' ? const Color(0xFFEF4444) : Colors.grey[800],
                    ),
                    onPressed: () => setState(() => _tradeType = 'SELL'),
                    child: const Text('SELL'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _lotSizeController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Lot Size',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _pnlController,
              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Profit / Loss (\$) e.g. +150 or -50',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB)),
                onPressed: _saveTrade,
                child: const Text('Save Trade'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
