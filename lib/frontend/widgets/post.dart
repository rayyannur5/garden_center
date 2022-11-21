import 'package:flutter/material.dart';
import 'package:garden_center/backend/article.dart';
import 'package:garden_center/backend/user.dart';
import 'package:garden_center/frontend/blog/post.dart';
import 'package:garden_center/frontend/widgets/button.dart';
import 'package:garden_center/frontend/widgets/dialogCard.dart';
import 'package:garden_center/frontend/widgets/navigator.dart';
import 'package:garden_center/frontend/widgets/style.dart';
import 'package:intl/intl.dart';

class Post extends StatelessWidget {
  var id;
  var user;
  var date;
  var picture;
  var title;
  var desc;
  bool isDelete;
  Post(
      {required this.id,
      required this.user,
      required this.date,
      required this.picture,
      required this.title,
      required this.desc,
      this.isDelete = false});

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
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(color: Color.fromARGB(255, 241, 241, 241), borderRadius: BorderRadius.circular(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<dynamic>(
                stream: User().getUser(user),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Container(
                      decoration: BoxDecoration(color: AppColor.grey, borderRadius: BorderRadius.circular(5)),
                    );
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 27,
                              width: 27,
                              child: ClipOval(child: Image.network(snapshot.data['profilePhoto']))),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data['name'], style: AppStyle.miniparagraphBold),
                              Text(date, style: AppStyle.miniparagraph),
                            ],
                          ),
                        ],
                      ),
                      isDelete
                          ? Row(
                              children: [
                                IconButton(onPressed: () => editBlog(context, title, desc), icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () => DialogCard().call(
                                        context,
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('Hapus Postingan', style: AppStyle.heading1),
                                            SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Button(
                                                    onPressed: () {
                                                      Article().delete(id);
                                                      Nav.pop(context);
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        'Hapus',
                                                        style: AppStyle.paragraphLight,
                                                      ),
                                                    )),
                                                Button(
                                                    onPressed: () => Nav.pop(context),
                                                    color: AppColor.light,
                                                    child: Center(
                                                      child: Text(
                                                        'Batal',
                                                        style: AppStyle.paragraph,
                                                      ),
                                                    )),
                                              ],
                                            )
                                          ],
                                        )),
                                    icon: Icon(Icons.delete_outline_rounded)),
                              ],
                            )
                          : SizedBox()
                    ],
                  );
                }),
            picture != ""
                ? Hero(
                    tag: title,
                    child: Container(
                      height: 190,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: NetworkImage(picture), fit: BoxFit.cover)),
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 10),
            Text(title, style: AppStyle.miniparagraphBold),
            Text(desc, style: AppStyle.miniparagraph, maxLines: 2, overflow: TextOverflow.ellipsis),
            SizedBox(height: 10),
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

  void editBlog(BuildContext context, String judul, String descc) {
    TextEditingController title = new TextEditingController();
    TextEditingController desc = new TextEditingController();
    title.text = judul;
    desc.text = descc;
    DialogCard().call(
        context,
        SizedBox(
          height: 450,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Buat Postingan', style: AppStyle.heading1),
                  IconButton(onPressed: () => Nav.pop(context), icon: Icon(Icons.cancel, color: Colors.grey))
                ],
              ),
              TextField(
                controller: title,
                decoration: InputDecoration(
                  label: Text('Judul', style: AppStyle.heading3grey),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: desc,
                maxLines: 10,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tambahkan ke postingan'),
                    IconButton(onPressed: null, icon: Icon(Icons.add_a_photo_outlined)),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Button(
                      onPressed: () {
                        var now = DateTime.now();
                        var formatterDate = DateFormat('dd MMMM yyyy');
                        var formatterTime = DateFormat('kk:mm');
                        String actualDate = formatterTime.format(now) + ', ' + formatterDate.format(now);
                        Article().update(id, title.text, desc.text, actualDate);
                        Nav.pop(context);
                      },
                      height: 40,
                      child: Text('Upload', style: AppStyle.heading3)))
            ],
          ),
        ));
  }
}
