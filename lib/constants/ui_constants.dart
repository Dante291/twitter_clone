import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/features/tweet/widget/tweet_list.dart';
import 'package:twitter_clone/theme/pallete.dart';

import 'asset_constants.dart';

class UIconstants {
  static AppBar appbar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        // ignore: deprecated_member_use
        color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static List<Widget> bottomTabbarPages = [
    const TweetList(),
    Text('notifications'),
    Text('search')
  ];
}
