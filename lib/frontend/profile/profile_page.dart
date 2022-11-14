import 'package:flutter/material.dart';
import 'package:garden_center/frontend/profile/my_plant.dart';
import 'package:garden_center/frontend/profile/my_post.dart';
import 'package:garden_center/frontend/profile/setting.dart';
import 'package:garden_center/frontend/widgets/button.dart';
import 'package:garden_center/frontend/widgets/custom_icons_icons.dart';
import 'package:garden_center/frontend/widgets/dialogCard.dart';
import 'package:garden_center/frontend/widgets/navigator.dart';
import 'package:garden_center/frontend/widgets/style.dart';

import 'package:garden_center/backend/auth_service.dart';
import 'package:garden_center/backend/user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        titleTextStyle: AppStyle.paragraph2Light,
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.primary,
        actions: [
          IconButton(
            onPressed: () {},
            iconSize: 40,
            icon: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: const Icon(CustomIcons.notifications, size: 30, color: AppColor.primary)),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: StreamBuilder<dynamic>(
        stream: User().getUser(AuthService().user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Container(
                  height: size.height / 5,
                  color: AppColor.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                        child: ClipOval(child: Image.network(snapshot.data['profilePhoto'])),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(snapshot.data['name'], style: AppStyle.heading1Light),
                          Text(snapshot.data['email'], style: AppStyle.paragraphLight),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(snapshot.data['bio'], style: AppStyle.paragraph, textAlign: TextAlign.center),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Divider(color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black), //style for all textspan
                        children: [
                          TextSpan(text: "3 ", style: AppStyle.paragraphBold),
                          TextSpan(text: "Tanaman", style: AppStyle.paragraph),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black), //style for all textspan
                        children: [
                          TextSpan(text: "10 ", style: AppStyle.paragraphBold),
                          TextSpan(text: "Posts", style: AppStyle.paragraph),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 50),
                menu(CustomIcons.leaf, 'Tanaman', () => Nav.push(context, MyPlant())),
                menu(CustomIcons.blog, 'Postingan', () => Nav.push(context, MyPost())),
                menu(CustomIcons.settings, 'Pengaturan', () => Nav.push(context, Setting())),
                menu(CustomIcons.user_edit, 'Ubah Profil', () {}),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 50),
                    Button(
                      height: 40,
                      color: AppColor.gatau,
                      onPressed: () {
                        DialogCard().call(
                            context,
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Logout ?', style: AppStyle.heading1),
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Button(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          AuthService().signOut();
                                        },
                                        child: Text('Logout', style: AppStyle.paragraphLight)),
                                    SizedBox(width: 10),
                                    Button(
                                        onPressed: () => Navigator.pop(context),
                                        color: AppColor.light,
                                        child: Text('Batal', style: AppStyle.paragraph)),
                                  ],
                                ),
                              ],
                            ));
                      },
                      child: Row(children: [
                        Icon(
                          CustomIcons.logout,
                          color: Colors.black,
                          size: 18,
                        ),
                        Text('Logout', style: AppStyle.paragraph)
                      ]),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget menu(var icon, var title, var onpressed) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: 20),
              Text(title, style: AppStyle.heading3),
            ],
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: Material(
              color: AppColor.light,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onpressed,
                child: const Icon(Icons.navigate_next_rounded),
              ),
            ),
          )
        ],
      ),
    );
  }
}
