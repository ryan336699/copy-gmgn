import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TradingDetailPage extends StatefulWidget {
  const TradingDetailPage({super.key});

  @override
  State<TradingDetailPage> createState() => _TradingDetailPageState();
}

class _TradingDetailPageState extends State<TradingDetailPage> {
  int _selectedTabIndex = 0;
  int _selectedTimeIndex = 1; // 30s selected by default
  bool _isBuySelected = true;
  int _selectedBuyPercentage = 0; // 0.05 selected
  int _selectedSellPercentage = 0; // 10% selected

  final List<String> _timeFrames = ['1s', '30s', '1m', '1H', 'More'];
  final List<String> _buyAmounts = ['0.05', '0.1', '0.5', '1'];
  final List<String> _sellPercentages = ['10%', '25%', '50%', '100%'];

  List<FlSpot> _generateRandomChartData() {
    final random = Random();
    final List<FlSpot> spots = [];
    double basePrice = 0.05488;
    
    for (int i = 0; i < 50; i++) {
      basePrice += (random.nextDouble() - 0.5) * 0.001;
      spots.add(FlSpot(i.toDouble(), basePrice));
    }
    return spots;
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
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://i.pravatar.cc/150?img=5',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.currency_bitcoin, size: 20),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Normie',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.star_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildPriceSection(),
                  _buildChartSection(),
                  _buildTradingSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final tabs = ['Markets', 'Activity', 'Holders(40)', 'Traders', 'My'];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              margin: const EdgeInsets.only(right: 16),
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
    );
  }

  Widget _buildPriceSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Price',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.swap_vert, size: 16, color: Colors.grey),
              const Spacer(),
              const Text(
                'Total MC',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                '\$4.88K',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                '\$0.05488',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '-2.87%',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
              const Spacer(),
              const Text(
                '24h Volume',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '\$103.54K',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                '2fGM...bonk',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.copy, size: 14, color: Colors.grey),
              const SizedBox(width: 16),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                '1/70',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                '📊 0%',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(width: 16),
              const Text(
                '📈',
                style: TextStyle(fontSize: 14),
              ),
              const Spacer(),
              const Text(
                '11%',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Run',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: _timeFrames.asMap().entries.map((entry) {
              final index = entry.key;
              final timeFrame = entry.value;
              final isSelected = _selectedTimeIndex == index;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTimeIndex = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.grey[200] : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    timeFrame,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? Colors.black : Colors.grey[600],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 0.01,
                  verticalInterval: 10,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300]!,
                      strokeWidth: 0.5,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300]!,
                      strokeWidth: 0.5,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 80,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toStringAsFixed(5),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 10,
                      getTitlesWidget: (value, meta) {
                        if (value == 0) return const Text('12:00', style: TextStyle(fontSize: 10));
                        if (value == 25) return const Text('12:30', style: TextStyle(fontSize: 10));
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 49,
                minY: 0.048,
                maxY: 0.061,
                lineBarsData: [
                  LineChartBarData(
                    spots: _generateRandomChartData(),
                    isCurved: false,
                    color: Colors.red,
                    barWidth: 1,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('VOL: '),
              const Text('3.62 ', style: TextStyle(color: Colors.blue)),
              const Text('MAVOL5:'),
              const Text('322.36 ', style: TextStyle(color: Colors.orange)),
              const Text('MAVOL10:'),
              const Text('268.22', style: TextStyle(color: Colors.orange)),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Text('MA  EMA  BOLL  SAR  |  '),
              Text('VOL ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('MACD  KDJ  RSI  StochRsi  TRIX'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTradingSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.arrow_back, size: 20),
              SizedBox(width: 8),
              Text(
                'Instant trade',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                'P1',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              SizedBox(width: 8),
              Icon(Icons.help_outline, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Click to submit a market order immediately',
            style: TextStyle(
              fontSize: 14,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 24),
          
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isBuySelected = true;
                  });
                },
                child: Text(
                  'Buy',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: _isBuySelected ? Colors.green : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.trending_up, color: Colors.green, size: 20),
              const Spacer(),
              const Text(
                'Balance',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '0 SOL',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.add, color: Colors.green, size: 16),
            ],
          ),
          const SizedBox(height: 16),
          
          Row(
            children: _buyAmounts.asMap().entries.map((entry) {
              final index = entry.key;
              final amount = entry.value;
              final isSelected = _selectedBuyPercentage == index;
              
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedBuyPercentage = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: index < _buyAmounts.length - 1 ? 8 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green[100] : Colors.grey[100],
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.grey[300]!,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        amount,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.green : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              const Icon(Icons.auto_awesome, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              const Text(
                'Auto',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.speed, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              const Text(
                '0.005',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.toggle_off, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              const Text(
                'Off',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              const Text(
                'TP/SL',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const Text(
                'Not Set',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isBuySelected = false;
                  });
                },
                child: Text(
                  'Sell',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: !_isBuySelected ? Colors.red : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.trending_down, color: Colors.red, size: 20),
              const Spacer(),
              const Text(
                'Balance',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '0 Normie (0 SOL)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          Row(
            children: _sellPercentages.asMap().entries.map((entry) {
              final index = entry.key;
              final percentage = entry.value;
              final isSelected = _selectedSellPercentage == index;
              
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSellPercentage = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: index < _sellPercentages.length - 1 ? 8 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red[100] : Colors.grey[100],
                      border: Border.all(
                        color: isSelected ? Colors.red : Colors.grey[300]!,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        percentage,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.red : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          
          const Row(
            children: [
              Icon(Icons.auto_awesome, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                'Auto',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 16),
              Icon(Icons.speed, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                '0.005',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 16),
              Icon(Icons.toggle_off, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                'Off',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Spacer(),
              Text(
                'Speed Boost',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}