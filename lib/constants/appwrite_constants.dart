class AppwriteConstants {
  static const String databaseID = '65119f47d122b1d6eafc';
  static const String projectID = '64fd5ef10466d51c8135';
  static const String endPoint = 'http://192.168.1.13:80/v1';
  static const String userCollectionID = '651845b4dc32c21ca1f3';

  static const String TweetCollectionID = '651c54a951ee374b73e3';

  static const String imagesBUCKET = '651c74535e27682f6ad4';

  static String imageURl(String imageID) =>
      '$endPoint/storage/buckets/$imagesBUCKET/files/$imageID/view?project=$projectID&mode=admin';
}
