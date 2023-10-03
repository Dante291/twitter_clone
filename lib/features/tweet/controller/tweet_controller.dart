import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/tweet_api.dart';
import 'package:twitter_clone/core/enums/tweet_type_enum.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';

final TweetControllerProvider =
    StateNotifierProvider<TweeetController, bool>((ref) {
  return TweeetController(ref: ref, tweetapi: ref.watch(tweetApiProvider));
});

class TweeetController extends StateNotifier<bool> {
  final TweetAPI _tweetApi;
  final Ref _ref;
  TweeetController({required Ref ref, required TweetAPI tweetapi})
      : _ref = ref,
        _tweetApi = tweetapi,
        super(false);

  void _shareimageTweet(
      {required List<File> images,
      required String text,
      required BuildContext context}) {}

  void _shareTextTweet({
    required String text,
    required BuildContext context,
  }) async {
    state = true;
    final hashtags = _getHashtagsFromText(text);
    String link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    Tweet tweet = Tweet(
        text: text,
        hashtags: hashtags,
        link: link,
        imageLinks: [],
        uid: user.uid,
        tweetType: TweetType.text,
        tweetedAt: DateTime.now(),
        likes: [],
        commentIds: [],
        id: '',
        reshareCount: 0,
        retweetedBy: '',
        repliedTo: '');
    final res = await _tweetApi.shareTweet(tweet);
    state = false;
    res.fold((l) => showsnackbar(context, l.message), (r) => null);
  }

  void shareTweet(
      {required List<File> images,
      required String text,
      required BuildContext context}) {
    if (text.isEmpty) {
      showsnackbar(context, 'please enter text');
      return;
    }
    if (images.isNotEmpty) {
      _shareimageTweet(images: images, text: text, context: context);
    } else {
      _shareTextTweet(text: text, context: context);
    }
  }

  String _getLinkFromText(String text) {
    String link = '';
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('https://') || word.startsWith('www.')) {
        link = word;
      }
    }
    return link;
  }

  List<String> _getHashtagsFromText(String text) {
    List<String> hashtags = [];
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('#')) {
        hashtags.add(word);
      }
    }
    return hashtags;
  }
}
