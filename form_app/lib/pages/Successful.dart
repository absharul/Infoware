import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessfulPage extends StatelessWidget {
  const SuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Succefully Saved"),
      ),
    );
  }
}
