import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tupay_app/core/theme/app_theme.dart';
import '../../../provider/navigation_provider.dart';
import '../fragments/cardFragment/card_fragment.dart';
import '../fragments/homeFragment/home_fragment.dart';
import '../fragments/profileFragment/profile_fragment.dart';
import '../fragments/transferFragment/transfer_fragment.dart';


class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);

    final fragments = const [
      HomeFragment(),
      CardFragment(),
      TransferFragment(),
      ProfileFragment(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: fragments,
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(), // 👈 space from screen edges
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20), // 👈 rounded corners
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // 👈 clip children
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                ref.read(bottomNavProvider.notifier).state = index;
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.cardBackground,

              selectedItemColor: AppColors.bottomNavEnable,
              unselectedItemColor: AppColors.bottomNavDisabled,

              selectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),

              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
              ),

              showUnselectedLabels: true,

              items: const [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.grid_view_outlined, // 👈 inactive
                      size: 22,
                    ),
                  ),

                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.grid_view_rounded, // 👈 active
                      size: 22,
                    ),
                  ),

                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.credit_card_outlined,
                      size: 22,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.credit_card,
                      size: 22,
                    ),
                  ),
                  label: "Cards",
                ),

                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.swap_horiz_outlined,
                      size: 22,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.swap_horiz,
                      size: 22,
                    ),
                  ),
                  label: "Transfer",
                ),

                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.person_outline,
                      size: 22,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.person,
                      size: 22,
                    ),
                  ),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}