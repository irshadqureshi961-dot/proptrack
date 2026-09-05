import 'package:flutter/material.dart';
import '../../../core/services/trade_service.dart';

class LogTradeSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onTradeAdded;

  const LogTradeSheet({super.key, required this.onTradeAdded});

  @override
  State<LogTradeSheet> createState() => _LogTradeSheetState();
}

class _LogTradeSheetState extends State<LogTradeSheet> {
  final _symbolController = TextEditingController();
  final _lotSizeController = TextEditingController();
  final _pnlController = TextEditingController();
  final _tradeService = TradeService();
  
  String _tradeType = 'BUY';
  bool _isProfit = true;
  bool _isSubmitting = false;

  Future<void> _submitTrade() async {
    final symbol = _symbolController.text.trim().toUpperCase();
    final lotSize = double.tryParse(_lotSizeController.text.trim()) ?? 0.0;
    final rawPnl = double.tryParse(_pnlController.text.trim()) ?? 0.0;

    if (symbol.isEmpty || lotSize <= 0) return;

    final numericPnl = _isProfit ? rawPnl.abs() : -rawPnl.abs();

    setState(() => _isSubmitting = true);

    // Persist to Supabase
    await _tradeService.logTrade(
      symbol: symbol,
      type: _tradeType,
      lotSize: lotSize,
      pnl: numericPnl,
    );

    final formattedPnl = '${numericPnl >= 0 ? '+$' : '-$'}${numericPnl.abs().toStringAsFixed(2)}';

    widget.onTradeAdded({
      'symbol': symbol,
      'type': _tradeType,
      'size': '$lotSize Lots',
      'pnl': formattedPnl,
      'isProfit': _isProfit,
      'numericPnl': numericPnl,
    });

    if (mounted) {
      setState(() => _isSubmitting = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF121824),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Log New Trade',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _symbolController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Symbol (e.g. EURUSD, XAUUSD)',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1E2638))),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E676))),
                ),
              ),
              const SizedBox(height: 12),
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
                  const SizedBox(width: 8),
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
              const SizedBox(height: 12),
              TextField(
                controller: _lotSizeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Lot Size',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1E2638))),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E676))),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _pnlController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'P&L Amount (\$)',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1E2638))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E676))),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: Text(_isProfit ? 'Profit' : 'Loss'),
                    selected: _isProfit,
                    selectedColor: const Color(0x3300E676),
                    checkmarkColor: const Color(0xFF00E676),
                    onSelected: (val) => setState(() => _isProfit = val),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitTrade,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E676),
                  padding: const EdgeInsets.vertical(14),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                      )
                    : const Text(
                        'Save Trade',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
