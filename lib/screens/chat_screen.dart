import 'package:flutter/material.dart';

import '../data/demo_marketplace_data.dart';
import '../theme/nomad_theme.dart';
import '../v2/v2_glass.dart';
import '../widgets/marketplace_image.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final List<String> _sentMessages = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = demoMarketplaceItems.first;
    return Scaffold(
      backgroundColor: NomadTheme.canvas,
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                  color: NomadTheme.softGreen, shape: BoxShape.circle),
              child: const Icon(Icons.person_rounded,
                  color: NomadTheme.brand, size: 22),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Sarah Kim',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800)),
                      SizedBox(width: 4),
                      Icon(Icons.verified_rounded,
                          size: 16, color: NomadTheme.brand),
                    ],
                  ),
                  SizedBox(height: 1),
                  Text('보통 10분 내 응답',
                      style: TextStyle(fontSize: 10, color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded)),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
              child: AppGlassSurface(
                surfaceOpacity: .78,
                blurSigma: 14,
                borderRadius: BorderRadius.circular(20),
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Row(
                  children: [
                    MarketplaceImage(
                      url: item.imageUrl,
                      width: 58,
                      height: 58,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text(item.formattedPrice,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w900)),
                          const SizedBox(height: 2),
                          Text(item.location,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(onPressed: () {}, child: const Text('거래 제안')),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                children: [
                  Center(
                    child: AppGlassSurface(
                      surfaceOpacity: .76,
                      blurSigma: 10,
                      borderRadius: BorderRadius.circular(999),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      child: const Text('오늘 · 안전거래 채팅',
                          style:
                              TextStyle(fontSize: 10, color: Colors.black54)),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const _MessageBubble(
                    message: '안녕하세요! 사진 속 레더 토트 아직 거래 가능한가요?',
                    time: '오후 2:30',
                    isMine: true,
                  ),
                  const _MessageBubble(
                    message:
                        '네, 가능해요. 오늘 르 마레에서 상태를 한 번 더 확인했고 내부 오염도 거의 없습니다.',
                    time: '오후 2:32',
                    isMine: false,
                  ),
                  const _MessageBubble(
                    message: '서울 도착은 언제쯤이세요? 성수에서 직거래하고 싶어요.',
                    time: '오후 2:34',
                    isMine: true,
                  ),
                  const _MessageBubble(
                    message:
                        '금요일 저녁 도착 예정이에요. 토요일 오후 성수에서 가능합니다. 원하시면 추가 사진도 보내드릴게요.',
                    time: '오후 2:36',
                    isMine: false,
                  ),
                  ..._sentMessages.map(
                    (message) => _MessageBubble(
                        message: message, time: '방금', isMine: true),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 8),
              child: AppGlassSurface(
                surfaceOpacity: .82,
                blurSigma: 16,
                borderRadius: BorderRadius.circular(22),
                padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_circle_outline_rounded),
                        color: Colors.black54),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        minLines: 1,
                        maxLines: 4,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _send(),
                        decoration: const InputDecoration(
                          hintText: '메시지를 입력하세요',
                          isDense: true,
                          filled: false,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    AppGlassIconButton(
                      onPressed: _send,
                      icon: Icons.arrow_upward_rounded,
                      iconColor: NomadTheme.brand,
                      semanticLabel: '메시지 보내기',
                      size: 44,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _send() {
    final message = _controller.text.trim();
    if (message.isEmpty) return;
    setState(() => _sentMessages.add(message));
    _controller.clear();
    FocusScope.of(context).unfocus();
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.time,
    required this.isMine,
  });

  final String message;
  final String time;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * .76),
        child: AppGlassSurface(
          margin: const EdgeInsets.only(bottom: 11),
          tint: isMine ? NomadTheme.brand : Colors.white,
          surfaceOpacity: isMine ? .88 : .82,
          blurSigma: 12,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(17),
            topRight: const Radius.circular(17),
            bottomLeft: Radius.circular(isMine ? 17 : 5),
            bottomRight: Radius.circular(isMine ? 5 : 17),
          ),
          padding: const EdgeInsets.fromLTRB(13, 10, 13, 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message,
                style: TextStyle(
                    color: isMine ? Colors.white : NomadTheme.ink,
                    fontSize: 13,
                    height: 1.45),
              ),
              const SizedBox(height: 4),
              Text(time,
                  style: TextStyle(
                      color: isMine ? Colors.white70 : Colors.black45,
                      fontSize: 9)),
            ],
          ),
        ),
      ),
    );
  }
}
