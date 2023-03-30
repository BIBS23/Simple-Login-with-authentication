import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:soccestalentz/Screens/create_post.dart';
import 'package:soccestalentz/Screens/home.dart';
import 'package:soccestalentz/Screens/profile.dart';

class CustomNavigatonBar extends StatefulWidget {
  const CustomNavigatonBar({super.key});

  @override
  State<CustomNavigatonBar> createState() => _HomeState();
}

class _HomeState extends State<CustomNavigatonBar> {
  int currentscreen = 0;
  List<Widget> screens = const [HomeScreen(), Placeholder(), CreateProfile()];

  void itemTapped(int index) {
    setState(() {
      if (index == 1) {
        ShowModalWidget.showModal(context);
      } else {
        currentscreen = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: screens[currentscreen]),
      backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: CircleNavBar(
          onTap: itemTapped,
          activeIndex: currentscreen,
          activeIcons: const [
            Icon(Icons.home_filled, color: Colors.white),
            Icon(Icons.add, color: Colors.white),
            Icon(Icons.person_4_rounded, color: Colors.white)
          ],
          inactiveIcons: const [
            Text('Home', style: TextStyle(color: Colors.white)),
            Text('Add post', style: TextStyle(color: Colors.white)),
            Text('My Profile', style: TextStyle(color: Colors.white))
          ],
          height: 60,
          circleWidth: 60,
          color: Colors.blueAccent.shade200),
    );
  }
}
