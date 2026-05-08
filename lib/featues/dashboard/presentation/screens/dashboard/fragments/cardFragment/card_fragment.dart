import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/cardFragment/widget/card_information.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/cardFragment/widget/recent_card_transactions.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/cardFragment/widget/security_controls.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/cardFragment/widget/virtual_card_widget.dart';
import '../../../../../../../core/theme/app_theme.dart';
import '../../../../provider/card_provider.dart';



class CardFragment extends ConsumerStatefulWidget {
  const CardFragment ({super.key});

  @override
  ConsumerState<CardFragment > createState() => _CardFragmentState();
}

class _CardFragmentState extends ConsumerState<CardFragment> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(virtualCardProvider.notifier).loadCardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardState = ref.watch(virtualCardProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/150?img=3",
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "Tupay",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
        ],
      ),
      body: cardState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (state) {
          if (state is VirtualCardSuccess) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VirtualCardWidget(cardData: state),
                  const SizedBox(height: 24),

                  SecurityControls(cardData: state),
                  const SizedBox(height: 32),

                  CardInformation(cardData: state),
                  const SizedBox(height: 32),

                  Card(
                    color: AppColors.cardBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'RECENT TRANSACTIONS',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: AppColors.recentCard),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text('View All', style: TextStyle(color: AppColors.primaryDark)),
                              ),
                            ],
                          ),
                        ),
                        RecentCardTransactions(transactions: state.recentTransactions),
                      ],
                    ),
                  ),

                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}