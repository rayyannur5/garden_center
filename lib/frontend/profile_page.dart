import 'package:flutter/material.dart';
import 'package:garden_center/backend/article.dart';
import 'package:garden_center/backend/auth_service.dart';
import 'package:garden_center/backend/user.dart';
import 'package:garden_center/frontend/widgets/articleCard.dart';
import 'package:garden_center/frontend/widgets/button.dart';
import 'package:garden_center/frontend/widgets/dialogCard.dart';

class ProfilePage extends StatelessWidget {
  String id;
  ProfilePage(this.id) {
    if (id == 'a') {
      id = AuthService().user.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade800,
      body: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        child: Container(
          color: Color.fromARGB(255, 245, 247, 254),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: data(context),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> data(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Widget> list = [];
    list.add(
      StreamBuilder<dynamic>(
        stream: User().getUser(AuthService().user.uid),
        builder: (_, snapshot) {
          if (snapshot.hasData == true) {
            var my_data = snapshot.data;
            return info(context, my_data['name'], my_data['email'],
                my_data['bio'], my_data['profilePhoto'], size);
          } else {
            return Text("Loading");
          }
        },
      ),
    );
    list.add(header('Tanaman'));
    list.add(
      FutureBuilder(builder: (context, snapshot) {
        return listTanaman();
      }),
    );
    list.add(header('Artikel'));

    List data = Article().get(AuthService().user.uid);
    for (int i = 0; i < data.length; i++) {
      list.add(
        ArticleCard(
            title: data[i]['title'],
            desc: data[i]['desc'],
            author: data[i]['author'],
            img: data[i]['img']),
      );
    }
    return list;
  }

  Widget listTanaman() {
    List _cardTanaman = [
      tanaman('Jagung', '10 Agustus 2022',
          "https://asset.kompas.com/crops/SUtUYLeiCclWljut0zrslqBE7HM=/0x0:1000x667/750x500/data/photo/2021/10/04/615a966655301.jpg"),
      tanaman('Sawi', '15 Agustus 2022',
          'https://media.suara.com/pictures/653x366/2022/01/29/39990-ilustrasi-sawi-hijau-pexelsson-tung-tran.jpg'),
      tanaman('Tomat', '14 Agustus 2022',
          'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2022/02/18053252/sebenarnya-tomat-buah-atau-sayur-ketahui-faktanya-halodoc.jpg'),
      Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Icon(
            Icons.add_circle_sharp,
            color: Colors.black.withOpacity(0.5),
            size: 80,
          ),
        ),
      )
    ];
    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _cardTanaman.length,
        itemBuilder: (BuildContext context, int index) => Container(
            margin: EdgeInsets.only(bottom: 15, right: 5),
            width: 150,
            child: _cardTanaman[index]),
      ),
    );
  }

  Widget info(
      BuildContext context, var name, var email, var bio, var img, var size) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 50),
            height: size.height / 5,
            width: size.width,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.only(left: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    ListTile(
                      title: Text(
                        name,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      subtitle:
                          Text(email, style: TextStyle(fontFamily: 'Poppins')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        bio,
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            child: Button(
                                text: Text('Edit Profil'),
                                color: Colors.green.shade700,
                                onPressed: () => DialogCard()
                                    .call(context, updateData(context)))),
                        Button(
                            text: Text("Logout"),
                            color: Colors.red,
                            onPressed: () => DialogCard().call(
                                context,
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Yakin ingin keluar ?',
                                        style:
                                            TextStyle(fontFamily: 'Poppins')),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Button(
                                            text: Text('Batal'),
                                            onPressed: () =>
                                                Navigator.pop(context)),
                                        Button(
                                            text: Text('Logout'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              AuthService().signOut();
                                            },
                                            color: Colors.red)
                                      ],
                                    )
                                  ],
                                )))
                      ],
                    ),
                    Spacer()
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(top: size.height / 25),
                height: size.height / 7,
                width: size.height / 7,
                child: Material(
                  elevation: 10,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(img),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget header(var title) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 35, left: 15, right: 15),
          color: Colors.black,
          height: 1,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(25, 15, 5, 0),
          padding: EdgeInsets.only(left: 10, right: 10),
          color: Color.fromARGB(255, 245, 247, 254),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 25,
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Widget tanaman(var name, var date, var img) {
    var border = BorderRadius.circular(20);
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: border),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 100,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(img),
                )),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600)),
                    Text(date,
                        style: TextStyle(fontSize: 10, fontFamily: 'Poppins')),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.navigate_next_rounded))
            ],
          ),
        ],
      ),
    );
  }

  Widget updateData(BuildContext context) {
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerPhoto = TextEditingController();
    TextEditingController controllerBio = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text('Edit Data',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w700))),
        Container(
            margin: EdgeInsets.only(top: 30),
            child: Input(controllerName, 'Nama Lengkap')),
        Input(controllerPhoto, 'Foto Profil'),
        Input(controllerBio, 'Bio'),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.only(right: 10),
                child: Button(
                    text: Text('Batal'),
                    color: Colors.red,
                    onPressed: () => Navigator.pop(context))),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: Button(
                    text: Text('Reset'),
                    color: Colors.green.shade800,
                    onPressed: () {
                      User().reset();
                      Navigator.pop(context);
                    })),
            Button(
              text: Text('Simpan'),
              color: Colors.green.shade800,
              onPressed: () {
                User().update(controllerName.text, controllerBio.text,
                    controllerPhoto.text);
                Navigator.pop(context);
              },
            )
          ],
        )
      ],
    );
  }

  Container Input(TextEditingController controllerName, String name) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: TextField(
          controller: controllerName,
          decoration: InputDecoration(
            label: Text(name,
                style: TextStyle(fontFamily: 'Poppins', color: Colors.black)),
            hintStyle: TextStyle(fontFamily: 'Poppins'),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
          ),
        ));
  }
}
