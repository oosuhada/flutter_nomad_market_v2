import 'package:flutter/material.dart';

import '../theme/nomad_theme.dart';
import '../v2/v2_glass.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;
  String _language = 'ko';

  static const _contents = <_OnboardingContent>[
    _OnboardingContent(
      image: 'assets/onboarding/onboarding1.png',
      koTitle: '여행자와 구매자를 잇다,\n당신의 노마드 마켓',
      koBody: '세계를 연결하는 쇼핑, 가치를 더하는 여행,\n당신의 여행이 누군가의 꿈을 현실로 만듭니다',
      enTitle: 'Connecting\nTravelers and Buyers',
      enBody:
          'Shopping that connects the world. Your journey can make someone’s wish come true.',
      jaTitle: '旅行者と購入者をつなぐ,\nあなたのノマドマーケット',
      jaBody: '世界をつなぐショッピング、価値を加える旅行。\nあなたの旅が誰かの夢を現実にします。',
    ),
    _OnboardingContent(
      image: 'assets/onboarding/onboarding2.png',
      koTitle: '현지 쇼핑으로 만나는\n글로벌 쇼핑 경험',
      koBody: '여행자가 현지에서 직접 구매해 배송료 부담 없이\n전 세계 현지 친구들이 당신의 퍼스널 쇼퍼가 됩니다',
      enTitle: 'Global Shopping\nthrough Local Shopping',
      enBody:
          'Travelers shop locally for you. Local friends around the world become your personal shoppers.',
      jaTitle: '現地ショッピングで実現する\nグローバルショッピング体験',
      jaBody: '旅行者が現地で直接購入。\n世界中の現地友達があなたのパーソナルショッパーになります。',
    ),
    _OnboardingContent(
      image: 'assets/onboarding/onboarding3.png',
      koTitle: '구하기 힘든 한정판,\n노마드 마켓에서',
      koBody: '해외 현지에서만 구할 수 있는 특별한 상품을 손쉽게\n국경을 넘어 원하는 상품을 편리하게 구매하세요',
      enTitle: 'Limited Editions\nat Nomad Market',
      enBody:
          'Find special local-only items and request them across borders with less friction.',
      jaTitle: '手に入りにくい限定版,\nノマドマーケットで',
      jaBody: '海外現地でしか手に入らない特別な商品を、\n国境を越えて便利に購入できます。',
    ),
    _OnboardingContent(
      image: 'assets/onboarding/onboarding4.png',
      koTitle: '여행의 즐거움에\n수익과 연결을 더하다',
      koBody: '여행하면서 간편하게 부가 수입 창출까지\n당신의 여행 가방은 이제 글로벌 마켓플레이스',
      enTitle: 'Add Profit and Connection\nto Every Journey',
      enBody:
          'Earn while you travel. Your suitcase becomes part of a global marketplace.',
      jaTitle: '旅行の楽しさに\n収益と繋がりをプラス',
      jaBody: '旅行しながら副収入も。\nあなたの旅行カバンがグローバルマーケットプレイスになります。',
    ),
    _OnboardingContent(
      image: 'assets/onboarding/onboarding5.png',
      koTitle: '안전한 거래,\n믿을 수 있는 플랫폼',
      koBody: '안전한 결제와 검증된 매칭 원칙으로\n서로 신뢰할 수 있는 거래 경험을 만듭니다',
      enTitle: 'Safe Transactions,\nTrusted Connections',
      enBody:
          'Clear trust signals and safe-deal principles help travelers and buyers transact with confidence.',
      jaTitle: '安全な取引,\n信頼できるプラットフォーム',
      jaBody: '安全な取引ルールと信頼情報で、\n安心してつながれる体験を提供します。',
    ),
    _OnboardingContent(
      image: 'assets/onboarding/onboarding6.png',
      koTitle: '해외쇼핑을 넘어선\n글로벌 문화 교류의 장',
      koBody: '전 세계 여행자와 구매자를 연결하는 글로벌 커뮤니티\n한국 문화의 숨은 보석을 전 세계에 연결합니다',
      enTitle: 'Beyond Shopping:\nA Global Cultural Exchange',
      enBody:
          'A community where travelers, buyers, products, and local stories move together.',
      jaTitle: '海外ショッピングを超えた\nグローバル文化交流の場',
      jaBody: '世界中の旅行者と購入者をつなぎ、\n地域の文化と商品の魅力を共有します。',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: _contents.length,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (value) => setState(() => _page = value),
              itemBuilder: (context, index) => _OnboardingPage(
                key: ValueKey('$index-$_language'),
                content: _contents[index],
                language: _language,
              ),
            ),
            Positioned(
              left: 20,
              top: 12,
              child: _LanguageMenu(
                value: _language,
                onChanged: (value) => setState(() => _language = value),
              ),
            ),
            Positioned(
              right: 16,
              top: 8,
              child: TextButton(
                onPressed: _openLogin,
                child: Text(
                  _language == 'ko'
                      ? '건너뛰기'
                      : _language == 'ja'
                          ? 'スキップ'
                          : 'Skip',
                  style: const TextStyle(color: Colors.black45),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                top: false,
                minimum: const EdgeInsets.fromLTRB(18, 0, 18, 10),
                child: AppGlassSurface(
                  borderRadius: BorderRadius.circular(28),
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _contents.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            width: index == _page ? 22 : 7,
                            height: 7,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: index == _page
                                  ? NomadTheme.brand
                                  : const Color(0xFFD8DEDB),
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 300,
                        child: FilledButton(
                          onPressed: _next,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          child: Text(
                            _page == _contents.length - 1
                                ? (_language == 'ko'
                                    ? '시작하기'
                                    : _language == 'ja'
                                        ? '始める'
                                        : 'Get started')
                                : (_language == 'ko'
                                    ? '다음'
                                    : _language == 'ja'
                                        ? '次へ'
                                        : 'Next'),
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _next() {
    if (_page == _contents.length - 1) {
      _openLogin();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOut,
    );
  }

  void _openLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    super.key,
    required this.content,
    required this.language,
  });

  final _OnboardingContent content;
  final String language;

  @override
  Widget build(BuildContext context) {
    final title = content.title(language);
    final body = content.body(language);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
            offset: Offset(0, 28 * (1 - value)), child: child),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 118, 30, 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 27,
                height: 1.28,
                fontWeight: FontWeight.w900,
                letterSpacing: -.5,
                color: NomadTheme.ink,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              body,
              style: const TextStyle(
                  fontSize: 14, height: 1.55, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: Image.asset(content.image, fit: BoxFit.contain),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageMenu extends StatelessWidget {
  const _LanguageMenu({required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppGlassSurface(
      borderRadius: BorderRadius.circular(16),
      blurSigma: 14,
      child: PopupMenuButton<String>(
        initialValue: value,
        onSelected: onChanged,
        itemBuilder: (_) => const [
          PopupMenuItem(value: 'ko', child: Text('한국어')),
          PopupMenuItem(value: 'en', child: Text('English')),
          PopupMenuItem(value: 'ja', child: Text('日本語')),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.language_rounded, size: 17),
              const SizedBox(width: 6),
              Text(
                  value == 'ko'
                      ? '한국어'
                      : value == 'ja'
                          ? '日本語'
                          : 'English',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700)),
              const SizedBox(width: 2),
              const Icon(Icons.keyboard_arrow_down_rounded, size: 17),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingContent {
  const _OnboardingContent({
    required this.image,
    required this.koTitle,
    required this.koBody,
    required this.enTitle,
    required this.enBody,
    required this.jaTitle,
    required this.jaBody,
  });

  final String image;
  final String koTitle;
  final String koBody;
  final String enTitle;
  final String enBody;
  final String jaTitle;
  final String jaBody;

  String title(String language) => language == 'ko'
      ? koTitle
      : language == 'ja'
          ? jaTitle
          : enTitle;
  String body(String language) => language == 'ko'
      ? koBody
      : language == 'ja'
          ? jaBody
          : enBody;
}
