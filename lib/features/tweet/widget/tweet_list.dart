import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/widget/tweet_card.dart';
import 'package:twitter_clone/theme/pallete.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetProvider).when(
        data: (tweets) {
          return Column(
            children: [
              const Divider(
                color: Pallete.greyColor,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final tweet = tweets[index];
                    return TweetCard(tweet: tweet);
                  },
                  itemCount: tweets.length,
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          return errorText(error: error.toString());
        },
        loading: () => const loader());
  }
}
