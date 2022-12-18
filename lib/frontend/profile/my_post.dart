import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garden_center/backend/article.dart';
import 'package:garden_center/backend/auth_service.dart';
import 'package:garden_center/backend/user.dart';
import 'package:garden_center/frontend/widgets/navigator.dart';
import 'package:garden_center/frontend/widgets/post.dart';
import 'package:garden_center/frontend/widgets/style.dart';
import 'package:statusbarz/statusbarz.dart';

class MyPost extends StatelessWidget {
  MyPost({super.key}) {
    Statusbarz.instance.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white.withAlpha(200),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        elevation: 0,
        title: Row(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: Material(
                color: AppColor.light,
                shape: CircleBorder(),
                child: InkWell(
                  onTap: () => Nav.pop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      padding: const EdgeInsets.all(3),
                      child: const Icon(Icons.navigate_before_rounded, size: 30, color: AppColor.primary)),
                ),
              ),
            ),
            SizedBox(width: 20),
            Text('Postinganku', style: AppStyle.heading1),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Article().get(AuthService().user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                return Post(
                    id: data['id'],
                    user: data['user'],
                    date: data['date'],
                    picture: data['picture'],
                    title: data['title'],
                    desc: data['desc'],
                    isDelete: true);
              }).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
