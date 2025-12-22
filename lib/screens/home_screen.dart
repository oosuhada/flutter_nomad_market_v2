import 'package:flutter/material.dart';

import '../data/demo_marketplace_data.dart';
import '../models/marketplace_item.dart';
import '../theme/nomad_theme.dart';
import '../v2/v2_glass.dart';
import '../widgets/cultural_insight_card.dart';
import '../widgets/local_trend_card.dart';
import '../widgets/product_card.dart';
import '../widgets/traveler_profile_card.dart';
import 'chat_list_screen.dart';
import 'chat_screen.dart';
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
      const MarketplaceHomeScreen(),
      const CommunityScreen(),
      const _ChatTab(),
      const MyPageScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: AppGlassNavigationBar(
        selectedIndex: _selectedIndex,
        onSelected: (index) => setState(() => _selectedIndex = index),
        items: const [
          AppGlassNavItem(
            icon: Icons.shopping_bag_outlined,
            selectedIcon: Icons.shopping_bag_rounded,
            label: '쇼핑',
          ),
          AppGlassNavItem(
            icon: Icons.explore_outlined,
            selectedIcon: Icons.explore_rounded,
            label: '커뮤니티',
          ),
          AppGlassNavItem(
            icon: Icons.chat_bubble_outline_rounded,
            selectedIcon: Icons.chat_bubble_rounded,
            label: '채팅',
          ),
          AppGlassNavItem(
            icon: Icons.person_outline_rounded,
            selectedIcon: Icons.person_rounded,
            label: '마이',
          ),
        ],
      ),
    );
  }
}

class MarketplaceHomeScreen extends StatelessWidget {
  const MarketplaceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _header(context)),
            SliverToBoxAdapter(child: _search(context)),
            SliverToBoxAdapter(child: _hero(context)),
            SliverToBoxAdapter(child: _categories(context)),
            SliverToBoxAdapter(
              child: _sectionHeader(
                title: '이번 주 도착하는 현지 픽',
                subtitle: '여행자가 실물을 확인하고 한국까지 연결해요',
                action: '전체 보기',
                onAction: () => _openSearch(context),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = demoMarketplaceItems[index];
                    return ProductCard(
                      item: item,
                      onTap: () => _openProduct(context, item),
                    );
                  },
                  childCount: 4,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 22,
                  childAspectRatio: .58,
                ),
              ),
            ),
            SliverToBoxAdapter(child: _localTrends(context)),
            SliverToBoxAdapter(child: _travelers(context)),
            SliverToBoxAdapter(child: _culture(context)),
            const SliverToBoxAdapter(child: SizedBox(height: 28)),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 82),
        child: AppGlassActionButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CreateListingScreen()),
          ),
          icon: Icons.flight_takeoff_rounded,
          label: '현지 상품 등록',
          semanticLabel: '현지 상품 등록 화면 열기',
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
      child: AppGlassSurface(
        borderRadius: BorderRadius.circular(22),
        blurSigma: 16,
        surfaceOpacity: .48,
        padding: const EdgeInsets.fromLTRB(18, 14, 10, 14),
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
                      const Icon(Icons.flight_rounded,
                          size: 18, color: NomadTheme.ink),
                      const SizedBox(width: 6),
                      Text('Paris → Seoul',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(width: 5),
                      const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '이번 주 한국에 들어오는 여행자 18명',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
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
      ),
    );
  }

  Widget _search(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: AppGlassSearchButton(
        hint: '도시, 한정판, K-뷰티를 찾아보세요',
        onTap: () => _openSearch(context),
        trailing: const Icon(
          Icons.travel_explore_rounded,
          size: 21,
          color: NomadTheme.brand,
        ),
      ),
    );
  }

  Widget _hero(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppGlassSurface(
        tint: NomadTheme.ink,
        surfaceOpacity: .82,
        blurSigma: 22,
        borderRadius: BorderRadius.circular(24),
        padding: const EdgeInsets.all(22),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SHOP LOCAL · CARRY GLOBAL',
                    style: TextStyle(
                      color: Color(0xFF8DD2C4),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: .9,
                    ),
                  ),
                  SizedBox(height: 9),
                  Text(
                    '현지인처럼 쇼핑하세요',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      height: 1.28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -.4,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '세계 여행자를 내 퍼스널 쇼퍼로',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '실물 확인 · 구매 요청 · 이동 일정 · 안전거래',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 72,
              height: 72,
              child: AppGlassSurface(
                tint: NomadTheme.brand,
                surfaceOpacity: .78,
                blurSigma: 16,
                borderRadius: BorderRadius.circular(36),
                child: const Icon(Icons.luggage_rounded,
                    color: Colors.white, size: 34),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categories(BuildContext context) {
    const items = <(IconData, String)>[
      (Icons.diamond_outlined, '럭셔리'),
      (Icons.auto_awesome_rounded, '한정판'),
      (Icons.spa_outlined, 'K-뷰티'),
      (Icons.headphones_rounded, '디지털'),
      (Icons.camera_alt_outlined, '빈티지'),
    ];
    return SizedBox(
      height: 108,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (context, index) {
          final item = items[index];
          return SizedBox(
            width: 76,
            child: AppGlassSurface(
              onTap: () => _openSearch(context, category: item.$2),
              semanticLabel: item.$2,
              surfaceOpacity: .58,
              blurSigma: 14,
              borderRadius: BorderRadius.circular(20),
              padding: const EdgeInsets.fromLTRB(8, 9, 8, 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: NomadTheme.softGreen.withValues(alpha: .72),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: .72),
                      ),
                    ),
                    child: Icon(item.$1, color: NomadTheme.brand, size: 20),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.$2,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 10.5, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _localTrends(BuildContext context) {
    final trends = [
      (
        'PARIS · SOLDES',
        '백화점 시즌오프 시작',
        '럭셔리 액세서리 현지 가격이 내려갔어요',
        demoMarketplaceItems[0].imageUrl
      ),
      (
        'TOKYO · SHIBUYA',
        '플래그십 한정 컬러',
        '주말 재고가 빠르게 줄고 있어요',
        demoMarketplaceItems[1].imageUrl
      ),
      (
        'SEOUL · SEONGSU',
        '인디 K-뷰티 쇼룸',
        '해외 여행자 요청이 많은 로컬 브랜드',
        demoMarketplaceItems[2].imageUrl
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: '실시간 현지 트렌드',
          subtitle: '원래 Nomad Market의 로컬 쇼핑 맥락을 그대로',
          action: '문화 가이드',
          onAction: () => Navigator.of(context).pushNamed('/culture-guide'),
        ),
        SizedBox(
          height: 205,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            itemCount: trends.length,
            itemBuilder: (_, index) {
              final trend = trends[index];
              return LocalTrendCard(
                city: trend.$1,
                title: trend.$2,
                caption: trend.$3,
                imageUrl: trend.$4,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _travelers(BuildContext context) {
    final travelers = [
      ('Sarah Kim', 'Paris → Seoul · 9/2', '럭셔리 · 빈티지', '98%', 32),
      ('Mina Park', 'Tokyo → Seoul · 8/29', '한정판 · 디지털', '96%', 18),
      ('Luca Han', 'Milano → Seoul · 9/6', '패션 · 편집숍', '94%', 12),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: '추천 현지 전문가',
          subtitle: '도시를 잘 아는 여행자에게 구매를 요청해보세요',
          action: '채팅 시작',
          onAction: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const ChatScreen())),
        ),
        SizedBox(
          height: 210,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            itemCount: travelers.length,
            itemBuilder: (_, index) {
              final traveler = travelers[index];
              return TravelerProfileCard(
                name: traveler.$1,
                route: traveler.$2,
                specialty: traveler.$3,
                trust: traveler.$4,
                deals: traveler.$5,
                onChat: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ChatScreen())),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _culture(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: '현지 문화 인사이트',
          subtitle: '가격만이 아니라 그 도시의 쇼핑 방식까지',
          action: '전체 보기',
          onAction: () => Navigator.of(context).pushNamed('/culture-guide'),
        ),
        SizedBox(
          height: 225,
          child: ListView(
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            children: [
              CulturalInsightCard(
                city: 'PARIS SHOPPING CULTURE',
                title: '솔드 시즌에 현명하게 쇼핑하는 법',
                caption: '세일 표기와 Tax refund, 부티크 방문 에티켓을 한 번에 정리했어요.',
                imageUrl: demoMarketplaceItems[0].imageUrl,
                onTap: () => Navigator.of(context).pushNamed('/culture-guide'),
              ),
              const SizedBox(width: 12),
              CulturalInsightCard(
                city: 'TOKYO LOCAL GUIDE',
                title: '한정판 재고를 찾는 시간대',
                caption: '시부야·하라주쿠 플래그십을 돌 때 알아두면 좋은 현지 팁.',
                imageUrl: demoMarketplaceItems[1].imageUrl,
                onTap: () => Navigator.of(context).pushNamed('/culture-guide'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader({
    required String title,
    required String subtitle,
    required String action,
    required VoidCallback onAction,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 12, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -.3)),
                const SizedBox(height: 3),
                Text(subtitle,
                    style:
                        TextStyle(fontSize: 11, color: Colors.grey.shade600)),
              ],
            ),
          ),
          TextButton(onPressed: onAction, child: Text(action)),
        ],
      ),
    );
  }

  void _openSearch(BuildContext context, {String? category}) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => SearchScreen(initialCategory: category)),
    );
  }

  void _openProduct(BuildContext context, MarketplaceItem item) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ProductDetailScreen(item: item)));
  }
}

class _ChatTab extends StatelessWidget {
  const _ChatTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('구매 요청',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            Text('현지 전문가와 이어서 이야기하세요',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
      body: const ChatListScreen(),
    );
  }
}
