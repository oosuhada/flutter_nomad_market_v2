import 'package:flutter/material.dart';

import '../data/demo_marketplace_data.dart';
import '../models/marketplace_item.dart';
import '../theme/nomad_theme.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.initialCategory});

  final String? initialCategory;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String _category = '전체';
  String _sort = '추천순';

  @override
  void initState() {
    super.initState();
    final initial = widget.initialCategory;
    if (initial != null && marketplaceCategories.contains(initial)) {
      _category = initial;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<MarketplaceItem> get _results {
    final query = _controller.text.trim().toLowerCase();
    final result = demoMarketplaceItems.where((item) {
      final matchesCategory = _category == '전체' || item.category == _category;
      final haystack =
          '${item.title} ${item.location} ${item.category} ${item.sourceLabel} ${item.tags.join(' ')} ${item.sellerName}'
              .toLowerCase();
      return matchesCategory && (query.isEmpty || haystack.contains(query));
    }).toList();
    if (_sort == '낮은 가격') result.sort((a, b) => a.price.compareTo(b.price));
    if (_sort == '관심 많은 순') result.sort((a, b) => b.likes.compareTo(a.likes));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '현지 상품 찾기',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: TextField(
                controller: _controller,
                onChanged: (_) => setState(() {}),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: '예: 파리, 한정판, K-뷰티',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _controller.text.isEmpty
                      ? const Icon(Icons.tune_rounded, size: 20)
                      : IconButton(
                          onPressed: () {
                            _controller.clear();
                            setState(() {});
                          },
                          icon: const Icon(Icons.close_rounded),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: marketplaceCategories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = marketplaceCategories[index];
                  return ChoiceChip(
                    label: Text(category),
                    selected: category == _category,
                    onSelected: (_) => setState(() => _category = category),
                    showCheckmark: false,
                    side: BorderSide.none,
                    selectedColor: NomadTheme.ink,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color:
                          category == _category ? Colors.white : NomadTheme.ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 12, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${results.length}개의 현지 픽',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                  ),
                  PopupMenuButton<String>(
                    initialValue: _sort,
                    onSelected: (value) => setState(() => _sort = value),
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: '추천순', child: Text('추천순')),
                      PopupMenuItem(value: '낮은 가격', child: Text('낮은 가격')),
                      PopupMenuItem(value: '관심 많은 순', child: Text('관심 많은 순')),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      child: Row(
                        children: [
                          Text(_sort,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600)),
                          const SizedBox(width: 2),
                          const Icon(Icons.keyboard_arrow_down_rounded,
                              size: 19),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  results.isEmpty ? _buildEmptyState() : _buildResults(results),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(List<MarketplaceItem> results) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 22,
        childAspectRatio: .58,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ProductCard(
          item: item,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ProductDetailScreen(item: item)),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: NomadTheme.softGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.travel_explore_rounded,
                  color: NomadTheme.brand, size: 34),
            ),
            const SizedBox(height: 18),
            const Text('아직 맞는 현지 픽이 없어요',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 7),
            Text(
              '다른 도시, 카테고리 또는 여행자 키워드로 찾아보세요.',
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            TextButton(
              onPressed: () {
                _controller.clear();
                setState(() => _category = '전체');
              },
              child: const Text('필터 초기화'),
            ),
          ],
        ),
      ),
    );
  }
}
