import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garden_center/backend/article.dart';
import 'package:garden_center/frontend/widgets/navigator.dart';
import 'package:garden_center/frontend/widgets/post.dart';
import 'package:garden_center/frontend/widgets/style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController input = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        toolbarHeight: 100,
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
            Flexible(
              child: TextField(
                controller: input,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  label: Text('Ketik disini'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            )
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Article().search(input.text),
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
}
