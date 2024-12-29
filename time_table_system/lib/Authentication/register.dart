import 'package:flutter/material.dart';
import 'package:time_table_system/Authentication/login.dart';
import 'package:time_table_system/services/auth_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService _registerService = AuthService();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _registerService.register(
          _firstNameController.text,
          _lastNameController.text,
          _emailController.text,
          _passwordController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Registration successful'),
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
        child: Center(
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo_iset.jpg",
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 90),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("create Account");
                    },
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                          color: Colors.blue[400],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 120,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder:(context)=> Login()));
                    },
                    child: const Text("Login",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Full Name",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start),
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 246, 181, 19))),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter your first name'
                          : null,
                    ),
                    const SizedBox(height: 10),
                    const Text("Last Name",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color:Color.fromARGB(255, 246, 181, 19)),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric( vertical: 8),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter your last name'
                          : null,
                    ),
                    const SizedBox(height: 10),
                    const Text("Email",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 246, 181, 19)),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter your email'
                          : null,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Password",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          ? 'Password must be at least 8 characters'
                          : null,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(320, 49),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(90, 95, 231, 231),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  _register();
                  print('register');
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
