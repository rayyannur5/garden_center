import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:garden_center/backend/auth_service.dart';
import 'package:garden_center/backend/user.dart';
import 'package:garden_center/frontend/widgets/navigator.dart';
import 'package:garden_center/frontend/widgets/style.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  TextEditingController nameController = new TextEditingController();
  TextEditingController bioController = new TextEditingController();
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
        actions: [
          IconButton(
              onPressed: () {
                User().reset();
                Nav.pop(context);
              },
              icon: Icon(Icons.lock_reset, color: AppColor.primary))
        ],
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
            Text('Ubah Profil', style: AppStyle.heading1),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 33),
        height: 50,
        child: Material(
          borderRadius: BorderRadius.circular(25),
          elevation: 10,
          color: AppColor.primary,
          child: InkWell(
            onTap: () {
              Future.delayed(Duration(microseconds: 100), () {
                User().update(nameController.text, bioController.text, AuthService().user.photoURL!);
                Nav.pop(context);
              });
            },
            child: Center(
              child: Text(
                "Simpan",
                style: TextStyle(fontFamily: "Poppins", color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<dynamic>(
          stream: User().getUser(AuthService().user.uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            nameController.text = snapshot.data['name'];
            bioController.text = snapshot.data['bio'];
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  Text('Nama', style: AppStyle.heading1),
                  TextField(
                    controller: nameController,
                  ),
                  SizedBox(height: 20),
                  Text('Bio', style: AppStyle.heading1),
                  TextField(
                    controller: bioController,
                  )
                ],
              ),
            );
          }),
    );
  }
}
