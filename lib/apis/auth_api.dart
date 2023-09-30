import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/failure.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/core/type_def.dart';

final authAPIprovider = Provider((ref) {
  return AuthAPI(account: ref.watch(appwriteACCOUNTprovider));
});

abstract class iauthAPI {
  FutureEither<User> signUp({required String email, required String password});
  FutureEither<Session> logIn(
      {required String email, required String password});
  Future<User?> cuurentuserAccount();
}

class AuthAPI implements iauthAPI {
  final Account _account;

  AuthAPI({required Account account}) : _account = account;

  @override
  Future<User?> cuurentuserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<User> signUp(
      {required String email, required String password}) async {
    try {
      final account = await _account.create(
          userId: 'unique()', email: email, password: password);
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(e.message!, stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<Session> logIn(
      {required String email, required String password}) async {
    try {
      final session =
          await _account.createEmailSession(email: email, password: password);
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(e.message!, stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
