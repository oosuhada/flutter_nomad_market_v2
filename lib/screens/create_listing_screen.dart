import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/demo_marketplace_data.dart';
import '../theme/nomad_theme.dart';
import '../widgets/marketplace_image.dart';

class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: '빈티지 필름 카메라 + 35mm 렌즈');
  final _priceController = TextEditingController(text: '420000');
  final _descriptionController = TextEditingController(
    text: '여행 기록용으로 사용했고 최근 전문점에서 점검했습니다. 테스트 필름 결과도 채팅으로 보내드릴게요.',
  );
  String _category = '빈티지';
  String _location = '서울 · 성수동';

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('판매글 작성', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
        actions: [
          TextButton(onPressed: _resetDemo, child: const Text('초기화')),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Form(
          key: _formKey,
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: [
              const Text(
                '어떤 물건을 여행자들과 나눌까요?',
                style: TextStyle(fontSize: 23, height: 1.25, fontWeight: FontWeight.w800, letterSpacing: -.4),
              ),
              const SizedBox(height: 6),
              Text(
                '사진과 거래 정보를 명확하게 적을수록 더 빠르게 연결돼요.',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              const SizedBox(height: 22),
              _buildPhotoPicker(),
              const SizedBox(height: 24),
              _label('상품명'),
              TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                validator: (value) => (value == null || value.trim().length < 4) ? '상품명을 4자 이상 입력해주세요.' : null,
                decoration: const InputDecoration(hintText: '상품명을 입력하세요'),
              ),
              const SizedBox(height: 18),
              _label('가격'),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => (int.tryParse(value ?? '') ?? 0) <= 0 ? '가격을 입력해주세요.' : null,
                decoration: const InputDecoration(prefixText: '₩  ', hintText: '0'),
              ),
              const SizedBox(height: 18),
              _label('카테고리'),
              DropdownButtonFormField<String>(
                value: _category,
                items: marketplaceCategories
                    .where((category) => category != '전체')
                    .map((category) => DropdownMenuItem(value: category, child: Text(category)))
                    .toList(),
                onChanged: (value) => setState(() => _category = value ?? _category),
              ),
              const SizedBox(height: 18),
              _label('거래 위치'),
              DropdownButtonFormField<String>(
                value: _location,
                items: const [
                  '서울 · 성수동',
                  '서울 · 연남동',
                  'Paris · Le Marais',
                  'Tokyo · Shibuya',
                ].map((location) => DropdownMenuItem(value: location, child: Text(location))).toList(),
                onChanged: (value) => setState(() => _location = value ?? _location),
                decoration: const InputDecoration(prefixIcon: Icon(Icons.location_on_outlined)),
              ),
              const SizedBox(height: 18),
              _label('상품 설명'),
              TextFormField(
                controller: _descriptionController,
                minLines: 4,
                maxLines: 6,
                validator: (value) => (value == null || value.trim().length < 10) ? '상태와 거래 방법을 조금 더 알려주세요.' : null,
                decoration: const InputDecoration(hintText: '상태, 구매 시기, 거래 방법 등을 알려주세요'),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: NomadTheme.softGreen,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.verified_user_outlined, color: NomadTheme.brand, size: 21),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '안전거래를 위해 실제 상품 상태와 위치를 정확하게 알려주세요. 연락처는 공개되지 않습니다.',
                        style: TextStyle(fontSize: 12, height: 1.45, color: NomadTheme.ink),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              FilledButton.icon(
                onPressed: _submit,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                icon: const Icon(Icons.arrow_upward_rounded),
                label: const Text('Nomad Market에 등록하기', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() {
    final sample = demoMarketplaceItems[2];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('사진  1/5'),
        SizedBox(
          height: 112,
          child: Row(
            children: [
              SizedBox(
                width: 112,
                height: 112,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    MarketplaceImage(url: sample.imageUrl, borderRadius: BorderRadius.circular(18)),
                    Positioned(
                      left: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: NomadTheme.ink.withValues(alpha: .84), borderRadius: BorderRadius.circular(999)),
                        child: const Text('대표', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _photoAddButton(),
              const SizedBox(width: 10),
              _photoAddButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _photoAddButton() {
    return InkWell(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('데모 모드에서는 대표 사진 미리보기를 사용합니다.')),
      ),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 82,
        height: 112,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFDDE3DF)),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_photo_alternate_outlined, color: NomadTheme.brand),
            SizedBox(height: 7),
            Text('사진 추가', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
    );
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('판매글이 데모 마켓에 등록되었습니다.'), behavior: SnackBarBehavior.floating),
    );
  }

  void _resetDemo() {
    _titleController.text = '';
    _priceController.text = '';
    _descriptionController.text = '';
    setState(() {
      _category = '빈티지';
      _location = '서울 · 성수동';
    });
  }
}
