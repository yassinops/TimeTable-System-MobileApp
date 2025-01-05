import 'package:flutter/material.dart';
import 'package:time_table_system/services/update_service.dart';

class ModifyInfo extends StatefulWidget {
  const ModifyInfo({super.key, required this.userId});
  final int userId;

  @override
  State<ModifyInfo> createState() => _ModifyInfoState();
}

class _ModifyInfoState extends State<ModifyInfo> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final UpdateService _updateService = UpdateService();

  Future<void> _UpdateStudent() async {
    if (_formKey.currentState!.validate()) {
      final isSuccess = await _updateService.updateStudent(
        userId: widget.userId,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Information updated successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update information')),
        );
      }
    }
  }

  @override
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modify Personal Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                "assets/images/logo_iset.jpg",
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 50),
              const Text("First Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Color.fromARGB(255, 246, 181, 19)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your full name' : null,
              ),
              const SizedBox(height: 10),
              const Text("Last Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Color.fromARGB(255, 246, 181, 19)),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your last name' : null,
              ),
              const SizedBox(height: 10),
              const Text("Email",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Color.fromARGB(255, 246, 181, 19)),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your email' : null,
              ),
              const SizedBox(height: 10),
              const Text(
                "Password",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Color.fromARGB(255, 246, 181, 19)),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
                validator: (value) => value == null || value.length < 8
                    ? 'Password must be at least 8 characters'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(320, 49),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(90, 95, 231, 231),
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _UpdateStudent,
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}