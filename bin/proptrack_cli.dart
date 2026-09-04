import 'dart:convert';
import 'dart:io';

class Trade {
  final String symbol;
  final String type;
  final double lots;
  final double pnl;
  final DateTime date;

  Trade(this.symbol, this.type, this.lots, this.pnl, {DateTime? date})
      : date = date ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'symbol': symbol,
        'type': type,
        'lots': lots,
        'pnl': pnl,
        'date': date.toIso8601String(),
      };

  factory Trade.fromJson(Map<String, dynamic> json) => Trade(
        json['symbol'] as String,
        json['type'] as String,
        (json['lots'] as num).toDouble(),
        (json['pnl'] as num).toDouble(),
        date: json['date'] != null ? DateTime.parse(json['date'] as String) : DateTime.now(),
      );
}

void main() {
  final file = File('proptrack_data.json');
  double startingBalance = 50000.0;
  double currentBalance = 50000.0;
  double profitTarget = 5000.0;
  double dailyLossLimit = 2500.0;
  List<Trade> trades = [];

  // Load saved data
  if (file.existsSync()) {
    try {
      final content = file.readAsStringSync();
      final data = jsonDecode(content) as Map<String, dynamic>;
      currentBalance = (data['currentBalance'] as num).toDouble();
      final loadedTrades = data['trades'] as List<dynamic>;
      trades = loadedTrades.map((e) => Trade.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {}
  }

  void saveData() {
    final data = {
      'currentBalance': currentBalance,
      'trades': trades.map((t) => t.toJson()).toList(),
    };
    file.writeAsStringSync(jsonEncode(data));
  }

  void exportToCSV() {
    final csvFile = File('proptrack_trades.csv');
    StringBuffer csv = StringBuffer();
    csv.writeln('Date,Symbol,Type,Lots,PnL');
    for (var t in trades) {
      csv.writeln('${t.date.toIso8601String()},${t.symbol},${t.type},${t.lots},${t.pnl}');
    }
    csvFile.writeAsStringSync(csv.toString());
  }

  while (true) {
    stdout.write('\x1B[2J\x1B[0;0H'); // Clear console
    double totalPnL = currentBalance - startingBalance;
    double progressPct = (totalPnL / profitTarget) * 100;

    // Advanced Metrics Calculation
    int totalTrades = trades.length;
    int winningTrades = trades.where((t) => t.pnl > 0).length;
    int losingTrades = trades.where((t) => t.pnl < 0).length;
    double winRate = totalTrades > 0 ? (winningTrades / totalTrades) * 100 : 0.0;

    double grossProfit = trades.where((t) => t.pnl > 0).fold(0.0, (sum, t) => sum + t.pnl);
    double grossLoss = trades.where((t) => t.pnl < 0).fold(0.0, (sum, t) => sum + t.pnl.abs());
    double profitFactor = grossLoss > 0 ? grossProfit / grossLoss : (grossProfit > 0 ? 999.0 : 0.0);

    // Rule Warning Engine
    bool dailyLossBreached = totalPnL <= -dailyLossLimit;

    print('====================================================');
    print('             PROPTRACK CLI DASHBOARD                ');
    print('====================================================');
    print(' Account Balance : \$${currentBalance.toStringAsFixed(2)}');
    print(' Total PnL       : ${totalPnL >= 0 ? '+' : ''}\$${totalPnL.toStringAsFixed(2)}');
    print(' Target Progress : ${progressPct.toStringAsFixed(1)}% (\$${profitTarget.toStringAsFixed(0)} Target)');
    
    if (dailyLossBreached) {
      print(' ALERT STATUS   : [!] DAILY LOSS LIMIT BREACHED! [!]');
    } else {
      print(' Daily Loss Limit: \$${dailyLossLimit.toStringAsFixed(2)}');
    }

    print('----------------------------------------------------');
    print(' ANALYTICS & STATS:');
    print(' Win Rate        : ${winRate.toStringAsFixed(1)}% ($winningTrades W / $losingTrades L)');
    print(' Profit Factor   : ${profitFactor > 900 ? 'N/A' : profitFactor.toStringAsFixed(2)}');
    print(' Gross Profit    : +\$${grossProfit.toStringAsFixed(2)}');
    print(' Gross Loss      : -\$${grossLoss.toStringAsFixed(2)}');
    print('----------------------------------------------------');
    print(' RECENT TRADES:');
    if (trades.isEmpty) {
      print('   No trades logged yet.');
    } else {
      for (var t in trades.reversed.take(4)) {
        String sign = t.pnl >= 0 ? '+' : '';
        print('   • ${t.symbol.padRight(7)} | ${t.type.padRight(4)} | ${t.lots} Lots | PnL: $sign\$${t.pnl.toStringAsFixed(2)}');
      }
    }
    print('----------------------------------------------------');
    print(' [1] Log Trade   [2] Lot Calculator   [3] Export CSV   [4] Exit');
    stdout.write('\nSelect option: ');

    String? choice = stdin.readLineSync();

    if (choice == '1') {
      stdout.write('\nSymbol (e.g. XAUUSD): ');
      String symbol = stdin.readLineSync()?.toUpperCase() ?? 'XAUUSD';
      stdout.write('Type (BUY/SELL): ');
      String type = stdin.readLineSync()?.toUpperCase() ?? 'BUY';
      stdout.write('Lot Size (e.g. 1.5): ');
      double lots = double.tryParse(stdin.readLineSync() ?? '1.0') ?? 1.0;
      stdout.write('PnL Amount (e.g. 350 or -200): ');
      double pnl = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;

      trades.add(Trade(symbol, type, lots, pnl));
      currentBalance += pnl;
      saveData();
    } else if (choice == '2') {
      stdout.write('\nRisk Percentage % (e.g. 1.0): ');
      double riskPct = double.tryParse(stdin.readLineSync() ?? '1.0') ?? 1.0;
      stdout.write('Stop Loss Pips (e.g. 25): ');
      double pips = double.tryParse(stdin.readLineSync() ?? '25') ?? 25;

      double riskCash = currentBalance * (riskPct / 100);
      double lotResult = riskCash / (pips * 10);

      print('\n--> CALCULATED LOT SIZE: ${lotResult.toStringAsFixed(2)} Lots');
      print('--> Max Risk Cash     : \$${riskCash.toStringAsFixed(2)}');
      stdout.write('\nPress Enter to return to dashboard...');
      stdin.readLineSync();
    } else if (choice == '3') {
      exportToCSV();
      print('\n--> SUCCESS: Exported trades to proptrack_trades.csv');
      stdout.write('\nPress Enter to return to dashboard...');
      stdin.readLineSync();
    } else if (choice == '4') {
      print('\nExiting PropTrack CLI. Data saved successfully!\n');
      break;
    }
  }
}
