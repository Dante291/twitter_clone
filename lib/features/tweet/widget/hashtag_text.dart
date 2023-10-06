import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/theme.dart';

class HashtagText extends StatelessWidget {
  final String text;
  const HashtagText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textspan = [];
    text.split(' ').forEach((element) {
      if (element.startsWith('#')) {
        textspan.add(
          TextSpan(
              text: '$element ',
              style: const TextStyle(
                  color: Pallete.blueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        );
      } else if (element.startsWith('www.') || element.startsWith('https://')) {
        textspan.add(
          TextSpan(
              text: '$element ',
              style: const TextStyle(
                color: Pallete.blueColor,
                fontSize: 18,
              )),
        );
      } else {
        textspan.add(
          TextSpan(
              text: '$element ',
              style: const TextStyle(
                color: Pallete.whiteColor,
                fontSize: 18,
              )),
        );
      }
    });
    return RichText(text: TextSpan(children: textspan));
  }
}
