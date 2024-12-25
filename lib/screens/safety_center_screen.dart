// screens/safety_center_screen.dart
import 'package:flutter/material.dart';

class SafetyCenterScreen extends StatelessWidget {
  const SafetyCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '안전 거래 센터',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.black),
            onPressed: () {
              // 도움말 페이지로 이동
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSafetyStatus(),
          const SizedBox(height: 24),
          _buildTrackingSection(),
          const SizedBox(height: 24),
          _buildCustomsGuide(),
          const SizedBox(height: 24),
          _buildDisputeResolution(),
          const SizedBox(height: 24),
          _buildAuthenticationSystem(),
        ],
      ),
    );
  }

  Widget _buildSafetyStatus() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.verified_user, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  '안전 거래 상태',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatusItem(
                    icon: Icons.shopping_bag,
                    title: '진행중 거래',
                    value: '3건',
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey[300],
                ),
                Expanded(
                  child: _buildStatusItem(
                    icon: Icons.schedule,
                    title: '배송중',
                    value: '1건',
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey[300],
                ),
                Expanded(
                  child: _buildStatusItem(
                    icon: Icons.check_circle,
                    title: '완료',
                    value: '12건',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTrackingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '구매 진행 현황',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                title: const Text(
                  '파리 명품 가방',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      '배송중 • 프랑스 파리 출발',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: 0.7,
                      backgroundColor: Colors.grey[200],
                    ),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // 상세 트래킹 페이지로 이동
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCustomsGuide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '통관/관세 가이드',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              _buildGuideItem(
                icon: Icons.article,
                title: '품목별 관세율 확인',
                subtitle: '의류, 가방, 시계 등 품목별 관세 안내',
              ),
              const Divider(),
              _buildGuideItem(
                icon: Icons.cases_outlined,
                title: '통관 절차 안내',
                subtitle: '해외 직구 통관 과정 상세 설명',
              ),
              const Divider(),
              _buildGuideItem(
                icon: Icons.calculate_outlined,
                title: '관세 계산기',
                subtitle: '예상 관세 금액을 미리 계산해보세요',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGuideItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        // 각 가이드 페이지로 이동
      },
    );
  }

  Widget _buildDisputeResolution() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '분쟁 해결 지원',
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
                Row(
                  children: [
                    Expanded(
                      child: _buildDisputeButton(
                        icon: Icons.report_problem,
                        title: '신고하기',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDisputeButton(
                        icon: Icons.support_agent,
                        title: '상담하기',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue[700]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '구매 확정 전 발생한 문제는 24시간 이내 해결을 도와드립니다',
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
          ),
        ),
      ],
    );
  }

  Widget _buildDisputeButton({
    required IconData icon,
    required String title,
  }) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildAuthenticationSystem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '정품 인증 시스템',
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
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.verified,
                        color: Colors.green[700],
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '전문가 정품 인증',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '모든 상품은 전문가의 철저한 검수를 거칩니다',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      _buildAuthStep(
                        step: '1',
                        title: '구매자 상품 수령',
                        description: '상품 도착 후 개봉 영상 촬영',
                      ),
                      const SizedBox(height: 12),
                      _buildAuthStep(
                        step: '2',
                        title: '전문가 검수',
                        description: '브랜드별 전문가의 진품 감정',
                      ),
                      const SizedBox(height: 12),
                      _buildAuthStep(
                        step: '3',
                        title: '인증서 발급',
                        description: '정품 인증서 디지털 발급',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthStep({
    required String step,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              step,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
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
    );
  }
}
