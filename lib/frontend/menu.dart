import 'package:flutter/material.dart';
import 'package:garden_center/frontend/article_page.dart';
import 'package:garden_center/frontend/home_page.dart';
import 'package:garden_center/frontend/plant_page.dart';
import 'package:garden_center/frontend/profile_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _index = 0;
  PageController pageController = PageController(initialPage: 0);
  List<Widget> _page = [
    HomePage(),
    PlantPage(),
    ArticlePage(),
    ProfilePage("a")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade800,
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            _index = index;
          });
        },
        children: _page,
      ),
      bottomNavigationBar: Material(
        color: Colors.green.shade800,
        child: Container(
          padding: EdgeInsets.all(10),
          child: GNav(
              padding: EdgeInsets.all(10),
              backgroundColor: Colors.green.shade800,
              tabBackgroundColor: Colors.green.shade900,
              duration: Duration(milliseconds: 300), // tab animation duration
              activeColor: Colors.white,
              color: Colors.white,
              textStyle: TextStyle(fontFamily: 'Poppins', color: Colors.white),
              gap: 8, // the tab button gap between icon and text
              selectedIndex: _index,
              onTabChange: (index) {
                pageController.animateToPage(index,
                    duration: Duration(milliseconds: 300), curve: Curves.ease);
              },
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Beranda',
                ),
                GButton(
                  icon: Icons.energy_savings_leaf,
                  text: 'Tanam',
                ),
                GButton(
                  icon: Icons.article,
                  text: 'Artikel',
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: 'Profil',
                )
              ]),
        ),
      ),
    );
  }
}
