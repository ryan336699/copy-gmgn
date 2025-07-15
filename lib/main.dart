import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'trading_detail_page.dart';
import 'wallet_tracker_page.dart';
import 'assets_onboarding_page.dart';
import 'assets_wallet_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GMGN Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Text',
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DiscoverPage(),
    const TrackPage(),
    const TradePage(),
    const MonitorPage(),
    const AssetsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF00D4AA),
        unselectedItemColor: const Color(0xFF8E8E93),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Track',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'Trade',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor),
            label: 'Monitor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Assets',
          ),
        ],
      ),
    );
  }
}

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TradingInterface();
  }
}

class TrackPage extends StatelessWidget {
  const TrackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WalletTrackerPage();
  }
}

class TradePage extends StatelessWidget {
  const TradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TradingInterface();
  }
}

class MonitorPage extends StatelessWidget {
  const MonitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TradingInterface();
  }
}

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  bool _isLoggedIn = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      // Wait for a few frames to ensure the framework is ready
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;
      
      final prefs = await SharedPreferences.getInstance();
      if (mounted) {
        setState(() {
          _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
          _isLoading = false;
        });
      }
    } catch (e) {
      // If there's any error, default to not logged in
      if (mounted) {
        setState(() {
          _isLoggedIn = false;
          _isLoading = false;
        });
      }
    }
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _isLoggedIn
        ? AssetsWalletPage(onLogout: _handleLogout)
        : AssetsOnboardingPage(onLoginSuccess: _checkLoginStatus);
  }
}

class TradingInterface extends StatefulWidget {
  const TradingInterface({super.key});

  @override
  State<TradingInterface> createState() => _TradingInterfaceState();
}

class _TradingInterfaceState extends State<TradingInterface> {
  int _selectedTabIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF7ED321),
                ),
                child: const Icon(
                  Icons.android,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 40,
                  constraints: const BoxConstraints(maxWidth: 600),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search token/contract/wallet',
                      hintStyle: TextStyle(
                        color: Color(0xFF8E8E93),
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF8E8E93),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.qr_code_scanner,
                  color: Color(0xFF8E8E93),
                ),
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'S',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'SOL',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const Flexible(
                child: Text(
                  'Total bal.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8E8E93),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.visibility_off,
                size: 16,
                color: Color(0xFF8E8E93),
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: const Row(
            children: [
              Text(
                '≈ ',
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xFF8E8E93),
                ),
              ),
              Text(
                '0',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'SOL',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF8E8E93),
                ),
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                icon: Icons.arrow_downward,
                label: 'Deposit',
                color: const Color(0xFF34C759),
              ),
              _buildActionButton(
                icon: Icons.arrow_upward,
                label: 'Withdraw',
                color: const Color(0xFF007AFF),
              ),
              _buildActionButton(
                icon: Icons.credit_card,
                label: 'Buy',
                color: const Color(0xFF5856D6),
                hasHotLabel: true,
              ),
              _buildActionButton(
                icon: Icons.card_giftcard,
                label: 'Invite Now',
                color: const Color(0xFF30D158),
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTab('Watchlist', 0),
                _buildTab('Trenches', 1),
                _buildTab('New', 2),
                _buildTab('Trending', 3),
                _buildTab('xStock', 4),
              ],
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSubTab('Trenches', true),
                const SizedBox(width: 12),
                _buildSubTab('New Creation', false),
                const SizedBox(width: 12),
                _buildSubTab('Completing', false),
                const SizedBox(width: 12),
                _buildSubTab('Complet', false),
              ],
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Icon(Icons.filter_list, size: 20, color: Color(0xFF8E8E93)),
                const SizedBox(width: 4),
                const Text(
                  'Filter',
                  style: TextStyle(
                    color: Color(0xFF8E8E93),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9500),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Paused',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E5EA)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.flash_on, size: 16, color: Color(0xFF30D158)),
                      SizedBox(width: 4),
                      Text(
                        'Buy 1',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'SOL',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'P1',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8E8E93),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xFF8E8E93)),
                const SizedBox(width: 8),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E5EA)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.settings, size: 16, color: Color(0xFF8E8E93)),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        Expanded(
          child: ListView(
            children: [
              _buildTokenItem(
                name: 'OMNI',
                description: '8o1t...pump',
                time: '0s',
                holders: '1',
                volume: '\$9.77',
                marketCap: '\$4.59K',
                change1m: '0.3%',
                change5m: '0%',
                change1h: '0%',
                change6h: '0%',
                change24h: '1',
                buyCount: '0%',
                isPositive: true,
                avatar: 'https://i.pravatar.cc/150?img=1',
              ),
              _buildTokenItem(
                name: 'DoChan',
                description: '5Ppo...pump',
                time: '1s',
                holders: '4',
                volume: '\$388.11',
                marketCap: '\$5.34K',
                change1m: '99%',
                change5m: '4%',
                change1h: '4%',
                change6h: '0%',
                change24h: '3',
                buyCount: '100%',
                isPositive: true,
                avatar: 'https://i.pravatar.cc/150?img=2',
              ),
              _buildTokenItem(
                name: 'RWA500',
                description: 'Ap3i...Mquy',
                time: '4s',
                holders: '1',
                volume: '\$3.31',
                marketCap: '\$37.01K',
                change1m: '0%',
                change5m: '100%',
                change1h: '0%',
                change6h: '0%',
                change24h: '4',
                buyCount: '0%',
                isPositive: false,
                avatar: 'https://i.pravatar.cc/150?img=3',
              ),
              _buildTokenItem(
                name: 'BOBA',
                description: 'v7eS...bonk',
                time: '5s',
                holders: '2',
                volume: '\$12.45',
                marketCap: '\$8.92K',
                change1m: '5%',
                change5m: '2%',
                change1h: '1%',
                change6h: '0%',
                change24h: '2',
                buyCount: '50%',
                isPositive: true,
                avatar: 'https://i.pravatar.cc/150?img=4',
              ),
            ],
          ),
        ),

        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const Text(
                'Low balance, deposit now!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF00D4AA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Deposit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.close, color: Color(0xFF8E8E93)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    bool hasHotLabel = false,
  }) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            if (hasHotLabel)
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF3B30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'HOT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF1C1C1E),
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        margin: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          border: isSelected
              ? const Border(
                  bottom: BorderSide(color: Color(0xFF1C1C1E), width: 2),
                )
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? const Color(0xFF1C1C1E) : const Color(0xFF8E8E93),
          ),
        ),
      ),
    );
  }

  Widget _buildSubTab(String title, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1C1C1E) : const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : const Color(0xFF8E8E93),
        ),
      ),
    );
  }

  Widget _buildTokenItem({
    required String name,
    required String description,
    required String time,
    required String holders,
    required String volume,
    required String marketCap,
    required String change1m,
    required String change5m,
    required String change1h,
    required String change6h,
    required String change24h,
    required String buyCount,
    required bool isPositive,
    required String avatar,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TradingDetailPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              avatar,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E5EA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.token,
                    color: Color(0xFF8E8E93),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8E8E93),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.copy,
                      size: 12,
                      color: Color(0xFF8E8E93),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.search,
                      size: 12,
                      color: Color(0xFF8E8E93),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: isPositive ? const Color(0xFF30D158) : const Color(0xFFFF3B30),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          change1m,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.people, size: 12, color: Color(0xFF8E8E93)),
                      Text(
                        holders,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'V $volume',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'MC $marketCap',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        '🙋 $change5m',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF30D158),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '💰 $change1h',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF30D158),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '🎯 $change6h',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF30D158),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '👀 $change24h',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '📈 $buyCount',
                        style: TextStyle(
                          fontSize: 12,
                          color: isPositive ? const Color(0xFF30D158) : const Color(0xFFFF3B30),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF30D158),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flash_on, size: 16, color: Colors.white),
                SizedBox(width: 4),
                Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}