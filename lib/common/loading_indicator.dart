import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class loader extends StatelessWidget {
  const loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: Pallete.blueColor,
    ));
  }
}

class loadingPage extends StatelessWidget {
  const loadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: loader(),
    );
  }
}
