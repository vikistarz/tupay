
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/homeFragment/widget/transaction_list.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/homeFragment/widget/wallet_section.dart';


import '../../../../../../../core/theme/app_theme.dart';
import '../../../../provider/homeProvider.dart';
import 'widget/action_buttons.dart';
import 'widget/balance_card.dart';


class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  ConsumerState<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> with RestorationMixin {
  final RestorableBool _isBalanceVisible = RestorableBool(true);

  @override
  String? get restorationId => 'home_screen';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_isBalanceVisible, 'balance_visible');
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(homeProvider.notifier).refreshData();
    });
  }

  @override
  void dispose() {
    _isBalanceVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    
    final homeAsync = ref.watch(homeProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () => ref.read(homeProvider.notifier).refreshData(),
          child: CustomScrollView(
            restorationId: 'home_scroll',
            slivers: [
      
              SliverAppBar(
                floating: true,
                pinned: false,
                elevation: 0,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
      
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
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Stack(
                      children: [
                        const Icon(Icons.notifications_none, size: 28),
      
                        // Positioned(
                        //   right: 0,
                        //   top: 2,
                        //   child: Container(
                        //     width: 8,
                        //     height: 8,
                        //     decoration: BoxDecoration(
                        //       color: Theme.of(context).colorScheme.error,
                        //       shape: BoxShape.circle,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
      
                /// 🔥 THIS adds the line under the app bar
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1),
                  child: Container(
                    height: 1,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
              ),
      
      
      
      
              SliverPersistentHeader(
                pinned: true,
                delegate: BalanceHeaderDelegate(
                  maxHeight: 220,
                  minHeight: 220,
                  isVisible: _isBalanceVisible.value,
                  onVisibilityToggle: () {
                    setState(() => _isBalanceVisible.value = !_isBalanceVisible.value);
                  },
                ),
              ),
      
              // Action Buttons
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: ActionButtons(),
                ),
              ),
      
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
      
              // Wallets Section
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: WalletSection(),
                ),
              ),
      
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
      
              // Recent Transactions
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: const Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: AppColors.textPrimary)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('See all', style: TextStyle(color: AppColors.primaryDark)),
                      ),
                    ],
                  ),
                ),
              ),
      
              // Transactions List
              // child: TransactionList()
              TransactionsSection(homeAsync: homeAsync),
      
            ],
          ),
        ),
      ),
    );
  }
}



