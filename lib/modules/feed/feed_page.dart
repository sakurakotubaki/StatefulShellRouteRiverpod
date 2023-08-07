import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_stateful/common/router_path.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key, this.label, this.child});

  final String? label;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('feedPage'),
      appBar: AppBar(
        title: Text(label ?? 'Feed'),
        actions: [
          IconButton(
              key: const Key('addIcon'),
              onPressed: () {},
              icon: Icon(Icons.add)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Feed',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            ElevatedButton(
              key: const Key('feed_details_button'),
              onPressed: () {
                context.go(RouterPath.feedDetails);
              },
              child: const Text('Go to feed/details'),
            ),
            ElevatedButton(
                key: const Key('call_button'),// このキーを使ってテストを実行する
                onPressed: () {
                  print('call');
                },
                child: const Text('call'))
          ],
        ),
      ),
    );
  }
}
