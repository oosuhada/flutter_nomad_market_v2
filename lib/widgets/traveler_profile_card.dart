// widgets/traveler_profile_card.dart
import 'package:flutter/material.dart';

class TravelerProfileCard extends StatelessWidget {
  const TravelerProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 24,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.verified,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sarah Kim',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '파리, 프랑스',
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
            const SizedBox(height: 12),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                _buildBadge('럭셔리 전문가', Colors.amber),
                _buildBadge('3년 경력', Colors.blue),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '신뢰도 98%',
              style: TextStyle(
                color: Colors.green[600],
                fontSize: 12,
              ),
            ),
            const Text(
              '거래 완료 32건',
              style: TextStyle(fontSize: 12),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('채팅하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text, MaterialColor color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color[700],
          fontSize: 10,
        ),
      ),
    );
  }
}
