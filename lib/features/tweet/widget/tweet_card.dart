import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/core/enums/tweet_type_enum.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/widget/carousel_image.dart';
import 'package:twitter_clone/features/tweet/widget/hashtag_text.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../../common/common.dart';
import 'package:timeago/timeago.dart' as timeago;

class TweetCard extends ConsumerWidget {
  final Tweet _tweet;
  const TweetCard({super.key, required Tweet tweet}) : _tweet = tweet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userdetailsProvider(_tweet.uid)).when(
        data: (user) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePic),
                      radius: 25,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //retweeted,
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Text(
                                user.name,
                                style: const TextStyle(
                                    color: Pallete.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              ' @${user.name} · ${timeago.format(_tweet.tweetedAt, locale: 'en_short')}',
                              style: const TextStyle(
                                color: Pallete.greyColor,
                                fontSize: 17,
                              ),
                            )
                          ],
                        ),
                        //replied to
                        HashtagText(text: _tweet.text),
                        if (_tweet.tweetType == TweetType.image)
                          CarouselImage(imagelinks: _tweet.imageLinks),
                        if (_tweet.link.isNotEmpty) ...[
                          AnyLinkPreview(link: 'https://${_tweet.link}')
                        ]
                      ],
                    ),
                  )
                ],
              )
            ],
          );
        },
        error: (error, stackTrace) {
          return errorText(error: error.toString());
        },
        loading: () => const loader());
  }
}
