import 'package:flutter/material.dart';

import '../theme/nomad_theme.dart';
import 'home_screen.dart';

class SignupFlowScreen extends StatefulWidget {
  const SignupFlowScreen({super.key});

  @override
  State<SignupFlowScreen> createState() => _SignupFlowScreenState();
}

class _SignupFlowScreenState extends State<SignupFlowScreen> {
  static const _portfolioDemo = bool.fromEnvironment('PORTFOLIO_DEMO');
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _nickname = TextEditingController();
  int _step = 0;
  String _region = '유럽';
  String _country = '프랑스';
  String _city = '파리';
  final Set<String> _languages = {'한국어', 'English'};
  final List<String> _currencies = ['KRW', 'EUR'];
  String _mode = 'Buyer';
  final Set<String> _buyerTypes = {'해외 상품 구매하기'};

  static const _stepCount = 7;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _nickname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final complete = _step == _stepCount - 1;
    return Scaffold(
      backgroundColor: complete ? const Color(0xFF101615) : Colors.white,
      appBar: AppBar(
        backgroundColor: complete ? const Color(0xFF101615) : Colors.white,
        foregroundColor: complete ? Colors.white : NomadTheme.ink,
        leading: IconButton(
          onPressed: () {
            if (_step == 0) {
              Navigator.of(context).pop();
            } else {
              setState(() => _step--);
            }
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          complete ? '가입 완료' : '회원가입',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        top: false,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween(begin: const Offset(.06, 0), end: Offset.zero).animate(animation),
              child: child,
            ),
          ),
          child: KeyedSubtree(key: ValueKey(_step), child: _buildStep()),
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return _formStep(
          title: '기본 정보를 입력하세요',
          subtitle: '안전하고 편리한 서비스 이용을 위해\n이메일과 비밀번호를 설정해주세요.',
          children: [
            _fieldLabel('이메일'),
            TextField(
              key: const Key('signup-email'),
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(hintText: 'Enter your email'),
            ),
            const SizedBox(height: 16),
            _fieldLabel('비밀번호'),
            TextField(
              key: const Key('signup-password'),
              controller: _password,
              obscureText: true,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(hintText: '8자 이상 입력하세요'),
            ),
            const SizedBox(height: 16),
            _fieldLabel('비밀번호 확인'),
            TextField(
              key: const Key('signup-confirm-password'),
              controller: _confirmPassword,
              obscureText: true,
              decoration: const InputDecoration(hintText: '비밀번호를 한 번 더 입력하세요'),
            ),
          ],
          onNext: _validateBasicInfo,
        );
      case 1:
        return _formStep(
          title: '이메일을 확인해주세요',
          subtitle: '입력한 이메일로 보낸 인증번호를 확인해주세요.\n포트폴리오 데모에서는 인증 흐름을 로컬에서 완료합니다.',
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: const Color(0xFFF5F7F6), borderRadius: BorderRadius.circular(18)),
              child: Row(
                children: [
                  const Icon(Icons.mark_email_read_outlined, color: NomadTheme.brand),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(_email.text.isEmpty ? 'traveler@nomadmarket.app' : _email.text,
                        style: const TextStyle(fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text('인증번호', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            Row(
              children: '120521'.split('').map((digit) {
                return Expanded(
                  child: Container(
                    height: 58,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFDDE3DF)),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    alignment: Alignment.center,
                    child: Text(digit, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),
            const Text('00:58 안에 입력해주세요', style: TextStyle(fontSize: 11, color: Colors.black45)),
          ],
        );
      case 2:
        return _formStep(
          title: '프로필을 설정하세요',
          subtitle: '다른 사용자들에게 보여질\n프로필 사진과 닉네임을 설정해주세요.',
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: const Color(0xFFF1F4F2),
                    backgroundImage: const AssetImage('assets/auth/profile-traveller.png'),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(color: NomadTheme.brand, shape: BoxShape.circle),
                      child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 19),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 34),
            _fieldLabel('닉네임'),
            TextField(
              key: const Key('signup-nickname'),
              controller: _nickname,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(hintText: '예: SarahNomad'),
            ),
            const SizedBox(height: 12),
            const Text('여행자와 구매자가 서로 기억하기 쉬운 이름을 추천해요.',
                style: TextStyle(fontSize: 11, color: Colors.black45)),
          ],
        );
      case 3:
        return _formStep(
          title: '활동 지역',
          subtitle: '주로 여행하거나 거래하는 지역을 선택해주세요.\n추천 상품과 여행자 매칭에 활용됩니다.',
          children: [
            _selectionTitle('지역'),
            _choiceWrap(['아시아', '유럽', '북미'], _region, (value) => setState(() => _region = value)),
            const SizedBox(height: 28),
            _selectionTitle('국가'),
            _choiceWrap(['대한민국', '프랑스', '일본', '이탈리아'], _country, (value) => setState(() => _country = value)),
            const SizedBox(height: 28),
            _selectionTitle('도시'),
            _choiceWrap(['서울', '파리', '도쿄', '밀라노'], _city, (value) => setState(() => _city = value)),
          ],
        );
      case 4:
        return _formStep(
          title: '소통 가능 언어',
          subtitle: '여행자와 구매자가 편하게 대화할 수 있도록\n사용 가능한 언어를 알려주세요.',
          children: [
            _selectionTitle('언어'),
            Wrap(
              spacing: 9,
              runSpacing: 9,
              children: ['한국어', 'English', '日本語', 'Français'].map((language) {
                final selected = _languages.contains(language);
                return FilterChip(
                  label: Text(language),
                  selected: selected,
                  onSelected: (_) => setState(() {
                    if (selected) {
                      _languages.remove(language);
                    } else {
                      _languages.add(language);
                    }
                  }),
                  showCheckmark: false,
                  selectedColor: NomadTheme.ink,
                  labelStyle: TextStyle(color: selected ? Colors.white : NomadTheme.ink),
                );
              }).toList(),
            ),
            const SizedBox(height: 34),
            _selectionTitle('대화 수준'),
            const Row(
              children: [
                _LevelCard(label: 'Native', detail: '자연스럽게 대화'),
                SizedBox(width: 10),
                _LevelCard(label: 'Business', detail: '거래 대화 가능'),
                SizedBox(width: 10),
                _LevelCard(label: 'Casual', detail: '기본 대화 가능'),
              ],
            ),
          ],
        );
      case 5:
        return _formStep(
          title: '선호 통화와 이용 모드',
          subtitle: '거래할 때 자주 쓰는 통화와\n노마드 마켓에서 하고 싶은 활동을 선택하세요.',
          children: [
            _selectionTitle('선호 통화 · 최대 3개'),
            Wrap(
              spacing: 9,
              runSpacing: 9,
              children: ['KRW', 'USD', 'EUR', 'JPY'].map((currency) {
                final selected = _currencies.contains(currency);
                return FilterChip(
                  label: Text(currency),
                  selected: selected,
                  onSelected: (_) => setState(() {
                    if (selected) {
                      _currencies.remove(currency);
                    } else if (_currencies.length < 3) {
                      _currencies.add(currency);
                    }
                  }),
                  showCheckmark: false,
                  selectedColor: NomadTheme.ink,
                  labelStyle: TextStyle(color: selected ? Colors.white : NomadTheme.ink),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            _selectionTitle('이용 모드'),
            Row(
              children: [
                Expanded(child: _modeCard('Buyer', Icons.shopping_bag_outlined, '해외 상품을 부탁하고\n여행자와 연결돼요')),
                const SizedBox(width: 12),
                Expanded(child: _modeCard('Seller', Icons.flight_takeoff_rounded, '여행 중 현지 상품을\n등록하고 연결해요')),
              ],
            ),
            if (_mode == 'Buyer') ...[
              const SizedBox(height: 24),
              _selectionTitle('원하는 경험'),
              Wrap(
                spacing: 9,
                runSpacing: 9,
                children: ['해외 상품 구매하기', '해외 물품전달 부탁하기'].map((type) {
                  final selected = _buyerTypes.contains(type);
                  return FilterChip(
                    label: Text(type),
                    selected: selected,
                    onSelected: (_) => setState(() {
                      if (selected) {
                        _buyerTypes.remove(type);
                      } else {
                        _buyerTypes.add(type);
                      }
                    }),
                    showCheckmark: false,
                  );
                }).toList(),
              ),
            ],
          ],
        );
      default:
        return _completeStep();
    }
  }

  Widget _formStep({
    required String title,
    required String subtitle,
    required List<Widget> children,
    VoidCallback? onNext,
  }) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 25, height: 1.25, fontWeight: FontWeight.w900, letterSpacing: -.5)),
                const SizedBox(height: 9),
                Text(subtitle, style: const TextStyle(fontSize: 13, height: 1.55, color: Colors.black54)),
                const SizedBox(height: 38),
                ...children,
              ],
            ),
          ),
        ),
        _progressAndButton(onNext ?? _next),
      ],
    );
  }

  Widget _progressAndButton(VoidCallback onNext) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _stepCount,
              (index) => Container(
                width: index == _step ? 18 : 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: index <= _step ? NomadTheme.brand : const Color(0xFFD9DEDC),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          FilledButton(
            key: Key('signup-next-$_step'),
            onPressed: onNext,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text('다음', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  Widget _completeStep() {
    final nickname = _nickname.text.trim().isEmpty ? 'Nomad' : _nickname.text.trim();
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),
          Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(color: NomadTheme.brand.withValues(alpha: .15), shape: BoxShape.circle),
            child: const Icon(Icons.check_circle_outline_rounded, color: Color(0xFF77D9C8), size: 38),
          ),
          const SizedBox(height: 30),
          Text('축하드립니다, $nickname님', style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900)),
          const SizedBox(height: 7),
          const Text('회원가입이 완료되었습니다!', style: TextStyle(color: Colors.white60, fontSize: 18)),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: const Color(0xFF1C2422), borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _summary('활동 지역', '$_country · $_city'),
                _summary('소통 언어', _languages.join(' · ')),
                _summary('선호 통화', _currencies.join(' · ')),
                _summary('이용 모드', _mode == 'Buyer' ? '구매자 · 퍼스널 쇼핑 요청' : '여행자 · 현지 상품 연결'),
                const SizedBox(height: 6),
                const Text(
                  '노마드마켓을 이용함으로써 이용약관과 개인정보처리방침에 동의하는 것으로 간주됩니다.',
                  style: TextStyle(fontSize: 10, height: 1.5, color: Colors.white38),
                ),
              ],
            ),
          ),
          const Spacer(),
          FilledButton(
            key: const Key('signup-complete'),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            ),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: NomadTheme.ink,
              minimumSize: const Size.fromHeight(54),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text('시작하기', style: TextStyle(fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }

  Widget _summary(String title, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white54, fontSize: 10)),
            const SizedBox(height: 5),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800)),
          ],
        ),
      );

  Widget _fieldLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
      );

  Widget _selectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      );

  Widget _choiceWrap(List<String> values, String selected, ValueChanged<String> onSelected) {
    return Wrap(
      spacing: 9,
      runSpacing: 9,
      children: values.map((value) {
        final active = value == selected;
        return ChoiceChip(
          label: Text(value),
          selected: active,
          onSelected: (_) => onSelected(value),
          showCheckmark: false,
          selectedColor: NomadTheme.ink,
          labelStyle: TextStyle(color: active ? Colors.white : NomadTheme.ink),
        );
      }).toList(),
    );
  }

  Widget _modeCard(String mode, IconData icon, String detail) {
    final selected = _mode == mode;
    return InkWell(
      onTap: () => setState(() => _mode = mode),
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? NomadTheme.ink : const Color(0xFFF5F7F6),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: selected ? NomadTheme.ink : const Color(0xFFDDE3DF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: selected ? const Color(0xFF8DD2C4) : NomadTheme.brand),
            const SizedBox(height: 20),
            Text(mode, style: TextStyle(color: selected ? Colors.white : NomadTheme.ink, fontSize: 17, fontWeight: FontWeight.w900)),
            const SizedBox(height: 7),
            Text(detail, style: TextStyle(color: selected ? Colors.white60 : Colors.black54, fontSize: 10, height: 1.45)),
          ],
        ),
      ),
    );
  }

  void _validateBasicInfo() {
    if (_portfolioDemo) {
      _email.text = 'traveler@nomadmarket.app';
      _password.text = 'nomadmarket';
      _confirmPassword.text = 'nomadmarket';
      _next();
      return;
    }
    final emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_email.text.trim());
    final passwordValid = _password.text.length >= 8 && _password.text == _confirmPassword.text;
    if (!emailValid || !passwordValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이메일 형식과 8자 이상 동일한 비밀번호를 확인해주세요.')),
      );
      return;
    }
    _next();
  }

  void _next() {
    FocusScope.of(context).unfocus();
    if (_portfolioDemo && _step == 2 && _nickname.text.trim().isEmpty) {
      _nickname.text = 'SarahNomad';
    }
    if (_step < _stepCount - 1) setState(() => _step++);
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({required this.label, required this.detail});

  final String label;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        decoration: BoxDecoration(color: const Color(0xFFF5F7F6), borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900)),
            const SizedBox(height: 5),
            Text(detail, textAlign: TextAlign.center, style: const TextStyle(fontSize: 8, color: Colors.black45)),
          ],
        ),
      ),
    );
  }
}
