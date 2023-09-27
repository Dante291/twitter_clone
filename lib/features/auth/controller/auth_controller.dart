import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/core/utils.dart';

final authControllerProvider =
    StateNotifierProvider<authController, bool>((ref) {
  return authController(authAPI: ref.watch(authAPIprovider));
});

final currentuseraccountProvider = FutureProvider((ref) async {
  final authcontroller = ref.watch(authControllerProvider.notifier);
  return authcontroller.currentuser();
});

class authController extends StateNotifier<bool> {
  final AuthAPI _authapi;
  authController({required AuthAPI authAPI})
      : _authapi = authAPI,
        super(false);
  Future<User?> currentuser() => _authapi.cuurentuserAccount();

  void signUP(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authapi.signUp(email: email, password: password);
    state = false;
    res.fold((l) {
      showsnackbar(context, l.message);
    }, (r) => print(r.email));
  }

  void logIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authapi.logIn(email: email, password: password);
    state = false;
    res.fold((l) {
      showsnackbar(context, l.message);
    }, (r) => print(r.userId));
  }
}
