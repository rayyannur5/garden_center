import 'dart:ui';

import 'package:flutter/material.dart';
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
          print('masuk sini');
          start = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text('Sedang Ditanam', style: AppStyle.heading3),
          ),
          cardTanaman(size, 'assets/img/jagung.png', 'jagung', 'Umur panen 3 bulan', 50),
          cardTanaman(size, 'assets/img/sawi.png', 'Sawi', 'Umur panen 1 bulan', 60),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text('Selesai', style: AppStyle.heading3),
          ),
          cardTanaman(size, 'assets/img/tomat.png', 'Tomat', 'Umur panen 1 bulan', 100),
        ],
      ),
    );
  }

  Widget cardTanaman(var size, var image, var title, var desc, var progress) {
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
                print('msuk finish');
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
                  Image.asset(
                    image,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(title, style: AppStyle.heading1),
                      Text('$desc\nProgress $progress%', style: AppStyle.miniparagraph),
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
                onTap: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
