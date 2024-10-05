import 'package:flutter/material.dart';
import '../resume/saved_resume_screen.dart';

class SideBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  SideBar({required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: _menuItems
            .map((item) => ListTile(
                  onTap: () {
                    if (item == 'Saved Resumes') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SavedResumeScreen(),
                        ),
                      );
                    } else {
                      scaffoldKey.currentState?.openEndDrawer();
                    }
                  },
                  title: Text(item),
                ))
            .toList(),
      ),
    );
  }
}

// Daftar menu item
final List<String> _menuItems = <String>[
  'About',
  'Contact',
  'Settings',
  'Sign Out',
  'Saved Resumes',
];
