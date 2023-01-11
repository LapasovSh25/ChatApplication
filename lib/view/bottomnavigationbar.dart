import 'package:checkingfile/service/new_service.dart';
import 'package:checkingfile/view/contacts_page.dart';
import 'package:checkingfile/view/conversations_page.dart';
import 'package:checkingfile/view/info_page.dart';
import 'package:checkingfile/view/internet_page.dart';
import 'package:checkingfile/view/main_page.dart';
import 'package:checkingfile/view/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _screens = [
    const MainPage(),
    const ContactsPage(),
    const ConversationPage(),
    const InternetPage(),
    const SettingsPage(),
  ];
  int correntIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[correntIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(
          
          top: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          elevation: 30,
          
          currentIndex: correntIndex,
          selectedItemColor: Color.fromRGBO(102, 108, 121, 1),
          unselectedItemColor: Color.fromRGBO(171, 178, 192, 1),
          type: BottomNavigationBarType.fixed,
          
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/home.png'),
                size: 35,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/group.png'),
                size: 35,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/doublechat.png'),
                size: 35,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/Vector.png'),
                size: 35,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/settings.png'),
                size: 35,
              ),
              label: "",
            ),
          ],
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          onTap: (value) {
            setState(() {
              correntIndex = value;
            });
          },
        ),
      ),
    );
  }
}
