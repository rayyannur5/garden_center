import 'package:flutter/material.dart';
import 'package:garden_center/frontend/widgets/style.dart';

class PagePost extends StatelessWidget {
  var user;
  var date;
  var picture;
  var title;
  var desc;
  PagePost({
    required this.user,
    required this.date,
    required this.picture,
    required this.title,
    required this.desc,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(title, style: AppStyle.heading1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(title, style: AppStyle.heading1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(user['name'] + '/' + date, style: AppStyle.paragraph),
          ),
          Hero(
            tag: title,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                  image: DecorationImage(image: AssetImage(picture), fit: BoxFit.cover)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(desc, style: AppStyle.paragraph),
          ),
        ],
      ),
    );
  }
}
