import 'package:flutter/material.dart';

class LogTradeSheet extends StatefulWidget {
  final String? accountId;

  const LogTradeSheet({super.key, this.accountId});

  @override
  State<LogTradeSheet> createState() => _LogTradeSheetState();
}

class _LogTradeSheetState extends State<LogTradeSheet> {
  String _tradeType = 'BUY';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _tradeType == 'BUY' ? Colors.green : Colors.grey,
                ),
                onPressed: () => setState(() => _tradeType = 'BUY'),
                child: const Text('BUY'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _tradeType == 'SELL' ? Colors.red : Colors.grey,
                ),
                onPressed: () => setState(() => _tradeType = 'SELL'),
                child: const Text('SELL'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
