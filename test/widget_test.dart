import 'package:flutter/material.dart';
import 'package:flutter_nomad_market_v2/main.dart';
import 'package:flutter_nomad_market_v2/screens/home_screen.dart';
import 'package:flutter_nomad_market_v2/theme/nomad_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('starts with the restored Nomad onboarding', (tester) async {
    await tester.pumpWidget(const NomadMarketApp());
    await tester.pumpAndSettle();

    expect(find.text('여행자와 구매자를 잇다,\n당신의 노마드 마켓'), findsOneWidget);
    expect(find.text('건너뛰기'), findsOneWidget);
    expect(find.text('다음'), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
  });

  testWidgets('onboarding connects to login and signup', (tester) async {
    await tester.pumpWidget(const NomadMarketApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('건너뛰기'));
    await tester.pumpAndSettle();
    expect(find.text('안녕하세요'), findsOneWidget);
    expect(find.text('만나서 반갑습니다'), findsOneWidget);
    expect(find.text('회원가입'), findsOneWidget);

    await tester.tap(find.byKey(const Key('open-signup')));
    await tester.pumpAndSettle();
    expect(find.text('기본 정보를 입력하세요'), findsOneWidget);
    expect(find.byKey(const Key('signup-email')), findsOneWidget);
    expect(find.byKey(const Key('signup-next-0')), findsOneWidget);
  });

  testWidgets('shopping keeps community chat and my tabs', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: NomadTheme.light(),
        home: const HomeScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Paris → Seoul'), findsOneWidget);
    expect(find.text('이번 주 도착하는 현지 픽'), findsOneWidget);

    await tester.tap(find.text('커뮤니티'));
    await tester.pumpAndSettle();
    expect(find.text('여행자와 현지인의 진짜 로컬 정보'), findsOneWidget);

    await tester.tap(find.text('채팅'));
    await tester.pumpAndSettle();
    expect(find.text('구매 요청'), findsOneWidget);

    await tester.tap(find.text('마이'));
    await tester.pumpAndSettle();
    expect(find.text('마이 Nomad'), findsOneWidget);
  });
}
