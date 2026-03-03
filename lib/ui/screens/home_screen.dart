import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namecard/ui/screens/profile_edit_screen.dart';
import 'package:namecard/ui/screens/wallet_screen.dart';
import 'package:namecard/ui/screens/exchange_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const ProfileEditScreen(), // Tab 0: My Card
          const WalletScreen(), // Tab 1: Wallet
          const ExchangeScreen(), // Tab 2: Exchange
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'My Card',
          ),
          NavigationDestination(
            icon: Icon(Icons.wallet_outlined),
            selectedIcon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: Icon(Icons.compare_arrows),
            label: 'Exchange',
          ),
        ],
      ),
    );
  }
}
