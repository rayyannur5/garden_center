import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garden_center/backend/plant.dart';
import 'package:garden_center/frontend/plant/menu_plant.dart';
import 'package:garden_center/frontend/widgets/navigator.dart';
import 'package:garden_center/frontend/widgets/style.dart';

class MyPlant extends StatefulWidget {
  const MyPlant({super.key});

  @override
  State<MyPlant> createState() => _MyPlantState();
}

class _MyPlantState extends State<MyPlant> {
  bool start = false;
  bool finish = false;
  _MyPlantState() {
    Future.delayed(
      Duration(milliseconds: 100),
      () {
        setState(() {
          start = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Map datagambar = {
      'Cabai': 'assets/img/cabai.png',
      'Tomat': 'assets/img/tomat.png',
      'Bayam Hijau': 'assets/img/bayamhijau.png',
      'Bawang Putih': 'assets/img/bawangputih.png',
      'Bawang Merah': 'assets/img/bawangmerah.png',
      'Kangkung': 'assets/img/kangkung.png',
      'Kentang': 'assets/img/kentang.png',
      'Wortel': 'assets/img/wortel.png',
    };
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
            Text('Tanamanku', style: AppStyle.heading1),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Plant().getMyPlant(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // print(snapshot.data);
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  print('ts');
                  print(data);
                  return FutureBuilder<dynamic>(
                      future: Plant().getPlant(data['plant']),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else
                          return cardTanaman(data['id'], size, datagambar[snapshot.data['name']], snapshot.data['name'],
                              snapshot.data['latin'], data['progress']);
                      });
                }).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget cardTanaman(var id, var size, var image, var title, var desc, double progress) {
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Container(
            width: size.width,
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: AppColor.gatau,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              onEnd: () {
                finish = true;
                setState(() {});
              },
              height: 100,
              width: start ? (size.width - 40) * progress / 100 : 0,
              decoration: BoxDecoration(
                color: AppColor.light,
                borderRadius: progress == 100 && finish == true
                    ? BorderRadius.circular(25)
                    : BorderRadius.only(topLeft: Radius.circular(25), bottomLeft: Radius.circular(25)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: Image.asset(
                      image,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(title, style: AppStyle.heading2),
                      Text('$desc\nProgress ' + progress.toStringAsFixed(2) + '%', style: AppStyle.miniparagraph),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 100,
                  margin: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.navigate_next,
                    size: 40,
                  ),
                ),
              )
            ],
          ),
          Container(
            height: 100,
            margin: EdgeInsets.only(top: 20),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () {
                  Future.delayed(
                      Duration(milliseconds: 150),
                      () => Nav.push(
                          context,
                          MenuPlant(
                            id: id,
                            name: title,
                          )));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
