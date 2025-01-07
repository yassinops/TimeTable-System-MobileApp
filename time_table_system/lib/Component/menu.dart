import 'package:flutter/material.dart';
import 'package:time_table_system/Authentication/login.dart';
import 'package:time_table_system/HomePages/time_table.dart';
import 'package:time_table_system/Profile/modify_info.dart';

class Menu extends StatefulWidget {
  const Menu({
    super.key,
    required this.fullName,
    required this.role,
    required this.userId,
    required this.classId,
  });
  final String fullName;
  final String role;
  final int userId;
  final int? classId;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (Route<dynamic> route) => false,
    );
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.fullName + " logged out ")));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 234, 228, 228),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 17, 150, 239),
            ),
            accountName: Text(
              widget.fullName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            accountEmail: Text(
              widget.role,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
          ),
          ListTile(
            title: const Text(
              "Time & Subject",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: const Icon(
              Icons.timer,
              color: Color.fromARGB(255, 23, 125, 208),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TimeTable(
                    fullName: widget.fullName,
                    role: widget.role,
                    userId: widget.userId,
                    classId: widget.classId,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              "Personal Information",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: const Icon(
              Icons.person,
              color: Color.fromARGB(255, 23, 125, 208),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ModifyInfo(
                    userId: widget.userId,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              "Log Out",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: const Icon(
              Icons.logout_sharp,
              color: Color.fromARGB(255, 23, 125, 208),
            ),
            onTap: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }
}
