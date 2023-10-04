import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/providers.dart';

final StorageAPIProvider = Provider((ref) {
  return StorageAPI(storage: ref.watch(appwriteSTORSGEprovider));
});

class StorageAPI {
  final Storage _storage;

  StorageAPI({required Storage storage}) : _storage = storage;

  Future<List<String>> uploadImage(List<File> files) async {
    List<String> imagelinks = [];
    for (final file in files) {
      final uploadedImage = await _storage.createFile(
          bucketId: AppwriteConstants.imagesBUCKET,
          fileId: ID.unique(),
          file: InputFile.fromPath(path: file.path));
      imagelinks.add(AppwriteConstants.imageURl(uploadedImage.$id));
    }
    return imagelinks;
  }
}
