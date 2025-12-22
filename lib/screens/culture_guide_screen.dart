import 'package:flutter/material.dart';

import '../theme/nomad_theme.dart';
import '../v2/v2_glass.dart';

class CultureGuideScreen extends StatelessWidget {
  const CultureGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '문화 가이드',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCultureGuideSection(
            title: '국가별 쇼핑 에티켓',
            items: [
              '프랑스 쇼핑 문화와 예절',
              '이탈리아 부티크 방문 시 주의사항',
              '일본 백화점 이용 가이드',
            ],
          ),
          const SizedBox(height: 24),
          _buildCultureGuideSection(
            title: '현지 트렌드 리포트',
            items: [
              '2026 파리 쇼핑 시즌 리포트',
              '밀라노 스트리트 패션 분석',
              '도쿄 한정판 플래그십 가이드',
            ],
          ),
          const SizedBox(height: 24),
          _buildTrendCalendar(),
        ],
      ),
    );
  }

  Widget _buildCultureGuideSection({
    required String title,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...items.map((item) => _buildGuideItem(item)),
      ],
    );
  }

  Widget _buildGuideItem(String title) {
    return AppGlassSurface(
      surfaceOpacity: .64,
      blurSigma: 15,
      borderRadius: BorderRadius.circular(18),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: NomadTheme.softGreen.withValues(alpha: .74),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.public_rounded,
              color: NomadTheme.brand, size: 19),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () {},
      ),
    );
  }

  Widget _buildTrendCalendar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '시즌별 특별 상품 캘린더',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        AppGlassSurface(
          surfaceOpacity: .66,
          blurSigma: 16,
          borderRadius: BorderRadius.circular(22),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildCalendarItem(
                month: '12월',
                title: '연말 시즌 세일',
                description: '유럽 주요 도시 크리스마스 마켓',
              ),
              const Divider(),
              _buildCalendarItem(
                month: '1월',
                title: '겨울 시즌 세일',
                description: '프랑스 솔드 시즌',
              ),
              const Divider(),
              _buildCalendarItem(
                month: '2월',
                title: '밸런타인 특집',
                description: '초콜릿 & 주얼리 프로모션',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarItem({
    required String month,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: AppGlassSurface(
              tint: NomadTheme.softGreen,
              surfaceOpacity: .7,
              blurSigma: 10,
              borderRadius: BorderRadius.circular(12),
              child: Center(
                child: Text(
                  month,
                  style: const TextStyle(
                    color: NomadTheme.brand,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
