import 'dart:math';
import 'package:flutter/material.dart';
import 'copy_trade_page.dart';

class WalletDetailPage extends StatefulWidget {
  final String walletName;
  final String walletAddress;
  final String avatar;

  const WalletDetailPage({
    super.key,
    required this.walletName,
    required this.walletAddress,
    required this.avatar,
  });

  @override
  State<WalletDetailPage> createState() => _WalletDetailPageState();
}

class _WalletDetailPageState extends State<WalletDetailPage> {
  int _selectedAnalysisTab = 1; // Analysis selected by default
  int _selectedHoldingsTab = 0; // Holdings selected by default
  
  final Random _random = Random();

  // Generate random data
  int _generateRandomFollowers() {
    return _random.nextInt(1000) + 100;
  }

  int _generateRandomTXs() {
    return _random.nextInt(500) + 50;
  }

  double _generateRandomBalance() {
    return _random.nextDouble() * 100;
  }

  double _generateRandomPnL() {
    return (_random.nextDouble() - 0.5) * 2000 + 1000;
  }

  double _generateRandomSOL() {
    return _random.nextDouble() * 100;
  }

  String _generateRandomTime() {
    final hours = _random.nextInt(24) + 1;
    return '${hours}h';
  }

  double _generateRandomPercentage() {
    return (_random.nextDouble() - 0.5) * 200;
  }

  List<Map<String, dynamic>> _generateHoldings() {
    final tokens = ['TIKTOK', 'Lucid Air', 'BONK', 'PEPE', 'DOGE'];
    final holdings = <Map<String, dynamic>>[];
    
    for (int i = 0; i < 3; i++) {
      final token = tokens[_random.nextInt(tokens.length)];
      final balance = _generateRandomSOL();
      final bought = _generateRandomSOL();
      final pnl = _generateRandomSOL();
      final percentage = _generateRandomPercentage();
      final time = _generateRandomTime();
      
      holdings.add({
        'token': token,
        'balance': balance,
        'bought': bought,
        'pnl': pnl,
        'percentage': percentage,
        'time': time,
        'isProfit': percentage > 0,
      });
    }
    
    return holdings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.walletName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.edit, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                const Icon(Icons.verified, size: 16, color: Colors.green),
              ],
            ),
            Row(
              children: [
                Text(
                  widget.walletAddress,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.copy, size: 12, color: Colors.grey),
                const SizedBox(width: 8),
                const Icon(Icons.open_in_new, size: 12, color: Colors.grey),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeaderSection(),
          _buildWalletBalance(),
          _buildAnalysisSection(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHoldingsSection(),
                  _buildCopyButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    final followers = _generateRandomFollowers();
    final txs = _generateRandomTXs();
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              widget.avatar,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.person, color: Colors.grey, size: 40),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Followers',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          followers.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'TXs',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          txs.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
    );
  }

  Widget _buildWalletBalance() {
    final balance = _generateRandomBalance();
    final totalPnL = _generateRandomPnL();
    final duration = '${_random.nextInt(20) + 5}h';
    final totalCost = _generateRandomSOL();
    final avgCost = _generateRandomSOL();
    final avgProfits = _generateRandomSOL();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Wallet balance row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Wallet balance',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  Text(
                    '≈${balance.toStringAsFixed(0)} SOL',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.visibility_off, size: 16, color: Colors.grey),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Analysis rows
          _buildAnalysisRow('Total PnL', '+${totalPnL.toStringAsFixed(2)}K SOL(+${(totalPnL * 0.2).toStringAsFixed(2)}%)', Colors.green),
          _buildAnalysisRow('Unrealized Profits', '-- SOL', Colors.grey),
          _buildAnalysisRow('7d Avg Duration', duration, Colors.grey),
          _buildAnalysisRow('7d Total Cost', '${totalCost.toStringAsFixed(2)}K SOL', Colors.grey),
          _buildAnalysisRow('7d Token Avg Cost', '${avgCost.toStringAsFixed(2)} SOL', Colors.grey),
          _buildAnalysisRow('7d Token Avg Realized Profits', '+${avgProfits.toStringAsFixed(2)} SOL', Colors.green),
        ],
      ),
    );
  }

  Widget _buildAnalysisSection() {
    final tabs = ['PnL', 'Analysis', 'Distribution', 'Phis'];
    
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final title = entry.value;
          final isSelected = _selectedAnalysisTab == index;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedAnalysisTab = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey[800] : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
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

  Widget _buildAnalysisRow(String label, String value, Color valueColor) {
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
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHoldingsSection() {
    final holdings = _generateHoldings();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Holdings tabs
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
            ],
          ),
          const SizedBox(height: 16),
          
          // Sort and filter
          Row(
            children: [
              const Text(
                'Sort by: ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const Text(
                'Last TX High to Low',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
              const Spacer(),
              const Icon(Icons.filter_list, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              const Text(
                'Filter',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Table header
          const Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Token/Last TX',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Balance/Bought',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'PnL',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Icon(Icons.swap_vert, size: 12, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Holdings list
          ...holdings.map((holding) => _buildHoldingItem(holding)),
        ],
      ),
    );
  }

  Widget _buildHoldingItem(Map<String, dynamic> holding) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Token info
          Expanded(
            flex: 2,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    width: 32,
                    height: 32,
                    color: Colors.grey[800],
                    child: const Icon(Icons.currency_bitcoin, color: Colors.white, size: 16),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          holding['token'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.copy, size: 12, color: Colors.grey),
                      ],
                    ),
                    Text(
                      holding['time'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Balance info
          Expanded(
            child: Column(
              children: [
                Text(
                  '${holding['balance'].toStringAsFixed(0)} SOL',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${holding['bought'].toStringAsFixed(2)} SOL',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          // PnL info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${holding['isProfit'] ? '+' : ''}${holding['pnl'].toStringAsFixed(2)} SOL',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: holding['isProfit'] ? Colors.green : Colors.red,
                  ),
                ),
                Text(
                  '(${holding['isProfit'] ? '+' : ''}${holding['percentage'].toStringAsFixed(1)}%)',
                  style: TextStyle(
                    fontSize: 12,
                    color: holding['isProfit'] ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.more_vert, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildCopyButton() {
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CopyTradePage(
                walletName: widget.walletName,
                walletAddress: widget.walletAddress,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[800],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Copy now',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}