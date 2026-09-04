import 'package:flutter/material.dart';

void main() {
  runApp(const PropTrackApp());
}

class PropTrackApp extends StatelessWidget {
  const PropTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PropTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        primaryColor: Colors.blueAccent,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double accountBalance = 50000.00;
  double profitTarget = 5000.00;
  double dailyLossLimit = 2500.00;
  double totalPnL = 0.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PropTrack Dashboard'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatCard('Account Balance', '\$${accountBalance.toStringAsFixed(2)}', Colors.white),
            const SizedBox(height: 12),
            _buildStatCard('Total PnL', '+\$${totalPnL.toStringAsFixed(2)}', Colors.greenAccent),
            const SizedBox(height: 12),
            _buildStatCard('Target Progress', '0.0% (\$${profitTarget.toStringAsFixed(0)} Target)', Colors.blueAccent),
            const SizedBox(height: 12),
            _buildStatCard('Daily Loss Limit', '\$${dailyLossLimit.toStringAsFixed(2)}', Colors.redAccent),
            const SizedBox(height: 24),
            const Text(
              'Analytics & Stats',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Win Rate'), Text('0.0% (0 W / 0 L)')]),
                  Divider(color: Colors.grey),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Profit Factor'), Text('0.00')]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color valueColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(value, style: TextStyle(color: valueColor, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
