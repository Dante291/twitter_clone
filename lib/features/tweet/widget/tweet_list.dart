import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetProvider).when(
        data: (tweets) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tweet = tweets[index];
              return Text(tweet.text);
            },
            itemCount: tweets.length,
          );
        },
        error: (error, stackTrace) {
          return errorText(error: error.toString());
        },
        loading: () => const loader());
  }
}
