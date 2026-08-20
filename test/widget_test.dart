import 'package:flutter/material.dart';
import 'package:flutter_nomad_market_v2/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the Nomad Market marketplace home', (tester) async {
    await tester.pumpWidget(const NomadMarketApp());
    await tester.pump();

    expect(find.text('NOMAD MARKET'), findsOneWidget);
    expect(find.text('Paris → Seoul'), findsOneWidget);
    expect(find.text('이번 주 도착하는 현지 픽'), findsOneWidget);
    expect(find.textContaining('현지 전문가에게 부탁하세요'), findsOneWidget);
    expect(find.byIcon(Icons.search_rounded), findsWidgets);
  });

  testWidgets('preserves community chat and my tabs', (tester) async {
    await tester.pumpWidget(const NomadMarketApp());
    await tester.pump();

    await tester.tap(find.text('커뮤니티'));
    await tester.pumpAndSettle();
    expect(find.text('여행자와 현지인의 진짜 로컬 정보'), findsOneWidget);

    await tester.tap(find.text('채팅'));
    await tester.pumpAndSettle();
    expect(find.text('구매 요청'), findsOneWidget);
    expect(find.text('현지 전문가와 이어서 이야기하세요'), findsOneWidget);

    await tester.tap(find.text('마이'));
    await tester.pumpAndSettle();
    expect(find.text('마이 Nomad'), findsOneWidget);
    expect(find.text('다음 이동 일정'), findsOneWidget);
  });

  testWidgets('search and local listing are reachable from shopping',
      (tester) async {
    await tester.pumpWidget(const NomadMarketApp());
    await tester.pump();

    await tester.tap(find.text('도시, 한정판, K-뷰티를 찾아보세요'));
    await tester.pumpAndSettle();
    expect(find.text('현지 상품 찾기'), findsOneWidget);
    expect(find.textContaining('개의 현지 픽'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('현지 상품 등록'));
    await tester.pumpAndSettle();
    expect(find.text('파리 부티크 한정 실크 스카프'), findsOneWidget);
    expect(find.text('현지 상품 등록'), findsWidgets);
  });
}
