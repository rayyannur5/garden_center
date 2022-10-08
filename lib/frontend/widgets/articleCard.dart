import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  String title;
  String desc;
  String author;
  String img;
  ArticleCard(
      {required this.title,
      required this.desc,
      required this.author,
      required this.img});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Container(
          height: 200,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(img),
          )),
        ),
        ListTile(
          title: Text(title),
          subtitle: Text(
            desc,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ]),
    );
  }
}
