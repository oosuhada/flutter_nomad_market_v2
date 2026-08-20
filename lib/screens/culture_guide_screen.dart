import 'package:flutter/material.dart';

class CultureGuideScreen extends StatelessWidget {
  const CultureGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '문화 가이드',
          style: TextStyle(color: Colors.black),
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
              '2024 파리 패션 트렌드',
              '밀라노 스트리트 패션 분석',
              '런던 빈티지 숍 탐방기',
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
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
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
        Card(
          child: Padding(
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
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                month,
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.bold,
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
