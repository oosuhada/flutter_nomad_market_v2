import 'package:flutter/material.dart';

import '../data/demo_marketplace_data.dart';
import '../theme/nomad_theme.dart';
import '../widgets/marketplace_image.dart';
import 'chat_list_screen.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이 Nomad',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          children: [
            _profileCard(),
            const SizedBox(height: 14),
            _tradeSummary(),
            const SizedBox(height: 14),
            _nextTripCard(),
            const SizedBox(height: 28),
            _sectionTitle('내 현지 픽', action: '전체 보기'),
            const SizedBox(height: 12),
            _myListings(),
            const SizedBox(height: 28),
            _sectionTitle('구매 요청 & 여행'),
            const SizedBox(height: 10),
            _menuTile(
              context,
              icon: Icons.favorite_border_rounded,
              title: '관심 현지 픽',
              subtitle: '다음 여행 전에 다시 볼 아이템 12개',
              badge: '12',
            ),
            _menuTile(
              context,
              icon: Icons.chat_bubble_outline_rounded,
              title: '구매 요청 메시지',
              subtitle: '현지 전문가와 재고·실물 확인을 이어보세요',
              badge: '3',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(
                        title: const Text('구매 요청 메시지',
                            style: TextStyle(fontWeight: FontWeight.w800))),
                    body: const ChatListScreen(),
                  ),
                ),
              ),
            ),
            _menuTile(
              context,
              icon: Icons.public_rounded,
              title: '여행 & 문화 가이드',
              subtitle: '현지에서 알아두면 좋은 거래 문화',
              onTap: () => Navigator.of(context).pushNamed('/culture-guide'),
            ),
            _menuTile(
              context,
              icon: Icons.verified_user_outlined,
              title: '안전 거래 센터',
              subtitle: '거래 보호 원칙과 도움말',
              onTap: () => Navigator.of(context).pushNamed('/safety-center'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: NomadTheme.ink, borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: const BoxDecoration(
                color: NomadTheme.brand, shape: BoxShape.circle),
            child:
                const Icon(Icons.person_rounded, color: Colors.white, size: 34),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text('Sarah Kim',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800)),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.verified_rounded,
                        color: Color(0xFF8DD2C4), size: 19),
                  ],
                ),
                SizedBox(height: 4),
                Text('Paris ↔ Seoul · 로컬 쇼핑 큐레이터',
                    style: TextStyle(color: Colors.white70, fontSize: 11)),
                SizedBox(height: 9),
                Text('신뢰도 98%  ·  ★ 4.9  ·  거래 32회',
                    style: TextStyle(
                        color: Color(0xFF8DD2C4),
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Colors.white70),
        ],
      ),
    );
  }

  Widget _tradeSummary() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: const Row(
        children: [
          Expanded(child: _Stat(value: '4', label: '활동 도시')),
          SizedBox(height: 34, child: VerticalDivider()),
          Expanded(child: _Stat(value: '12', label: '관심')),
          SizedBox(height: 34, child: VerticalDivider()),
          Expanded(child: _Stat(value: '2', label: '요청중')),
          SizedBox(height: 34, child: VerticalDivider()),
          Expanded(child: _Stat(value: '32', label: '요청 완료')),
        ],
      ),
    );
  }

  Widget _nextTripCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: NomadTheme.warm, borderRadius: BorderRadius.circular(20)),
      child: const Row(
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: DecoratedBox(
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child:
                  Icon(Icons.flight_takeoff_rounded, color: NomadTheme.brand),
            ),
          ),
          SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('다음 이동 일정',
                    style: TextStyle(
                        fontSize: 11,
                        color: NomadTheme.brand,
                        fontWeight: FontWeight.w800)),
                SizedBox(height: 3),
                Text('Paris → Seoul · 9월 2일',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w900)),
                SizedBox(height: 2),
                Text('구매 요청 2건 · 전달 일정 3건',
                    style: TextStyle(fontSize: 10, color: Colors.black54)),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }

  Widget _myListings() {
    final items = [demoMarketplaceItems[0], demoMarketplaceItems[2]];
    return SizedBox(
      height: 126,
      child: Row(
        children: items.map((item) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: item == items.first ? 10 : 0),
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(18)),
              child: Row(
                children: [
                  MarketplaceImage(
                      url: item.imageUrl,
                      width: 78,
                      height: 106,
                      borderRadius: BorderRadius.circular(13)),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                              color: NomadTheme.softGreen,
                              borderRadius: BorderRadius.circular(999)),
                          child: const Text('요청 가능',
                              style: TextStyle(
                                  fontSize: 8,
                                  color: NomadTheme.brand,
                                  fontWeight: FontWeight.w800)),
                        ),
                        const SizedBox(height: 6),
                        Text(item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 11,
                                height: 1.25,
                                fontWeight: FontWeight.w700)),
                        const SizedBox(height: 5),
                        Text(item.formattedPrice,
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _sectionTitle(String title, {String? action}) {
    return Row(
      children: [
        Expanded(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w800))),
        if (action != null)
          Text(action,
              style: const TextStyle(
                  fontSize: 11,
                  color: NomadTheme.brand,
                  fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _menuTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    String? badge,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: onTap ?? () {},
        leading: Container(
          width: 42,
          height: 42,
          decoration: const BoxDecoration(
              color: NomadTheme.softGreen, shape: BoxShape.circle),
          child: Icon(icon, color: NomadTheme.brand, size: 20),
        ),
        title: Text(title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
        subtitle: Text(subtitle,
            style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
        trailing: badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                    color: NomadTheme.warm,
                    borderRadius: BorderRadius.circular(999)),
                child: Text(badge,
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w800)),
              )
            : const Icon(Icons.chevron_right_rounded, color: Colors.black38),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.black54)),
      ],
    );
  }
}
