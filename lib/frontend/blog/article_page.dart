import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garden_center/backend/article.dart';
import 'package:garden_center/backend/auth_service.dart';
import 'package:garden_center/frontend/blog/search.dart';
import 'package:garden_center/frontend/widgets/button.dart';
import 'package:garden_center/frontend/widgets/dialogCard.dart';
import 'package:garden_center/frontend/widgets/navigator.dart';
import 'package:garden_center/frontend/widgets/post.dart';
import 'package:garden_center/frontend/widgets/style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ArticlePage extends StatelessWidget {
  ArticlePage({super.key});

  String path = "";

  Future<String> getImage() async {
    var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    var imageFile = File(image!.path);
    return image.path;
  }

  @override
  Widget build(BuildContext context) {
    File file;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        onPressed: () {
          var userId = AuthService().user.uid;
          buatBlog(context, userId);
        },
        child: Icon(Icons.add),
      ),
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
        title: Text('Blog', style: AppStyle.heading1),
        actions: [
          IconButton(
              onPressed: () => Nav.push(context, SearchPage()),
              icon: Icon(
                Icons.search,
                color: AppColor.primary,
              ))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Article().getAll(),
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
                      desc: data['desc']);
                }).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  void buatBlog(BuildContext context, userId) {
    TextEditingController title = new TextEditingController();
    TextEditingController desc = new TextEditingController();
    DialogCard().call(
        context,
        SizedBox(
          height: 450,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Buat Postingan', style: AppStyle.heading1),
                  IconButton(onPressed: () => Nav.pop(context), icon: Icon(Icons.cancel, color: Colors.grey))
                ],
              ),
              TextField(
                controller: title,
                decoration: InputDecoration(
                  label: Text('Judul', style: AppStyle.heading3grey),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: desc,
                maxLines: 10,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tambahkan ke postingan'),
                    IconButton(
                        onPressed: () async {
                          path = await getImage();
                        },
                        icon: Icon(Icons.add_a_photo_outlined)),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Button(
                      onPressed: () async {
                        var now = DateTime.now();
                        var formatterDate = DateFormat('dd MMMM yyyy');
                        var formatterTime = DateFormat('kk:mm');
                        String actualDate = formatterTime.format(now) + ', ' + formatterDate.format(now);

                        Article().create(title.text, desc.text, actualDate, path);
                        path = "";
                        Nav.pop(context);
                      },
                      height: 40,
                      child: Text('Upload', style: AppStyle.heading3)))
            ],
          ),
        ));
  }
}
