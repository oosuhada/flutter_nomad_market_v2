import 'package:flutter/material.dart';

import '../data/demo_marketplace_data.dart';
import '../theme/nomad_theme.dart';
import '../v2/v2_glass.dart';
import '../widgets/marketplace_image.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      (
        demoMarketplaceItems[0],
        'Sarah Kim',
        '9/2 서울 도착',
        '매장 재고 다시 확인했어요. 한정 컬러 맞습니다.',
        '방금'
      ),
      (
        demoMarketplaceItems[1],
        'Mina Park',
        '8/29 김포 도착',
        '시부야 플래그십에서 오늘 픽업 가능해요.',
        '12분'
      ),
      (
        demoMarketplaceItems[3],
        'Luca Han',
        '9/6 인천 도착',
        'Tax refund 포함 가격으로 계산해서 보내드릴게요.',
        '1시간'
      ),
    ];
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      itemCount: chats.length,
      separatorBuilder: (_, __) => const SizedBox(height: 9),
      itemBuilder: (context, index) {
        final chat = chats[index];
        return AppGlassSurface(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ChatScreen()),
          ),
          semanticLabel: '${chat.$2} 구매 요청 메시지',
          surfaceOpacity: .64,
          blurSigma: 15,
          borderRadius: BorderRadius.circular(18),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              MarketplaceImage(
                url: chat.$1.imageUrl,
                width: 62,
                height: 62,
                borderRadius: BorderRadius.circular(14),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(chat.$2,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w800)),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.verified_rounded,
                            size: 15, color: NomadTheme.brand),
                        const Spacer(),
                        Text(chat.$5,
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey.shade500)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(chat.$3,
                        style: const TextStyle(
                            fontSize: 10,
                            color: NomadTheme.brand,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 5),
                    Text(chat.$4,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade700)),
                    const SizedBox(height: 4),
                    Text(chat.$1.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w700)),
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
