import 'package:flutter/material.dart';

class errorText extends StatelessWidget {
  final String error;

  const errorText({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}

class errorPage extends StatelessWidget {
  final String error;
  const errorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: errorText(error: error),
    );
  }
}
