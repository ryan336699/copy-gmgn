import 'dart:math';
import 'package:flutter/material.dart';
import 'wallet_detail_page.dart';

class WalletTrackerPage extends StatefulWidget {
  const WalletTrackerPage({super.key});

  @override
  State<WalletTrackerPage> createState() => _WalletTrackerPageState();
}

class _WalletTrackerPageState extends State<WalletTrackerPage> {
  int _selectedTabIndex = 1; // Track selected by default
  int _selectedPeriod = 0; // 7D selected
  int _selectedCategory = 0; // All selected
  final List<String> _topTabs = ['Rank', 'Wallet Tracker', 'Track', 'CopyTrade'];
  final List<String> _categories = ['All', 'Pump SM', 'Smart Money', 'Fresh Wallet', 'KOL'];
  final List<String> _periods = ['7D', '1D', '30D'];

  final Random _random = Random();

  String _generateRandomName() {
    final names = ['Cupsey', 'gake', 'H2Vn...Hzt4', 'J44C...KBSx', 'Trader_X', 'CryptoKing', 'Moon_Walker', 'Diamond_Hands'];
    return names[_random.nextInt(names.length)];
  }

  String _generateRandomPnL() {
    final amounts = [370.74, 346.39, 192.33, 170.65, 289.45, 456.78, 123.89, 567.23];
    return amounts[_random.nextInt(amounts.length)].toStringAsFixed(2);
  }

  String _generateRandomPercentage() {
    final percentages = [15.7, 561.1, 23.3, 1.69, 45.2, 123.4, 67.8, 234.5];
    return percentages[_random.nextInt(percentages.length)].toStringAsFixed(1);
  }

  int _generateRandomFollowers() {
    final followers = [20320, 53361, 412, 40, 15678, 8945, 2334, 45678];
    return followers[_random.nextInt(followers.length)];
  }

  double _generateRandomWinRate() {
    final rates = [70.7, 92.5, 56.3, 100.0, 84.2, 76.8, 91.3, 68.9];
    return rates[_random.nextInt(rates.length)];
  }

  String _generateRandomTxs() {
    final txs = ['798K', '181', '319', '118', '456', '789', '234', '567'];
    return txs[_random.nextInt(txs.length)];
  }

  String _generateRandomWinLoss() {
    final winLoss = ['5.03K/2.94K', '50/131', '137/182', '1/117', '234/56', '89/45', '156/78', '345/123'];
    return winLoss[_random.nextInt(winLoss.length)];
  }

  String _generateRandomTime() {
    final times = ['20m ago', '2h ago', '4h ago', '10h ago', '1h ago', '30m ago', '5h ago', '8h ago'];
    return times[_random.nextInt(times.length)];
  }

  double _generateRandomBalance() {
    final balances = [2038.74, 1460.36, 0.0, 0.0, 1570.06, 2345.67, 3456.78, 4567.89];
    return balances[_random.nextInt(balances.length)];
  }

  String _generateRandomAvatar() {
    final avatars = [
      'https://i.pravatar.cc/150?img=1',
      'https://i.pravatar.cc/150?img=2',
      'https://i.pravatar.cc/150?img=3',
      'https://i.pravatar.cc/150?img=4',
      'https://i.pravatar.cc/150?img=5',
      'https://i.pravatar.cc/150?img=6',
      'https://i.pravatar.cc/150?img=7',
      'https://i.pravatar.cc/150?img=8',
    ];
    return avatars[_random.nextInt(avatars.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildTopTabBar(),
          _buildCategoryTabs(),
          _buildFilterSection(),
          Expanded(
            child: _buildWalletList(),
          ),
          _buildDepositBanner(),
        ],
      ),
    );
  }

  Widget _buildTopTabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _topTabs.asMap().entries.map((entry) {
                  final index = entry.key;
                  final title = entry.value;
                  final isSelected = _selectedTabIndex == index;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      margin: const EdgeInsets.only(right: 24),
                      decoration: BoxDecoration(
                        border: isSelected
                            ? const Border(
                                bottom: BorderSide(color: Colors.black, width: 2),
                              )
                            : null,
                      ),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected ? Colors.black : Colors.grey[600],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const Icon(Icons.search, color: Colors.grey, size: 24),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _categories.asMap().entries.map((entry) {
            final index = entry.key;
            final category = entry.value;
            final isSelected = _selectedCategory == index;
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.grey[600],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Text(
                    'Period:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ...List.generate(_periods.length, (index) {
                    final isSelected = _selectedPeriod == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPeriod = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.yellow : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _periods[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 16),
                  const Text(
                    'Sort by:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'PnL High to Low',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Row(
            children: [
              Icon(Icons.filter_list, color: Colors.grey, size: 16),
              SizedBox(width: 4),
              Text(
                'Filter',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWalletList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildWalletItem(index + 1);
      },
    );
  }

  Widget _buildWalletItem(int rank) {
    final name = _generateRandomName();
    final pnl = _generateRandomPnL();
    final percentage = _generateRandomPercentage();
    final followers = _generateRandomFollowers();
    final winRate = _generateRandomWinRate();
    final txs = _generateRandomTxs();
    final winLoss = _generateRandomWinLoss();
    final time = _generateRandomTime();
    final balance = _generateRandomBalance();
    final avatar = _generateRandomAvatar();
    
    String rankSuffix = 'th';
    if (rank == 1) {
      rankSuffix = 'st';
    } else if (rank == 2) {
      rankSuffix = 'nd';
    } else if (rank == 3) {
      rankSuffix = 'rd';
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WalletDetailPage(
              walletName: name,
              walletAddress: 'H2Vn...Hzt4',
              avatar: avatar,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 60), // Space for the rank badge
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
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
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.person, color: Colors.grey),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
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
                              const Icon(Icons.edit, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              const Icon(Icons.copy, size: 16, color: Colors.grey),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.currency_bitcoin,
                                  size: 10,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                balance.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.help_outline, size: 12, color: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.track_changes, size: 16, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'Track',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '+\$${pnl}K',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            '(+$percentage%) PnL',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${followers.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} Followers',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Win Rate',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${winRate.toStringAsFixed(1)}%',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'TXs',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '$txs ($winLoss)',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Last Active',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                time,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Positioned rank badge in top-left corner
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: rank <= 3 ? Colors.orange : Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Text(
                '$rank$rankSuffix',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: rank <= 3 ? Colors.white : Colors.grey[600],
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildDepositBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Low balance, deposit now!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.cyan,
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
          const Icon(Icons.close, color: Colors.grey),
        ],
      ),
    );
  }
}