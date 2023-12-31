import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/models/tweet_model.dart';

final tweetApiProvider = Provider((ref) {
  return TweetAPI(db: ref.watch(appwriteDATABSEprovider));
});

abstract class ItweetApi {
  FutureEither<Document> shareTweet(Tweet tweet);
  Future<List<Document>> getTweeet();
}

class TweetAPI implements ItweetApi {
  final Databases _db;

  TweetAPI({required Databases db}) : _db = db;
  @override
  FutureEither<Document> shareTweet(Tweet tweet) async {
    try {
      final document = await _db.createDocument(
          databaseId: AppwriteConstants.databaseID,
          collectionId: AppwriteConstants.TweetCollectionID,
          documentId: ID.unique(),
          data: tweet.toMap());
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message!, st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<Document>> getTweeet() async {
    final document = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.TweetCollectionID);
    return document.documents;
  }
}
