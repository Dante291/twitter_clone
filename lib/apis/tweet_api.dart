import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/models/tweet_model.dart';

abstract class ItweetApi {
  FutureEither<Document> shareTweet(Tweet tweet);
}

class TweetAPI implements ItweetApi {
  final Databases _db;

  TweetAPI({required Databases db}): _db=db;
  @override
  FutureEither<Document> shareTweet(Tweet tweet) async {
    try{
      await _db.createDocument(databaseId: AppwriteConstants.databaseID, collectionId: AppwriteConstants.TweetCollectionID, documentId: documentId, data: data)
    }
     
  }
}
