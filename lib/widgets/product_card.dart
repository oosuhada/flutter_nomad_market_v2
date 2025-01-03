import 'package:flutter/material.dart';

import '../models/marketplace_item.dart';
import '../theme/nomad_theme.dart';
import 'marketplace_image.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.item,
    required this.onTap,
    this.compact = false,
  });

  final MarketplaceItem item;
  final VoidCallback onTap;
  final bool compact;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _favorite = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: widget.compact ? 1.2 : 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                MarketplaceImage(
                  url: item.imageUrl,
                  borderRadius: BorderRadius.circular(18),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Material(
                    color: Colors.white.withValues(alpha: 0.92),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => setState(() => _favorite = !_favorite),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          _favorite ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: _favorite ? Colors.redAccent : NomadTheme.ink,
                        ),
                      ),
                    ),
                  ),
                ),
                if (item.isFeatured)
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                      decoration: BoxDecoration(
                        color: NomadTheme.ink.withValues(alpha: 0.86),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'NOMAD PICK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: .6,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.location,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: NomadTheme.brand,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            item.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: widget.compact ? 14 : 15,
              height: 1.25,
              fontWeight: FontWeight.w700,
              color: NomadTheme.ink,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            item.formattedPrice,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: NomadTheme.ink,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${item.timeAgo} · 관심 ${item.likes}',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
