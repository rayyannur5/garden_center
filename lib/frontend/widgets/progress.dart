import 'package:flutter/material.dart';
import 'package:garden_center/frontend/widgets/style.dart';

class Progress extends StatefulWidget {
  var title;
  var desc;
  var img;
  var progress;
  Progress({super.key, required this.title, required this.desc, required this.img, required this.progress});

  @override
  State<Progress> createState() => _ProgressState(title: title, desc: desc, img: img, progress: progress);
}

class _ProgressState extends State<Progress> {
  var title;
  var desc;
  var img;
  var progress;
  bool start = false;
  bool finish = false;
  _ProgressState({
    required this.title,
    required this.desc,
    required this.img,
    required this.progress,
  }) {
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
                    img,
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
