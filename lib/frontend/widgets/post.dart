import 'package:flutter/material.dart';
import 'package:garden_center/frontend/blog/post.dart';
import 'package:garden_center/frontend/widgets/navigator.dart';
import 'package:garden_center/frontend/widgets/style.dart';

class Post extends StatelessWidget {
  var user;
  var date;
  var picture;
  var title;
  var desc;
  Post({
    required this.user,
    required this.date,
    required this.picture,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Nav.materialPush(
          context,
          PagePost(
            user: user,
            date: date,
            picture: picture,
            title: title,
            desc: desc,
          )),
      child: Container(
        height: 340,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(color: Color.fromARGB(255, 241, 241, 241), borderRadius: BorderRadius.circular(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(height: 27, width: 27, child: ClipOval(child: Image.network(user['profilePhoto']))),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user['name'], style: AppStyle.miniparagraphBold),
                    Text(date, style: AppStyle.miniparagraph),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Hero(
              tag: title,
              child: Container(
                height: 190,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    image: DecorationImage(image: AssetImage(picture), fit: BoxFit.cover)),
              ),
            ),
            SizedBox(height: 10),
            Text(title, style: AppStyle.miniparagraphBold),
            Text(desc, style: AppStyle.miniparagraph, maxLines: 2, overflow: TextOverflow.ellipsis),
            Row(
              children: [
                Icon(Icons.emoji_emotions_outlined),
                SizedBox(
                  width: 2,
                ),
                Icon(Icons.share),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
