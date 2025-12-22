import 'package:flutter/material.dart';

import '../models/marketplace_item.dart';
import '../theme/nomad_theme.dart';
import '../v2/v2_glass.dart';
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
      backgroundColor: NomadTheme.canvas,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 390,
            backgroundColor: Colors.transparent,
            foregroundColor: NomadTheme.ink,
            leading: _roundAppBarButton(
              icon: Icons.arrow_back_rounded,
              onTap: () => Navigator.of(context).pop(),
            ),
            actions: [
              _roundAppBarButton(icon: Icons.ios_share_rounded, onTap: () {}),
              const SizedBox(width: 8),
              _roundAppBarButton(
                icon: _favorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
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
                    child: AppGlassSurface(
                      tint: NomadTheme.ink,
                      surfaceOpacity: .7,
                      blurSigma: 12,
                      borderRadius: BorderRadius.circular(999),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified_rounded,
                              color: Color(0xFF8DD2C4), size: 15),
                          SizedBox(width: 5),
                          Text(
                            '현지 사진 · 상태 확인',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700),
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
                      AppGlassSurface(
                        tint: NomadTheme.softGreen,
                        surfaceOpacity: .68,
                        blurSigma: 10,
                        borderRadius: BorderRadius.circular(999),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 5),
                        child: Text(
                          item.category,
                          style: const TextStyle(
                              color: NomadTheme.brand,
                              fontSize: 11,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${item.timeAgo} · 관심 ${item.likes}',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12),
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
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -.4),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 18, color: NomadTheme.brand),
                      const SizedBox(width: 5),
                      Text(item.location,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w700)),
                      const SizedBox(width: 10),
                      Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              shape: BoxShape.circle)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item.requestable ? '현지 구매 요청 가능' : '이동 일정 협의',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  AppGlassSurface(
                    tint: NomadTheme.warm,
                    surfaceOpacity: .72,
                    blurSigma: 14,
                    borderRadius: BorderRadius.circular(18),
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        _infoRow(Icons.storefront_outlined, '현지 소싱',
                            item.sourceLabel),
                        const SizedBox(height: 10),
                        _infoRow(Icons.flight_land_rounded, '이동 일정',
                            item.deliveryNote),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _sellerCard(item),
                  const SizedBox(height: 28),
                  const Text('상품 설명',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  Text(
                    item.description,
                    style: const TextStyle(
                        fontSize: 15, height: 1.65, color: Color(0xFF3C4744)),
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
                  const Text('Nomad Purchase Request',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 14),
                  AppGlassSurface(
                    tint: NomadTheme.softGreen,
                    surfaceOpacity: .68,
                    blurSigma: 12,
                    borderRadius: BorderRadius.circular(20),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: const Row(
                      children: [
                        Expanded(
                            child: _TrustPoint(
                                icon: Icons.photo_camera_back_outlined,
                                label: '현지 실물 확인')),
                        Expanded(
                            child: _TrustPoint(
                                icon: Icons.receipt_long_outlined,
                                label: '구매 정보 공유')),
                        Expanded(
                            child: _TrustPoint(
                                icon: Icons.luggage_outlined,
                                label: '이동 일정 연결')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: AppGlassSurface(
            surfaceOpacity: .80,
            blurSigma: 18,
            borderRadius: BorderRadius.circular(24),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton.filledTonal(
                  onPressed: () => setState(() => _favorite = !_favorite),
                  icon: Icon(_favorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded),
                  style: IconButton.styleFrom(minimumSize: const Size(52, 52)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ChatScreen()),
                    ),
                    icon:
                        const Icon(Icons.chat_bubble_outline_rounded, size: 19),
                    label: const Text('채팅',
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: AppGlassPrimaryButton(
                    onPressed: () => _showPurchaseRequest(context, item),
                    icon: Icons.luggage_rounded,
                    label: '구매 요청하기',
                    tint: NomadTheme.brand,
                  ),
                ),
              ],
            ),
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
      child: AppGlassIconButton(
        icon: icon,
        iconColor: iconColor,
        onPressed: onTap,
        size: 42,
      ),
    );
  }

  Widget _sellerCard(MarketplaceItem item) {
    return AppGlassSurface(
      tint: NomadTheme.canvas,
      surfaceOpacity: .74,
      blurSigma: 16,
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
                color: NomadTheme.softGreen, shape: BoxShape.circle),
            child: const Icon(Icons.person_rounded,
                color: NomadTheme.brand, size: 28),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(item.sellerName,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.verified_rounded,
                        color: NomadTheme.brand, size: 18),
                  ],
                ),
                const SizedBox(height: 3),
                Text(item.sellerLocation,
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                const SizedBox(height: 7),
                Text(
                  '★ ${item.sellerRating.toStringAsFixed(1)}  ·  요청 완료 ${item.sellerDeals}회  ·  응답 빠름',
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: NomadTheme.brand),
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
    return AppGlassSurface(
      tint: NomadTheme.warm,
      surfaceOpacity: .58,
      blurSigma: 10,
      borderRadius: BorderRadius.circular(999),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Text(text,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: NomadTheme.brand, size: 19),
        const SizedBox(width: 9),
        SizedBox(
          width: 58,
          child: Text(label,
              style:
                  const TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 11, height: 1.4),
          ),
        ),
      ],
    );
  }

  Future<void> _showPurchaseRequest(
      BuildContext context, MarketplaceItem item) async {
    final sent = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('현지 구매 요청',
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
                const SizedBox(height: 6),
                Text(
                  '${item.sellerName}님이 현지에서 재고와 실물을 확인한 뒤 구매를 진행합니다.',
                  style: TextStyle(
                      fontSize: 12, height: 1.45, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 18),
                AppGlassSurface(
                  tint: NomadTheme.canvas,
                  surfaceOpacity: .7,
                  blurSigma: 14,
                  borderRadius: BorderRadius.circular(16),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title,
                          style: const TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 5),
                      Text(item.sourceLabel,
                          style: const TextStyle(
                              fontSize: 11, color: NomadTheme.brand)),
                      const SizedBox(height: 5),
                      Text(item.deliveryNote,
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey.shade700)),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                AppGlassPrimaryButton(
                  onPressed: () => Navigator.of(sheetContext).pop(true),
                  icon: Icons.send_rounded,
                  label: '${item.sellerName}에게 요청 보내기',
                  tint: NomadTheme.brand,
                ),
              ],
            ),
          ),
        );
      },
    );
    if (sent == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('구매 요청을 보냈습니다. 채팅에서 현지 확인 내용을 이어갈 수 있어요.')),
      );
    }
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
          decoration: const BoxDecoration(
              color: NomadTheme.softGreen, shape: BoxShape.circle),
          child: Icon(icon, color: NomadTheme.brand, size: 21),
        ),
        const SizedBox(height: 7),
        Text(label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
