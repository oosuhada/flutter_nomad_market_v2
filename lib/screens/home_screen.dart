// screens/home_screen.dart
import 'package:flutter/material.dart';

import '../screens/chat_list_screen.dart';
import '../screens/community_screen.dart';
import '../screens/my_page_screen.dart';
import '../widgets/cultural_insight_card.dart';
import '../widgets/local_trend_card.dart';
import '../widgets/traveler_profile_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const CommunityScreen(),
    const ChatListScreen(),
    const MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: _pages[_selectedIndex], // 수정된 부분
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: const Text(
        'Nomad Market',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.live_tv, color: Colors.black),
          onPressed: () {}, // 실시간 현지 방송
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.person_outline, color: Colors.black),
          onPressed: () {},
        ),
      ],
      bottom: _selectedIndex == 0
          ? PreferredSize(
              // 홈 화면에서만 검색바 표시
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '상품, 여행자, 문화 컨텐츠 검색',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.tune),
                      onPressed: () {}, // 문화/지역 기반 필터
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: '쇼핑',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: '커뮤니티',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: '채팅',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '마이',
        ),
      ],
    );
  }
}

// 홈 컨텐츠를 별도 위젯으로 분리
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildCategories(),
        const SizedBox(height: 24),
        _buildLocalTrends(),
        const SizedBox(height: 24),
        _buildCulturalInsights(),
        const SizedBox(height: 24),
        _buildTravelers(),
        const SizedBox(height: 24),
        _buildHotDeals(),
      ],
    );
  }

  Widget _buildCategories() {
    final categories = [
      {'icon': Icons.diamond, 'name': '럭셔리', 'color': Colors.purple},
      {'icon': Icons.star, 'name': '한정판', 'color': Colors.orange},
      {'icon': Icons.spa, 'name': 'K-뷰티', 'color': Colors.pink},
      {'icon': Icons.devices, 'name': '디지털', 'color': Colors.blue},
      {'icon': Icons.checkroom, 'name': '패션', 'color': Colors.green},
      {'icon': Icons.local_mall, 'name': '빈티지', 'color': Colors.brown},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '인기 카테고리',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Card(
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      category['icon'] as IconData,
                      color: category['color'] as Color,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category['name'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLocalTrends() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '실시간 현지 트렌드',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('더보기'),
            ),
          ],
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return const LocalTrendCard();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCulturalInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '현지 문화 인사이트',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('더보기'),
            ),
          ],
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return const CulturalInsightCard();
            },
          ),
        ),
      ],
    );
  }

  // 기존 _buildTravelers() 메서드 수정
  Widget _buildTravelers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '추천 현지 전문가',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('더보기'),
            ),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return const TravelerProfileCard();
          },
        ),
      ],
    );
  }

  Widget _buildHotDeals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '실시간 인기 상품',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/product');
              },
              child: Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red[50],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.local_fire_department,
                                        size: 12,
                                        color: Colors.red[700],
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        'HOT',
                                        style: TextStyle(
                                          color: Colors.red[700],
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    _getLocation(index),
                                    style: TextStyle(
                                      color: Colors.blue[700],
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _getProductTitle(index),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              _getProductDescription(index),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  _getDiscountRate(index),
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _getPrice(index),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _buildTag('무료배송', Colors.blue),
                                const SizedBox(width: 8),
                                _buildTag('당일발송', Colors.green),
                                if (index == 0) ...[
                                  const SizedBox(width: 8),
                                  _buildTag('매장 한정', Colors.purple),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTag(String text, MaterialColor color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color[50],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color[700],
          fontSize: 12,
        ),
      ),
    );
  }

  String _getLocation(int index) {
    switch (index) {
      case 0:
        return '파리';
      case 1:
        return '밀라노';
      case 2:
        return '도쿄';
      default:
        return '';
    }
  }

  String _getProductTitle(int index) {
    switch (index) {
      case 0:
        return '[파리 백화점 한정] 럭셔리 가방';
      case 1:
        return '[밀라노 직배송] 한정판 지갑';
      case 2:
        return '[도쿄 한정] 디지털 가전';
      default:
        return '';
    }
  }

  String _getProductDescription(int index) {
    switch (index) {
      case 0:
        return '프랑스 파리 갤러리 라파예트 단독 컬러';
      case 1:
        return '이탈리아 현지 아울렛 특가';
      case 2:
        return '일본 한정 에디션';
      default:
        return '';
    }
  }

  String _getDiscountRate(int index) {
    switch (index) {
      case 0:
        return '35%';
      case 1:
        return '40%';
      case 2:
        return '25%';
      default:
        return '';
    }
  }

  String _getPrice(int index) {
    switch (index) {
      case 0:
        return '₩279,000';
      case 1:
        return '₩189,000';
      case 2:
        return '₩159,000';
      default:
        return '';
    }
  }
}
