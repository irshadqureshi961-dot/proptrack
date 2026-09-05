import 'package:flutter/material.dart';

class LogTradeSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onTradeAdded;

  const LogTradeSheet({super.key, required onTradeAdded}) : _onTradeAdded = onTradeAdded;

  final Function(Map<String, dynamic>) _onTradeAdded;

  @override
  State<LogTradeSheet> createState() => _LogTradeSheetState();
}

class _LogTradeSheetState extends State<LogTradeSheet> {
  final _symbolController = TextEditingController(text: 'EURUSD');
  final _lotsController = TextEditingController(text: '1.0');
  final _pnlController = TextEditingController(text: '250.00');
  String _tradeType = 'BUY';
  bool _isProfit = true;

  @override
  void dispose() {
    _symbolController.dispose();
    _lotsController.dispose();
    _pnlController.dispose();
    super.dispose();
  }

  void _submit() {
    final symbol = _symbolController.text.trim().toUpperCase();
    final lots = _lotsController.text.trim();
    final rawPnl = double.tryParse(_pnlController.text.trim()) ?? 0.0;
    final finalPnl = _isProfit ? rawPnl : -rawPnl;

    if (symbol.isEmpty || lots.isEmpty) return;

    widget._onTradeAdded({
      'symbol': symbol,
      'type': _tradeType,
      'size': '$lots Lots',
      'pnl': '${finalPnl >= 0 ? '+\$' : '-\$'}${finalPnl.abs().toStringAsFixed(2)}',
      'isProfit': _isProfit,
      'numericPnl': finalPnl,
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF121824),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Log Executed Trade',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text('BUY')),
                  selected: _tradeType == 'BUY',
                  selectedColor: const Color(0xFF00E676),
                  onSelected: (val) => setState(() => _tradeType = 'BUY'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text('SELL')),
                  selected: _tradeType == 'SELL',
                  selectedColor: const Color(0xFFFF5252),
                  onSelected: (val) => setState(() => _tradeType = 'SELL'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _symbolController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Pair / Instrument',
              labelStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Color(0xFF0B0E14),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _lotsController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Lot Size',
              labelStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Color(0xFF0B0E14),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _pnlController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'PnL (\USD)',
                    labelStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Color(0xFF0B0E14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Switch(
                value: _isProfit,
                activeColor: const Color(0xFF00E676),
                inactiveThumbColor: const Color(0xFFFF5252),
                onChanged: (val) => setState(() => _isProfit = val),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00E676),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Save Trade', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
