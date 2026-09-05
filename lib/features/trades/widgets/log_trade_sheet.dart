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
  final _stopLossController = TextEditingController();
  final _takeProfitController = TextEditingController();
  final _pnlController = TextEditingController(text: '0.00');
  final _notesController = TextEditingController();

  String _tradeType = 'BUY';
  String _session = 'London';
  String _outcome = 'WIN';

  final List<String> _sessions = ['London', 'New York', 'Asian', 'Overlap'];

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
                  'Log Detailed Trade',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Pair & Session Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _symbolController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Pair / Symbol',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E676))),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _session,
                    dropdownColor: const Color(0xFF1E2638),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Trading Session',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    ),
                    items: _sessions.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (val) => setState(() => _session = val!),
                  ),
                ),
              ],
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

            // Lot Size & PnL Row
            Row(
              children: [
                Expanded(
                  child: TextField(
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
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _pnlController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Net Profit / Loss (\$)',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E676))),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Entry & Exit Price Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _entryPriceController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Entry Price',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E676))),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _exitPriceController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Exit Price',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E676))),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Stop Loss & Take Profit Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _stopLossController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Stop Loss (SL)',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E676))),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _takeProfitController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Take Profit (TP)',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E676))),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Trade Notes / Strategy Setup
            TextField(
              controller: _notesController,
              maxLines: 2,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Strategy / Trade Setup Notes',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E676))),
              ),
            ),
            const SizedBox(height: 24),

            // Submit Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E676),
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () {
                widget.onTradeAdded({
                  'symbol': _symbolController.text,
                  'type': _tradeType,
                  'session': _session,
                  'lot': double.tryParse(_lotSizeController.text) ?? 1.0,
                  'pnl': double.tryParse(_pnlController.text) ?? 0.0,
                  'entry': double.tryParse(_entryPriceController.text),
                  'exit': double.tryParse(_exitPriceController.text),
                  'sl': double.tryParse(_stopLossController.text),
                  'tp': double.tryParse(_takeProfitController.text),
                  'notes': _notesController.text,
                  'date': DateTime.now().toString().split(' ')[0],
                });
                Navigator.pop(context);
              },
              child: const Text('Save Detailed Trade', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
