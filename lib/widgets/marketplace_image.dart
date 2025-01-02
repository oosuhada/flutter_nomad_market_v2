import 'package:flutter/material.dart';

import '../theme/nomad_theme.dart';

class MarketplaceImage extends StatelessWidget {
  const MarketplaceImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  final String url;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final image = Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      filterQuality: FilterQuality.medium,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return _fallback(isLoading: true);
      },
      errorBuilder: (_, __, ___) => _fallback(),
    );

    if (borderRadius == null) return image;
    return ClipRRect(borderRadius: borderRadius!, child: image);
  }

  Widget _fallback({bool isLoading = false}) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE7EFEA), Color(0xFFF3EDE2)],
        ),
      ),
      child: Center(
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: NomadTheme.brand,
                ),
              )
            : const Icon(
                Icons.shopping_bag_outlined,
                size: 36,
                color: NomadTheme.brand,
              ),
      ),
    );
  }
}
