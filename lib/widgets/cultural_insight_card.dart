import 'package:flutter/material.dart';

import '../theme/nomad_theme.dart';
import '../v2/v2_glass.dart';
import 'marketplace_image.dart';

class CulturalInsightCard extends StatelessWidget {
  const CulturalInsightCard({
    super.key,
    required this.city,
    required this.title,
    required this.caption,
    required this.imageUrl,
    required this.onTap,
  });

  final String city;
  final String title;
  final String caption;
  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: AppGlassSurface(
        onTap: onTap,
        semanticLabel: title,
        surfaceOpacity: .62,
        blurSigma: 16,
        borderRadius: BorderRadius.circular(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MarketplaceImage(
                url: imageUrl, height: 120, width: double.infinity),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city,
                    style: const TextStyle(
                      color: NomadTheme.brand,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    caption,
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 10,
                        height: 1.35),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
