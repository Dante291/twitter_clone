import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/asset_constants.dart';
import 'package:twitter_clone/theme/pallete.dart';

class TweetIcons extends StatelessWidget {
  final String pathname;
  final String text;
  final VoidCallback onTap;
  const TweetIcons(
      {super.key,
      required this.pathname,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            pathname,
            color: Pallete.greyColor,
          ),
          Container(
              margin: EdgeInsets.only(
                  right: 10,
                  top: (pathname == AssetsConstants.viewsIcon ? 6 : 0),
                  left: 1),
              child: Text(
                text,
                style: const TextStyle(fontSize: 16, color: Pallete.greyColor),
              ))
        ],
      ),
    );
  }
}
