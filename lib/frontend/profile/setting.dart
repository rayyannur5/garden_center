import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garden_center/backend/setting.dart';
import 'package:garden_center/frontend/widgets/navigator.dart';
import 'package:garden_center/frontend/widgets/style.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  _SettingState() {}

  bool notifikasi = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: Material(
                color: AppColor.light,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => Nav.pop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      padding: const EdgeInsets.all(3),
                      child: const Icon(Icons.navigate_before_rounded, size: 30, color: AppColor.primary)),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text('Pengaturan', style: AppStyle.heading1),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 70,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(color: AppColor.grey, borderRadius: BorderRadius.circular(25)),
            child: Center(
                child: ListTile(
              leading: const Icon(Icons.notifications),
              minLeadingWidth: 0,
              title: Text('Notifikasi', style: AppStyle.heading2thin),
              trailing: CupertinoSwitch(
                value: notifikasi,
                onChanged: (value) {
                  setState(() {});
                },
              ),
            )),
          ),
        ],
      ),
    );
  }
}
