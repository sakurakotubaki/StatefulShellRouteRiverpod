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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Feed',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            ElevatedButton(
              // onPressed: () => context.go('/feed/details'),
              onPressed: () {
                context.go(RouterPath.feedDetails);
              },
              child: const Text('Go to feed/details'),
            ),
          ],
        ),
      ),
    );
  }
}
