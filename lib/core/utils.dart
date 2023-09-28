import 'package:flutter/material.dart';

void showsnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

String getnamefromemail(String email) {
  return email.split('@')[0];
}
