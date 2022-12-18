import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(213, 255, 254, 254),
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Color.fromARGB(213, 255, 254, 254),
          color: Colors.black,
        ),
      ),
    );
  }
}
