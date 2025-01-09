class MarketplaceItem {
  const MarketplaceItem({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.location,
    required this.timeAgo,
    required this.likes,
    required this.imageUrl,
    required this.description,
    required this.sellerName,
    required this.sellerLocation,
    required this.sellerRating,
    required this.sellerDeals,
    required this.tags,
    this.isFeatured = false,
  });

  final String id;
  final String title;
  final int price;
  final String category;
  final String location;
  final String timeAgo;
  final int likes;
  final String imageUrl;
  final String description;
  final String sellerName;
  final String sellerLocation;
  final double sellerRating;
  final int sellerDeals;
  final List<String> tags;
  final bool isFeatured;

  String get formattedPrice {
    final digits = price.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(digits[i]);
    }
    return '₩$buffer';
  }
}
