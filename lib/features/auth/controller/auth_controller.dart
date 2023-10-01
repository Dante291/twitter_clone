import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/core/utils.dart';

import '../../../models/user_model.dart';
import '../view/login_view.dart';

final authControllerProvider =
    StateNotifierProvider<authController, bool>((ref) {
  return authController(
      authAPI: ref.watch(authAPIprovider), userapi: ref.watch(userAPIprovider));
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserID = ref.watch(currentuseraccountProvider).value!.$id;
  final userDetails = ref.watch(userdetailsProvider(currentUserID));
  return userDetails.value;
});

final userdetailsProvider = FutureProvider.family((ref, String uID) {
  final authcontroller = ref.watch(authControllerProvider.notifier);
  return authcontroller.getUserData(uID);
});

final currentuseraccountProvider = FutureProvider((ref) {
  final authcontroller = ref.watch(authControllerProvider.notifier);
  return authcontroller.currentuser();
});

class authController extends StateNotifier<bool> {
  final AuthAPI _authapi;
  final userAPI _userApi;
  authController({required AuthAPI authAPI, required userAPI userapi})
      : _authapi = authAPI,
        _userApi = userapi,
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
    }, (r) async {
      UserModel userModel = UserModel(
          email: email,
          name: getnamefromemail(email),
          followers: [],
          following: [],
          profilePic: '',
          bannerPic: '',
          uid: r.$id,
          bio: '',
          isTwitterBlue: false);
      final res2 = await _userApi.saveUserdata(userModel);
      res2.fold((l) {
        showsnackbar(context, l.message);
      }, (r) {
        showsnackbar(context, 'Account created successfully');
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const loginView(),
        ));
      });
    });
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

  Future<UserModel> getUserData(String uID) async {
    try {
      final document = await _userApi.getuserData(uID);
      final updatedUser = UserModel.fromMap(document.data);
      return updatedUser;
    } catch (e) {
      throw e;
    }
  }
}
