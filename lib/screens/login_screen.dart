import 'package:flutter/material.dart';

import '../theme/nomad_theme.dart';
import '../v2/v2_glass.dart';
import 'home_screen.dart';
import 'signup_flow_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tallLayout = MediaQuery.sizeOf(context).height > 700;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: NomadTheme.canvas,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 650),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(
                        offset: Offset(0, 24 * (1 - value)), child: child),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppGlassSurface(
                            surfaceOpacity: .62,
                            borderRadius: BorderRadius.circular(14),
                            blurSigma: 14,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 11, vertical: 8),
                            child: const Row(
                              children: [
                                Icon(Icons.language_rounded, size: 17),
                                SizedBox(width: 6),
                                Text('한국어',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                          TextButton(
                              onPressed: _enterMarket,
                              child: const Text('둘러보기')),
                        ],
                      ),
                      const SizedBox(height: 42),
                      const Text(
                        '안녕하세요',
                        style: TextStyle(
                            fontSize: 31,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -.7),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        '만나서 반갑습니다',
                        style: TextStyle(
                            fontSize: 31,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -.7),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '여행자와 구매자가 만나는 글로벌 로컬 마켓',
                        style: TextStyle(color: Colors.black45, fontSize: 13),
                      ),
                      const SizedBox(height: 42),
                      Row(
                        children: [
                          Expanded(
                              child: _socialAssetButton(
                                  'assets/auth/google.png', 'Google')),
                          const SizedBox(width: 10),
                          Expanded(
                              child: _socialAssetButton(
                                  'assets/auth/facebook.png', 'Facebook')),
                          const SizedBox(width: 10),
                          Expanded(
                              child: _socialIconButton(
                                  Icons.apple_rounded, 'Apple')),
                        ],
                      ),
                      const SizedBox(height: 28),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text('또는 이메일로 로그인',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.black45)),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _label('이메일'),
                      AppGlassSurface(
                        surfaceOpacity: .66,
                        blurSigma: 16,
                        borderRadius: BorderRadius.circular(18),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextField(
                          key: const Key('login-email'),
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'hello@nomadmarket.app',
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _label('비밀번호'),
                      AppGlassSurface(
                        surfaceOpacity: .66,
                        blurSigma: 16,
                        borderRadius: BorderRadius.circular(18),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextField(
                          key: const Key('login-password'),
                          controller: _password,
                          obscureText: _obscure,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: '비밀번호를 입력하세요',
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                              icon: Icon(_obscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text('비밀번호를 잊으셨나요?')),
                      ),
                      const SizedBox(height: 10),
                      AppGlassPrimaryButton(
                        key: const Key('login-submit'),
                        onPressed: _enterMarket,
                        label: '로그인',
                        tint: NomadTheme.brand,
                        minHeight: 54,
                      ),
                      if (tallLayout) ...[
                        const SizedBox(height: 14),
                        _signupPrompt(context),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            if (!tallLayout)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                child: _signupPrompt(context),
              ),
          ],
        ),
      ),
    );
  }

  Widget _signupPrompt(BuildContext context) {
    return AppGlassSurface(
      surfaceOpacity: .46,
      borderRadius: BorderRadius.circular(18),
      blurSigma: 16,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('아직 계정이 없으신가요?', style: TextStyle(fontSize: 12)),
          TextButton(
            key: const Key('open-signup'),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SignupFlowScreen()),
            ),
            child: const Text('회원가입',
                style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  Widget _socialAssetButton(String asset, String label) {
    return AppGlassSurface(
      onTap: _enterMarket,
      semanticLabel: '$label 로그인',
      surfaceOpacity: .62,
      blurSigma: 14,
      borderRadius: BorderRadius.circular(14),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Image.asset(
              asset,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(Icons.public_rounded,
                  size: 20, color: Colors.black87),
            ),
          ),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIconButton(IconData icon, String label) {
    return AppGlassSurface(
      onTap: _enterMarket,
      semanticLabel: '$label 로그인',
      surfaceOpacity: .62,
      blurSigma: 14,
      borderRadius: BorderRadius.circular(14),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black, size: 24),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: NomadTheme.ink)),
      );

  void _enterMarket() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }
}
