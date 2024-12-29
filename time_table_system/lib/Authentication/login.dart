import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(context) {
    return const Scaffold(
      body: Text('login page'),
    );
  }
}
