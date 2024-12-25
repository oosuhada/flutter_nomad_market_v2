// screens/my_page_screen.dart
import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildProfileSection(),
        _buildStatusSection(),
        const Divider(height: 1),
        _buildMenuSection(),
        const SizedBox(height: 8),
        _buildSafetySection(),
        const SizedBox(height: 8),
        _buildSettingsSection(),
      ],
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(Icons.person, size: 40),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Sarah Kim',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.verified, color: Colors.blue, size: 20),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '파리, 프랑스',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '럭셔리 쇼핑 전문가',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProfileStat('거래 완료', '32'),
                const VerticalDivider(thickness: 1),
                _buildProfileStat('신뢰도', '98%'),
                const VerticalDivider(thickness: 1),
                _buildProfileStat('리뷰', '28'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '현재 진행중',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatusItem(
                  icon: Icons.shopping_bag,
                  title: '구매 요청',
                  count: '2',
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatusItem(
                  icon: Icons.local_shipping,
                  title: '배송중',
                  count: '1',
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatusItem(
                  icon: Icons.chat_bubble,
                  title: '채팅',
                  count: '5',
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem({
    required IconData icon,
    required String title,
    required String count,
    required MaterialColor color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color[700]),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: color[700],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: TextStyle(
              color: color[700],
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.shopping_bag_outlined,
            title: '구매 내역',
            subtitle: '진행중인 구매와 과거 거래 내역',
          ),
          _buildMenuItem(
            icon: Icons.favorite_border,
            title: '관심 상품',
            subtitle: '찜한 상품 모아보기',
            badgeCount: '12',
          ),
          _buildMenuItem(
            icon: Icons.calendar_today,
            title: '여행 일정',
            subtitle: '구매 요청 및 픽업 일정 관리',
          ),
          _buildMenuItem(
            icon: Icons.card_giftcard,
            title: '리워드',
            subtitle: '포인트 및 쿠폰 확인',
            isNew: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSafetySection() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.verified_user_outlined,
            title: '안전 거래 센터',
            subtitle: '거래 보호 및 분쟁 해결',
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.settings_outlined,
            title: '설정',
            subtitle: '앱 설정 및 개인정보 관리',
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    String? badgeCount,
    bool isNew = false,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black87),
          title: Row(
            children: [
              Text(title),
              const SizedBox(width: 8),
              if (isNew)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'NEW',
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (badgeCount != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badgeCount,
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          trailing:
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          onTap: () {
            // 각 메뉴 아이템별 네비게이션 처리
          },
        ),
        if (showDivider) const Divider(height: 1),
      ],
    );
  }
}
