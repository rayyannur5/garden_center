import 'package:flutter/material.dart';
import 'package:garden_center/frontend/blog/article_page.dart';
import 'package:garden_center/frontend/beranda/home_page.dart';
import 'package:garden_center/frontend/plant/plant_page.dart';
import 'package:garden_center/frontend/profile/profile_page.dart';
import 'package:garden_center/frontend/widgets/custom_icons_icons.dart';
import 'package:garden_center/frontend/widgets/style.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:statusbarz/statusbarz.dart';

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
    ArticlePage(
      key: Key('tes'),
    ),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          Statusbarz.instance.refresh();
          _index = index;
          setState(() {});
        },
        children: _page,
      ),
      bottomNavigationBar: Material(
        color: AppColor.primary,
        child: Container(
          padding: EdgeInsets.all(10),
          child: GNav(
              padding: EdgeInsets.all(10),
              backgroundColor: AppColor.primary,
              tabBackgroundColor: AppColor.primaryDark,
              duration: const Duration(milliseconds: 300), // tab animation duration
              activeColor: Colors.white,
              color: Colors.white,
              textStyle: AppStyle.paragraphLight,
              gap: 8, // the tab button gap between icon and text
              selectedIndex: _index,
              onTabChange: (index) {
                pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
              },
              tabs: const [
                GButton(
                  icon: CustomIcons.home,
                  iconSize: 20,
                  text: 'Beranda',
                ),
                GButton(
                  icon: CustomIcons.leaf,
                  iconSize: 20,
                  text: 'Tanam',
                ),
                GButton(
                  icon: CustomIcons.blog,
                  iconSize: 20,
                  text: 'Blog',
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
