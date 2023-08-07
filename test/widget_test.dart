// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router_stateful/app_widget.dart';

void main() {
  testWidgets('GoRouterで画面遷移ができるかのテスト', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MyApp(),
      ),
    );
    // FeedPageが表示されていることを確認
    expect(find.byKey(Key('feedPage')), findsOneWidget);

    await tester.tap(find.byKey(Key('addIcon')));// tester.tapは、WidgetTesterのメソッドです。find.bykeyは、KeyでWidgetを検索するメソッドです。
    await tester.pump();// tester.pumpは、WidgetTesterのメソッドです。Widgetの描画を更新します。

    await tester.tap(find.byKey(Key('feed_details_button')));
    await tester.pump();
  });
}
