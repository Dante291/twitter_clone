import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/failure.dart';
import 'package:twitter_clone/core/type_def.dart';

abstract class iauthAPI {
  FutureEither<User> signUp({required String email, required String password});
}

class AuthAPI implements iauthAPI {
  final Account _account;

  AuthAPI({required Account account}) : _account = account;
  @override
  FutureEither<User> signUp(
      {required String email, required String password}) async {
    try {
      final account =
          _account.create(userId: 'unique()', email: email, password: password);
      return right(account as User);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(e.message!, stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
