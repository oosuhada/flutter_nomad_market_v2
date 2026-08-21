import 'package:flutter/material.dart';

import '../theme/nomad_theme.dart';
import '../v2/v2_glass.dart';

class TravelerProfileCard extends StatelessWidget {
  const TravelerProfileCard({
    super.key,
    required this.name,
    required this.route,
    required this.specialty,
    required this.trust,
    required this.deals,
    required this.onChat,
  });

  final String name;
  final String route;
  final String specialty;
  final String trust;
  final int deals;
  final VoidCallback onChat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: SizedBox(
        width: 260,
        child: AppGlassSurface(
          borderRadius: BorderRadius.circular(22),
          blurSigma: 10,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: NomadTheme.softGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person_rounded,
                        color: NomadTheme.brand),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.verified_rounded,
                                size: 16, color: NomadTheme.brand),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(route,
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: NomadTheme.warm,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  specialty,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '신뢰도 $trust · 거래 완료 $deals건',
                style: const TextStyle(
                  color: NomadTheme.brand,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onChat,
                  icon: const Icon(Icons.chat_bubble_outline_rounded, size: 17),
                  label: const Text('구매 요청 상담'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
