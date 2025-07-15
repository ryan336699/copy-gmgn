import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetsWalletPage extends StatefulWidget {
  final VoidCallback onLogout;

  const AssetsWalletPage({
    super.key,
    required this.onLogout,
  });

  @override
  State<AssetsWalletPage> createState() => _AssetsWalletPageState();
}

class _AssetsWalletPageState extends State<AssetsWalletPage> {
  int _selectedTab = 1; // Analysis selected by default
  int _selectedHoldingsTab = 0; // Holdings selected by default

  Future<void> _handleLogout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      widget.onLogout();
    } catch (e) {
      // If SharedPreferences fails, still trigger logout
      widget.onLogout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildBalanceSection(),
              _buildActionButtons(),
              _buildAnalysisTabs(),
              _buildAnalysisContent(),
              _buildHoldingsSection(),
              _buildDepositBanner(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 40,
              height: 40,
              color: Colors.orange[100],
              child: const Icon(Icons.person, color: Colors.orange, size: 24),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'FESV...va2z',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.copy, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Icon(Icons.remove_red_eye_outlined, size: 16, color: Colors.grey),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Follower',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.school, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(
                  'Tutorial',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.share, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  Widget _buildBalanceSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.currency_bitcoin,
                  size: 12,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'SOL',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
              const Spacer(),
              const Text(
                'Total bal.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.visibility_off, size: 16, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Text(
                '≈ ',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.grey,
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
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            icon: Icons.arrow_downward,
            label: 'Deposit',
            color: const Color(0xFF34C759),
            onTap: _handleLogout, // Logout when deposit is tapped
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
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    bool hasHotLabel = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
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
                      borderRadius: BorderRadius.circular(6),
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
      ),
    );
  }

  Widget _buildAnalysisTabs() {
    final tabs = ['PnL', 'Analysis', 'Distribution', 'Phis'];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final title = entry.value;
          final isSelected = _selectedTab == index;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTab = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey[800] : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                  if (title == 'Phis') ...[
                    const SizedBox(width: 4),
                    const Text(
                      '7d',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAnalysisContent() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Column(
        children: [
          _AnalysisRow(label: 'Total PnL', value: '--'),
          _AnalysisRow(label: 'Unrealized Profits', value: '-- SOL'),
          _AnalysisRow(label: '7d Avg Duration', value: '--'),
          _AnalysisRow(label: '7d Total Cost', value: '-- SOL'),
          _AnalysisRow(label: '7d Token Avg Cost', value: '-- SOL'),
          _AnalysisRow(label: '7d Token Avg Realized Profits', value: '-- SOL'),
        ],
      ),
    );
  }

  Widget _buildHoldingsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedHoldingsTab = 0;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  margin: const EdgeInsets.only(right: 24),
                  decoration: BoxDecoration(
                    border: _selectedHoldingsTab == 0
                        ? const Border(bottom: BorderSide(color: Colors.black, width: 2))
                        : null,
                  ),
                  child: Text(
                    'Holdings',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: _selectedHoldingsTab == 0 ? FontWeight.w600 : FontWeight.w400,
                      color: _selectedHoldingsTab == 0 ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedHoldingsTab = 1;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: _selectedHoldingsTab == 1
                        ? const Border(bottom: BorderSide(color: Colors.black, width: 2))
                        : null,
                  ),
                  child: Text(
                    'Activity',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: _selectedHoldingsTab == 1 ? FontWeight.w600 : FontWeight.w400,
                      color: _selectedHoldingsTab == 1 ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'USwap',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4),
                    CircleAvatar(
                      radius: 6,
                      backgroundColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Text(
                'Sort by: ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Last TX High to Low',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
              Spacer(),
              Icon(Icons.filter_list, size: 16, color: Colors.grey),
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
          const SizedBox(height: 32),
          // Empty state placeholder
          SizedBox(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 48,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No holdings yet',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepositBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey[200]!),
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
          GestureDetector(
            onTap: _handleLogout,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(6),
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
          ),
          const SizedBox(width: 12),
          const Icon(Icons.close, color: Colors.grey),
        ],
      ),
    );
  }
}

class _AnalysisRow extends StatelessWidget {
  final String label;
  final String value;

  const _AnalysisRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}