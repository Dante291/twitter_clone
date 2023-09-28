import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final appbar = UIconstants.appbar();
    return Scaffold(
      appBar: appbar,
    );
  }
}
