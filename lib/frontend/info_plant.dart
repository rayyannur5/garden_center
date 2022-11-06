import 'package:flutter/material.dart';

class InfoPlant extends StatelessWidget {
  final String title;
  final String desc;
  final String img;
  const InfoPlant({super.key, required this.title, required this.desc, required this.img});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Hero(
            tag: title,
            child: Container(
              height: size.height / 4,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(img)),
              ),
            ),
          ),
          Text(title),
          Text(desc)
        ],
      ),
    );
  }
}
