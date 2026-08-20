import 'package:flutter/material.dart';

import '../theme/nomad_theme.dart';
import 'marketplace_image.dart';

class LocalTrendCard extends StatelessWidget {
  const LocalTrendCard({
    super.key,
    required this.city,
    required this.title,
    required this.caption,
    required this.imageUrl,
  });

  final String city;
  final String title;
  final String caption;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8E4)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MarketplaceImage(
                url: imageUrl, height: 108, width: double.infinity),
            Padding(
              padding: const EdgeInsets.all(13),
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
                  const SizedBox(height: 5),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 10,
                        height: 1.35,
                        color: Colors.grey.shade600),
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
