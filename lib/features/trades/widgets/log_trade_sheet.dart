import 'package:flutter/material.dart';

class LogTradeSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onTradeAdded;

  const LogTradeSheet({super.key, required this.onTradeAdded});

  @override
  State<LogTradeSheet> createState() => _LogTradeSheetState();
}

class _LogTradeSheetState extends State<LogTradeSheet> {
  final _symbolController = TextEditingController(text: 'EURUSD');
  final _lotSizeController = TextEditingController(text: '1.0');
  final _entryPriceController = TextEditingController();
  final _exitPriceController = TextEditingController();
  final _pnlController = TextEditingController(text: '0.00');

  String _tradeType = 'BUY';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF121824),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Log New Trade',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Symbol Input
            TextField(
              controller: _symbolController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Pair / Symbol (e.g. EURUSD, XAUUSD)',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E676))),
              ),
            ),
            const SizedBox(height: 12),

            // Trade Type Selector (BUY / SELL)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _tradeType == 'BUY' ? const Color(0xFF00E676) : const Color(0xFF1E2638),
                    ),
                    onPressed: () => setState(() => _tradeType = 'BUY'),
                    child: Text('BUY', style: TextStyle(color: _tradeType == 'BUY' ? Colors.black : Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _tradeType == 'SELL' ? Colors.redAccent : const Color(0xFF1E2638),
                    ),
                    onPressed: () => setState(() => _tradeType = 'SELL'),
                    child: Text('SELL', style: TextStyle(color: _tradeType == 'SELL' ? Colors.black : Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Lot Size Input
            TextField(
              controller: _lotSizeController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Lot Size',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E676))),
              ),
            ),
            const SizedBox(height: 12),

            // PnL Input
            TextField(
              controller: _pnlController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Profit / Loss (\$)',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E676))),
              ),
            ),
            const SizedBox(height: 24),

            // Save Trade Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E676),
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () {
                final double pnl = double.tryParse(_pnlController.text) ?? 0.0;
                widget.onTradeAdded({
                  'symbol': _symbolController.text,
                  'type': _tradeType,
                  'lot': double.tryParse(_lotSizeController.text) ?? 1.0,
                  'pnl': pnl,
                  'date': DateTime.now().toString().split(' ')[0],
                });
                Navigator.pop(context);
              },
              child: const Text('Save Trade', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
