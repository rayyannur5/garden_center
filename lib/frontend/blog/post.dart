import 'package:flutter/material.dart';
import 'package:garden_center/backend/user.dart';
import 'package:garden_center/frontend/widgets/navigator.dart';
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
      body: StreamBuilder<dynamic>(
          stream: User().getUser(user),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
            return ListView(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SizedBox(
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
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(title, style: AppStyle.heading1),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(snapshot.data['name'] + '/' + date, style: AppStyle.paragraph),
                ),
                Hero(
                  tag: title,
                  child: picture != ""
                      ? Container(
                          margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
                          height: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                              image: DecorationImage(image: NetworkImage(picture), fit: BoxFit.cover)),
                        )
                      : SizedBox(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(desc, style: AppStyle.paragraph),
                ),
              ],
            );
          }),
    );
  }
}
