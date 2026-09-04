import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/account_repository.dart';

class AddAccountScreen extends ConsumerStatefulWidget {
  const AddAccountScreen({super.key});

  @override
  ConsumerState<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends ConsumerState<AddAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _firmController = TextEditingController();
  final _balanceController = TextEditingController();
  final _targetController = TextEditingController();
  final _dailyLossController = TextEditingController();
  final _maxLossController = TextEditingController();
  String _accountType = 'Challenge';

  void _saveAccount() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(accountsProvider.notifier).addAccount(
        name: _nameController.text,
        propFirm: _firmController.text,
        accountType: _accountType,
        startingBalance: double.parse(_balanceController.text),
        profitTarget: double.tryParse(_targetController.text) ?? 0.0,
        dailyLossLimit: double.tryParse(_dailyLossController.text) ?? 0.0,
        maxDrawdown: double.tryParse(_maxLossController.text) ?? 0.0,
      );
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Account Nickname'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _firmController,
                decoration: const InputDecoration(labelText: 'Prop Firm Name (e.g. FTMO)'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _accountType,
                decoration: const InputDecoration(labelText: 'Account Type'),
                items: ['Challenge', 'Funded', 'Funded+Instant'].map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (val) => setState(() => _accountType = val!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _balanceController,
                decoration: const InputDecoration(labelText: 'Starting Balance (\$)'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _targetController,
                decoration: const InputDecoration(labelText: 'Profit Target (\$)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _dailyLossController,
                decoration: const InputDecoration(labelText: 'Daily Loss Limit (\$)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _maxLossController,
                decoration: const InputDecoration(labelText: 'Max Drawdown Limit (\$)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveAccount,
                  child: const Text('Save Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
