import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/account_repository.dart';
import '../../../data/repositories/active_account_provider.dart';
import '../../accounts/add_account_screen.dart';

class AccountDrawer extends ConsumerWidget {
  const AccountDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(accountsProvider);
    final activeAccountId = ref.watch(activeAccountIdProvider);

    return Drawer(
      backgroundColor: const Color(0xFF121824),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Prop Accounts',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(color: Color(0xFF1F293D)),
            Expanded(
              child: accountsAsync.when(
                data: (accounts) {
                  if (accounts.isEmpty) {
                    return const Center(
                      child: Text('No accounts created.', style: TextStyle(color: Colors.grey)),
                    );
                  }

                  return ListView.builder(
                    itemCount: accounts.length,
                    itemBuilder: (context, index) {
                      final account = accounts[index];
                      final isSelected = (activeAccountId == null && index == 0) || activeAccountId == account.id;

                      return ListTile(
                        selected: isSelected,
                        selectedTileColor: const Color(0xFF1F293D),
                        title: Text(account.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text('${account.propFirm} • \$${account.startingBalance.toStringAsFixed(0)}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        trailing: isSelected
                            ? Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withAlpha(40),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text('ACTIVE', style: TextStyle(color: Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.bold)),
                              )
                            : null,
                        onTap: () {
                          ref.read(activeAccountIdProvider.notifier).selectAccount(account.id);
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Text('Error: $err', style: const TextStyle(color: Colors.red)),
              ),
            ),
            const Divider(color: Color(0xFF1F293D)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB)),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AddAccountScreen()),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Account'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
