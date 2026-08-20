import 'package:flutter/material.dart';

import '../data/demo_marketplace_data.dart';
import '../theme/nomad_theme.dart';
import '../widgets/marketplace_image.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('커뮤니티',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              Text('여행자와 현지인의 진짜 로컬 정보',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400)),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit_square)),
            const SizedBox(width: 8),
          ],
          bottom: const TabBar(
            tabs: [Tab(text: 'LIVE'), Tab(text: '스토리'), Tab(text: '로컬 팁')],
            dividerHeight: 1,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
          ),
        ),
        body: TabBarView(
          children: [
            _LiveTab(),
            _StoriesTab(),
            _TipsTab(),
          ],
        ),
      ),
    );
  }
}

class _LiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = demoMarketplaceItems.take(4).toList();
    const liveTitles = [
      '파리 백화점 한정 컬러\n실물 체크',
      '도쿄 플래그십 한정판\n재고 확인',
      '성수 K-뷰티 쇼룸\n신상 같이 보기',
      '밀라노 리미티드 월렛\n현장 체크',
    ];
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 18,
        childAspectRatio: .72,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  MarketplaceImage(
                      url: item.imageUrl,
                      borderRadius: BorderRadius.circular(18)),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(999)),
                      child: const Text('● LIVE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w900)),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: 10,
                    child: Text(
                      liveTitles[index],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.2,
                          fontWeight: FontWeight.w800,
                          shadows: [
                            Shadow(blurRadius: 8, color: Colors.black)
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(item.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 10,
                    color: NomadTheme.brand,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text('${350 + index * 187}명 시청 중',
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
          ],
        );
      },
    );
  }
}

class _StoriesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const stories = [
      ('파리 한정 컬러를 살 때 꼭 확인하는 세 가지', 'Sarah Kim · Paris', 0),
      ('성수 인디 K-뷰티 쇼룸을 고르는 기준', 'Joon Lee · Seoul', 2),
      ('밀라노 편집숍 세일 시즌 체크리스트', 'Luca Han · Milano', 3),
    ];
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      itemCount: stories.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final story = stories[index];
        final item = demoMarketplaceItems[story.$3];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              MarketplaceImage(
                  url: item.imageUrl,
                  width: 102,
                  height: 118,
                  borderRadius: BorderRadius.circular(15)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('LOCAL STORY',
                        style: TextStyle(
                            fontSize: 9,
                            letterSpacing: .8,
                            fontWeight: FontWeight.w900,
                            color: NomadTheme.brand)),
                    const SizedBox(height: 7),
                    Text(story.$1,
                        style: const TextStyle(
                            fontSize: 16,
                            height: 1.3,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(height: 10),
                    Text(story.$2,
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade600)),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.favorite_border_rounded, size: 15),
                        SizedBox(width: 4),
                        Text('좋아요 84', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TipsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const tips = [
      (
        Icons.currency_exchange_rounded,
        '환율보다 먼저 확인할 것',
        '카드 수수료와 택스 리펀드 조건을 같이 비교하세요.'
      ),
      (
        Icons.inventory_2_outlined,
        '기내 반입 체크',
        '전자기기와 액체류는 판매 전에 운송 조건을 확인하면 좋아요.'
      ),
      (
        Icons.verified_user_outlined,
        '안전한 직거래 장소',
        '사람이 많은 공개 장소에서 상품 상태를 함께 확인하세요.'
      ),
      (
        Icons.translate_rounded,
        '현지 판매자와 대화하기',
        '가격보다 상태·구성품·구매 시점을 먼저 확인해보세요.'
      ),
    ];
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: tips.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final tip = tips[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                    color: NomadTheme.softGreen, shape: BoxShape.circle),
                child: Icon(tip.$1, color: NomadTheme.brand, size: 21),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tip.$2,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 5),
                    Text(tip.$3,
                        style: TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            color: Colors.grey.shade700)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
