# go_router_stateful

## ボトムナビゲーションバーの使用例
```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar(this.navigationShell, {super.key});

  /// ブランチ・ナビゲーターのナビゲーション・シェルとコンテナ。
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,// body: navigationShellは、IndexedStackをラップしています。
      bottomNavigationBar: BottomNavigationBar(// bottomNavigationBar: BottomNavigationBarは、ボトムナビゲーションバーを実装しています。
        currentIndex: navigationShell.currentIndex,// currentIndex: navigationShell.currentIndexは、現在のインデックスを取得しています。
        items: const [
          // BottomNavigationBarItemは、ボトムナビゲーションバーのアイテムを実装しています。
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shope'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: _onTap,
      ),
    );
  }
  // _onTapメソッドは、ボトムナビゲーションバーのアイテムをタップしたときに、
  // そのアイテムのインデックスを取得して、そのインデックスに対応するブランチにナビゲートします。
  void _onTap(index) {
    navigationShell.goBranch(
      index,
      // ボトムナビゲーションバーを使用する際の一般的なパターンは、次のようなものです。
      // 既にアクティブになっているアイテムをタップしたときに、最初の場所に移動することをサポートすることです。
      // この例では、この動作をサポートする方法を示します。この例では、この動作をサポートする方法を示します、
      // goBranchのinitialLocationパラメータを使用します。
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
```

## StatefulShellRouteの使用例
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_stateful/common/router_path.dart';
import 'package:go_router_stateful/modules/details/details_page.dart';
import 'package:go_router_stateful/modules/feed/feed_page.dart';

import '../modules/scaffold_with_navbar/scaffold_with_navbar.dart';

// このGlobalKeyは、GoRouterのインスタンスを取得するために必要です。
final _rootNavigatorKey = GlobalKey<NavigatorState>();
// このGlobalKeyは、各タブのGoRouterインスタンスを取得するために必要です。
final _sectionNavigatorKey = GlobalKey<NavigatorState>();
// このProviderは、GoRouterのインスタンスを取得するために必要です。
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,// navigatorKeyとは、GoRouterのインスタンスを取得するために必要です。
    initialLocation: RouterPath.feed,// initialLocationは、アプリの最初のルートを指定します。
    routes: <RouteBase>[
      // StatefulShellRouteとは、GoRouterのルートを状態管理するためのものです。
      // indexedStackとは、StatefulShellRouteの一種で、
      // この場合、StatefulShellRouteは、IndexedStackをラップしています。
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // カスタムシェル（BottomNavigationBar など）を実装したウィジェットを返します。
          // ステートフルな方法で他のブランチにナビゲートできるように、 // [StatefulNavigationShell] が渡されます。
          return ScaffoldWithNavbar(navigationShell);
        },
        // branchesとは、IndexedStackの子ウィジェットとして表示されるGoRouterのブランチを指定します。
        branches: [
          // ボトムナビゲーションバーのルート分岐1
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorKey,
            // このブランチルートを追加する
            // 各ルートとそのサブルート (利用可能な場合) 例: feed/uuid/details
            routes: <RouteBase>[
              GoRoute(
                path: RouterPath.feed,
                builder: (context, state) => const FeedPage(),
                routes: <RouteBase>[
                  GoRoute(
                    path: RouterPath.details,
                    builder: (context, state) {
                      return const DetailsPage(label: 'FeedDetailsをFullPathで渡す');
                    },
                  )
                ],
              ),
            ],
          ),
          // ボトムナビゲーションバーのルート分岐2
          StatefulShellBranch(routes: <RouteBase>[
            // このブランチルートを追加する
            // 各ルートとそのサブルート (利用可能な場合) 例: shope/uuid/details
            GoRoute(
              path: RouterPath.shope,
              builder: (context, state) {
                return const DetailsPage(label: 'Shope');
              },
            ),
          ]),
          // ボトムナビゲーションバーのルート分岐3を追加
          StatefulShellBranch(routes: <RouteBase>[
            // このブランチルートを追加する
            // 各ルートとそのサブルート (利用可能な場合) 例: profile/uuid/details
            GoRoute(
              path: RouterPath.profile,
              builder: (context, state) {
                return const DetailsPage(label: 'Profile');
              },
            ),
          ]),
        ],
      ),
    ],
  );
});
```