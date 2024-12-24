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
  final _titleController = TextEditingController(text: '파리 부티크 한정 실크 스카프');
  final _priceController = TextEditingController(text: '129000');
  final _descriptionController = TextEditingController(
    text: '르 마레 부티크에서 직접 확인한 시즌 한정 컬러입니다. 구매 전 실물 사진과 영수증 정보를 채팅으로 공유할 수 있어요.',
  );
  final _deliveryController =
      TextEditingController(text: '9월 2일 서울 도착 · 성수/강남 전달 가능');
  String _category = '럭셔리';
  String _location = 'Paris · Le Marais';

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _deliveryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('현지 상품 등록',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
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
                '여행 중 발견한 좋은 물건을\nNomad Market에 소개해보세요',
                style: TextStyle(
                    fontSize: 23,
                    height: 1.25,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -.4),
              ),
              const SizedBox(height: 6),
              Text(
                '현지 매장과 한국 이동 일정을 함께 알려주면 구매 요청이 더 정확해져요.',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              const SizedBox(height: 22),
              _buildPhotoPicker(),
              const SizedBox(height: 24),
              _label('현지에서 발견한 상품'),
              TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                validator: (value) => (value == null || value.trim().length < 4)
                    ? '상품명을 4자 이상 입력해주세요.'
                    : null,
                decoration:
                    const InputDecoration(hintText: '상품 또는 한정판 이름을 입력하세요'),
              ),
              const SizedBox(height: 18),
              _label('예상 구매가'),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => (int.tryParse(value ?? '') ?? 0) <= 0
                    ? '가격을 입력해주세요.'
                    : null,
                decoration:
                    const InputDecoration(prefixText: '₩  ', hintText: '0'),
              ),
              const SizedBox(height: 18),
              _label('카테고리'),
              DropdownButtonFormField<String>(
                value: _category,
                items: marketplaceCategories
                    .where((category) => category != '전체')
                    .map((category) => DropdownMenuItem(
                        value: category, child: Text(category)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _category = value ?? _category),
              ),
              const SizedBox(height: 18),
              _label('현재 도시 / 구매 장소'),
              DropdownButtonFormField<String>(
                value: _location,
                items: const [
                  'Paris · Le Marais',
                  'Tokyo · Shibuya',
                  'Milano · Brera',
                  'London · Shoreditch',
                  'Seoul · Seongsu',
                ]
                    .map((location) => DropdownMenuItem(
                        value: location, child: Text(location)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _location = value ?? _location),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_on_outlined)),
              ),
              const SizedBox(height: 18),
              _label('한국 이동 / 전달 일정'),
              TextFormField(
                controller: _deliveryController,
                textInputAction: TextInputAction.next,
                validator: (value) => (value == null || value.trim().length < 6)
                    ? '이동 또는 전달 일정을 알려주세요.'
                    : null,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.flight_land_rounded),
                  hintText: '예: 9월 2일 서울 도착',
                ),
              ),
              const SizedBox(height: 18),
              _label('현지 확인 메모'),
              TextFormField(
                controller: _descriptionController,
                minLines: 4,
                maxLines: 6,
                validator: (value) =>
                    (value == null || value.trim().length < 10)
                        ? '상태와 거래 방법을 조금 더 알려주세요.'
                        : null,
                decoration: const InputDecoration(
                    hintText: '매장 재고, 한정 여부, 상태, 영수증 제공 여부 등을 알려주세요'),
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
                    Icon(Icons.verified_user_outlined,
                        color: NomadTheme.brand, size: 21),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '구매 요청을 받기 전 실제 매장 재고와 가격을 다시 확인해주세요. 앱 내 채팅으로 실물 사진과 영수증 정보를 공유할 수 있습니다.',
                        style: TextStyle(
                            fontSize: 12, height: 1.45, color: NomadTheme.ink),
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                icon: const Icon(Icons.arrow_upward_rounded),
                label: const Text('현지 픽 등록하기',
                    style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() {
    final sample = demoMarketplaceItems.first;
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
                    MarketplaceImage(
                        url: sample.imageUrl,
                        borderRadius: BorderRadius.circular(18)),
                    Positioned(
                      left: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: NomadTheme.ink.withValues(alpha: .84),
                            borderRadius: BorderRadius.circular(999)),
                        child: const Text('대표',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700)),
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
            Text('사진 추가',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
    );
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('현지 상품이 Nomad Market에 등록되었습니다.'),
          behavior: SnackBarBehavior.floating),
    );
  }

  void _resetDemo() {
    _titleController.text = '';
    _priceController.text = '';
    _descriptionController.text = '';
    _deliveryController.text = '';
    setState(() {
      _category = '럭셔리';
      _location = 'Paris · Le Marais';
    });
  }
}
