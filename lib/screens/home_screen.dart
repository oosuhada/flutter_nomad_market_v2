import 'package:flutter/material.dart';

import '../data/demo_marketplace_data.dart';
import '../models/marketplace_item.dart';
import '../theme/nomad_theme.dart';
import '../widgets/product_card.dart';
import 'community_screen.dart';
import 'create_listing_screen.dart';
import 'my_page_screen.dart';
import 'product_detail_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      MarketplaceHomeScreen(onSelectTab: _selectTab),
      const SearchScreen(),
      const CreateListingScreen(),
      const CommunityScreen(),
      const MyPageScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _selectTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: '홈',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            label: '탐색',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline_rounded),
            selectedIcon: Icon(Icons.add_circle_rounded),
            label: '판매',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: '커뮤니티',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: '마이',
          ),
        ],
      ),
    );
  }

  void _selectTab(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
  }
}

class MarketplaceHomeScreen extends StatelessWidget {
  const MarketplaceHomeScreen({
    super.key,
    required this.onSelectTab,
  });

  final ValueChanged<int> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: _buildSearchEntry()),
            SliverToBoxAdapter(child: _buildHero()),
            SliverToBoxAdapter(child: _buildCategories()),
            SliverToBoxAdapter(
              child: _sectionHeader(
                title: '지금 뜨는 로컬 픽',
                subtitle: '여행자가 현지에서 직접 확인한 상품',
                action: '전체 보기',
                onAction: () => onSelectTab(1),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = demoMarketplaceItems[index];
                    return ProductCard(
                      item: item,
                      onTap: () => _openProduct(context, item),
                    );
                  },
                  childCount: demoMarketplaceItems.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 22,
                  childAspectRatio: .58,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 12, 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'NOMAD MARKET',
                  style: TextStyle(
                    color: NomadTheme.brand,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 18,
                      color: NomadTheme.ink,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '서울 · 성수동',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                  ],
                ),
              ],
            ),
          ),
          IconButton.filledTonal(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: '알림',
          ),
        ],
      ),
    );
  }

  Widget _buildSearchEntry() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        child: InkWell(
          onTap: () => onSelectTab(1),
          borderRadius: BorderRadius.circular(17),
          child: Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: const Color(0xFFDDE3DF)),
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, color: NomadTheme.ink),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '상품, 도시, 카테고리 검색',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                ),
                const Icon(Icons.tune_rounded, size: 20, color: NomadTheme.brand),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: NomadTheme.ink,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOCAL FINDS · GLOBAL STORIES',
                    style: TextStyle(
                      color: Color(0xFF8DD2C4),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: .9,
                    ),
                  ),
                  SizedBox(height: 9),
                  Text(
                    '여행지의 좋은 물건을\n더 가까운 거래로',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      height: 1.25,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -.3,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '현지 검수 · 채팅 문의 · 안전거래',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Container(
              width: 76,
              height: 76,
              decoration: const BoxDecoration(
                color: NomadTheme.brand,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.public_rounded, color: Colors.white, size: 36),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    const items = <(IconData, String)>[
      (Icons.checkroom_rounded, '패션'),
      (Icons.headphones_rounded, '디지털'),
      (Icons.chair_alt_rounded, '라이프'),
      (Icons.camera_alt_outlined, '빈티지'),
      (Icons.spa_outlined, '뷰티'),
    ];
    return SizedBox(
      height: 108,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () => onSelectTab(1),
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              width: 66,
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: NomadTheme.softGreen,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item.$1, color: NomadTheme.brand, size: 23),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    item.$2,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemCount: items.length,
      ),
    );
  }

  Widget _sectionHeader({
    required String title,
    required String subtitle,
    required String action,
    required VoidCallback onAction,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 12, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              ],
            ),
          ),
          TextButton(onPressed: onAction, child: Text(action)),
        ],
      ),
    );
  }

  void _openProduct(BuildContext context, MarketplaceItem item) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ProductDetailScreen(item: item)),
    );
  }
}
