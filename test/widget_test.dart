import 'package:flutter/material.dart';
import 'package:flutter_nomad_market_v2/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the Nomad Market marketplace home', (tester) async {
    await tester.pumpWidget(const NomadMarketApp());
    await tester.pump();

    expect(find.text('NOMAD MARKET'), findsOneWidget);
    expect(find.text('서울 · 성수동'), findsOneWidget);
    expect(find.text('지금 뜨는 로컬 픽'), findsOneWidget);
    expect(find.byIcon(Icons.search_rounded), findsWidgets);
  });

  testWidgets('bottom navigation opens search and sell flows', (tester) async {
    await tester.pumpWidget(const NomadMarketApp());
    await tester.pump();

    await tester.tap(find.text('탐색'));
    await tester.pumpAndSettle();
    expect(find.text('DEMO CATALOG'), findsOneWidget);
    expect(find.textContaining('개의 로컬 아이템'), findsOneWidget);

    await tester.tap(find.text('판매'));
    await tester.pumpAndSettle();
    expect(find.text('판매글 작성'), findsOneWidget);
    expect(find.text('빈티지 필름 카메라 + 35mm 렌즈'), findsOneWidget);
  });
}
