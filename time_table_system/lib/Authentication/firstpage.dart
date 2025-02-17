import 'package:flutter/material.dart';
import 'package:time_table_system/Authentication/login.dart';
import 'package:time_table_system/Authentication/register.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  
  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 80),
          color: const Color.fromARGB(255, 248, 246, 246),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo_iset.jpg',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "Easily check your study timetable,stay organized,",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Text(
                "and make the most of your time.",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[400],
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Register()),
                  );
                  print('button pressed');
                },
                child: const Text("Create Account"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(90, 95, 231, 231),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 85),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: const Text("Login"),
              ),
              const SizedBox(height: 40),
              RichText(
                textAlign: TextAlign.center,
                text:const TextSpan(
                  text: "By logging In Or Registering, You have to Agreed to ",
                  style: TextStyle(color: Colors.black, fontSize: 10,),
                  
                  children: [
                    TextSpan(
                        text: "the terms And Conditions",
                        style: TextStyle(
                            color: Color.fromARGB(255, 246, 181, 19))),
                    TextSpan(text: " And ", style: TextStyle(color: Colors.black,fontSize: 10)),
                    TextSpan(text: "Privacy Policy",style: TextStyle(color: Color.fromARGB(255, 246, 181, 19),fontSize: 10)),
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
