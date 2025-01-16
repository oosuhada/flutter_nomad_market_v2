import 'package:flutter/material.dart';

import '../models/marketplace_item.dart';
import '../theme/nomad_theme.dart';
import '../widgets/marketplace_image.dart';
import 'chat_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
    required this.item,
  });

  final MarketplaceItem item;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _favorite = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 390,
            backgroundColor: Colors.white,
            foregroundColor: NomadTheme.ink,
            leading: _roundAppBarButton(
              icon: Icons.arrow_back_rounded,
              onTap: () => Navigator.of(context).pop(),
            ),
            actions: [
              _roundAppBarButton(icon: Icons.ios_share_rounded, onTap: () {}),
              const SizedBox(width: 8),
              _roundAppBarButton(
                icon: _favorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                iconColor: _favorite ? Colors.redAccent : NomadTheme.ink,
                onTap: () => setState(() => _favorite = !_favorite),
              ),
              const SizedBox(width: 12),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  MarketplaceImage(url: item.imageUrl),
                  Positioned(
                    left: 20,
                    bottom: 18,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: NomadTheme.ink.withValues(alpha: .82),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified_rounded, color: Color(0xFF8DD2C4), size: 15),
                          SizedBox(width: 5),
                          Text(
                            '현지 사진 · 상태 확인',
                            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                        decoration: BoxDecoration(
                          color: NomadTheme.softGreen,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          item.category,
                          style: const TextStyle(color: NomadTheme.brand, fontSize: 11, fontWeight: FontWeight.w800),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${item.timeAgo} · 관심 ${item.likes}',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 24,
                      height: 1.25,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.formattedPrice,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: -.4),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 18, color: NomadTheme.brand),
                      const SizedBox(width: 5),
                      Text(item.location, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                      const SizedBox(width: 10),
                      Container(width: 3, height: 3, decoration: BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle)),
                      const SizedBox(width: 10),
                      Text('직거래 · 이동 일정 협의', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _sellerCard(item),
                  const SizedBox(height: 28),
                  const Text('상품 설명', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  Text(
                    item.description,
                    style: const TextStyle(fontSize: 15, height: 1.65, color: Color(0xFF3C4744)),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: item.tags.map(_buildTag).toList(),
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 22),
                  const Text('Nomad Safe Deal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 14),
                  const Row(
                    children: [
                      Expanded(child: _TrustPoint(icon: Icons.photo_camera_back_outlined, label: '실물 사진')),
                      Expanded(child: _TrustPoint(icon: Icons.chat_bubble_outline_rounded, label: '앱 내 문의')),
                      Expanded(child: _TrustPoint(icon: Icons.verified_user_outlined, label: '거래 보호')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 11, 16, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Row(
            children: [
              IconButton.filledTonal(
                onPressed: () => setState(() => _favorite = !_favorite),
                icon: Icon(_favorite ? Icons.favorite_rounded : Icons.favorite_border_rounded),
                style: IconButton.styleFrom(minimumSize: const Size(52, 52)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ChatScreen()),
                  ),
                  icon: const Icon(Icons.chat_bubble_outline_rounded, size: 19),
                  label: const Text('판매자에게 문의하기', style: TextStyle(fontWeight: FontWeight.w800)),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roundAppBarButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = NomadTheme.ink,
  }) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Material(
        color: Colors.white.withValues(alpha: .92),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(width: 42, height: 42, child: Icon(icon, color: iconColor, size: 21)),
        ),
      ),
    );
  }

  Widget _sellerCard(MarketplaceItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: NomadTheme.canvas,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE4E8E5)),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(color: NomadTheme.softGreen, shape: BoxShape.circle),
            child: const Icon(Icons.person_rounded, color: NomadTheme.brand, size: 28),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(item.sellerName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800), overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.verified_rounded, color: NomadTheme.brand, size: 18),
                  ],
                ),
                const SizedBox(height: 3),
                Text(item.sellerLocation, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                const SizedBox(height: 7),
                Text(
                  '★ ${item.sellerRating.toStringAsFixed(1)}  ·  거래 ${item.sellerDeals}회  ·  응답 빠름',
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: NomadTheme.brand),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Colors.black45),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(color: NomadTheme.warm, borderRadius: BorderRadius.circular(10)),
      child: Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }
}

class _TrustPoint extends StatelessWidget {
  const _TrustPoint({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(color: NomadTheme.softGreen, shape: BoxShape.circle),
          child: Icon(icon, color: NomadTheme.brand, size: 21),
        ),
        const SizedBox(height: 7),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
