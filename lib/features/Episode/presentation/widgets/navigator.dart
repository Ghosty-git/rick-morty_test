import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  void goToBranch(int index){
    widget.navigationShell.goBranch(index, initialLocation: index == widget.navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.white,
        onButtonPressed: (index) {
          setState(() {
            selectedIndex = index;
          });
          goToBranch(selectedIndex);
        },
        iconSize: 30,
        activeColor: Colors.green,
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            icon: Icons.people,
            title: 'Character',
          ),
          BarItem(
            icon: Icons.tv,
            title: 'Episode',
          ),
        ],
      ),
    );
  }
}
