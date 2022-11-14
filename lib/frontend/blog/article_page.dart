import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:garden_center/backend/auth_service.dart';
import 'package:garden_center/backend/user.dart';
import 'package:garden_center/frontend/widgets/post.dart';
import 'package:garden_center/frontend/widgets/style.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
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
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: AppColor.primary,
              ))
        ],
      ),
      body: StreamBuilder<Object>(
          stream: User().getUser(AuthService().user.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Post(
                      user: snapshot.data,
                      date: '16 June, 2022',
                      title: 'Menanam di Tanah vs Hidroponik',
                      picture: 'assets/img/tips-menjaga-tanaman.jpeg',
                      desc:
                          'Tumbuhan memiliki banyak cara untuk dikembangkan Mulai dari menanam di tanah menggunakan pupuk hingga menanam tanpa menggun'),
                  Post(
                      user: snapshot.data,
                      date: '16 June, 2022',
                      title: 'Tips menjaga tanaman agar sealau sehat',
                      picture: 'assets/img/labu.jpeg',
                      desc:
                          'Tumbuhan memiliki banyak cara untuk dikembangkan Mulai dari menanam di tanah menggunakan pupuk hingga menanam tanpa menggun.'),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
