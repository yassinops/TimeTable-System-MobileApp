import 'package:flutter/material.dart';
import 'package:time_table_system/Authentication/register.dart';
import 'package:time_table_system/HomePages/time_table.dart';
import 'package:time_table_system/services/loginauth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final LoginauthService _logService = LoginauthService();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        final userData = await _logService.login(
            _emailController.text, _passwordController.text);
            if (userData['role'] == "ADMIN") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Admin has no Access to the Mobile App"),
            ),
          );
        } else if (userData['role'] == "TEACHER") {
          ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(
              content: Text("TEACHER can only check timetable on the website"),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TimeTable(
                fullName: userData['fullName'],
                role: userData['role'],
                userId: userData['userId'],
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("loged successfully"),
          ),
        );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/logo_iset.jpg',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 120,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text("Login",
                        style: TextStyle(
                          color: Colors.blue[400],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text("Email address",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 246, 181, 19))),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter your email'
                          : null,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 246, 181, 19)),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      validator: (value) => value == null || value.length < 8
                          ? 'Enter your Password '
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("forget password");
                      },
                      child: const Text(
                        "Forget Password?",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 61, 145, 213),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(320, 49),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(90, 95, 231, 231),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 80, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    _login();
                    print("user logged in successfuly");
                  },
                  child: const Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
