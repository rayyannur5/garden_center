import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_weather_icons/dynamic_weather_icons.dart';
import 'package:flutter/material.dart';
import 'package:garden_center/backend/article.dart';
import 'package:garden_center/backend/auth_service.dart';
import 'package:garden_center/backend/plant.dart';
import 'package:garden_center/backend/user.dart';
import 'package:garden_center/frontend/plant/menu_plant.dart';
import 'package:garden_center/frontend/widgets/navigator.dart';
import 'package:garden_center/frontend/widgets/post.dart';
import 'package:garden_center/frontend/widgets/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool start = false;
  bool finish = false;
  bool awal = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: home(context),
    );
  }

  Widget home(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data(),
      ),
    );
  }

  Widget CardTanaman(String id, String title, String latin, String gambar, double progres) {
    Future.delayed(
      Duration(milliseconds: 100),
      () {
        if (!start) {
          setState(() {
            start = true;
          });
        }
      },
    );
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 5, 5),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 120,
              height: 150,
              decoration: BoxDecoration(color: AppColor.gatau, borderRadius: BorderRadius.circular(15)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              onEnd: () {
                finish = true;
                setState(() {});
              },
              height: start ? (150) * progres / 100 : 0,
              width: 120,
              decoration: BoxDecoration(
                color: AppColor.light,
                borderRadius: progres == 100 && finish == true
                    ? BorderRadius.circular(15)
                    : BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 120, child: Image.asset(gambar)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(title, style: AppStyle.heading2),
              ),
              Container(
                width: 120,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(latin, style: AppStyle.miniparagraph),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('Progress : ' + progres.toStringAsFixed(2) + '%', style: AppStyle.paragraph),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 120,
              height: 150,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Future.delayed(
                        Duration(milliseconds: 150), () => Nav.push(context, MenuPlant(id: id, name: title)));
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> data() {
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
    List<Widget> result = [];
    result.add(
      StreamBuilder<dynamic>(
        stream: User().getUser(AuthService().user.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome Back', style: AppStyle.heading1),
                    Text(snapshot.data['name'], style: AppStyle.heading1thin),
                  ],
                ),
                ClipOval(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                    child: Image.network(snapshot.data['profilePhoto']),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    result.add(
      Container(
        height: MediaQuery.of(context).size.height / 7,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(color: AppColor.primary, borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Surabaya, Jawa Timur',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
                ),
                Text(
                  '30°C',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, color: Colors.white),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  WeatherIcon.getIcon('wi-owm-day-200'),
                  color: Colors.white,
                  size: 35.0,
                ),
                SizedBox(height: 10),
                Text(
                  'Cerah',
                  style: AppStyle.paragraph2Light,
                )
              ],
            )
          ],
        ),
      ),
    );
    result.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text('Tanamanku', style: AppStyle.heading1),
      ),
    );
    result.add(
      SizedBox(
        height: 200,
        child: StreamBuilder<QuerySnapshot>(
            stream: Plant().getMyPlant(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length == 0) {
                  return Center(child: Text('Tidak ada tanaman', style: AppStyle.heading1grey));
                }
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    var id = data['id'];

                    return FutureBuilder<dynamic>(
                        future: Plant().getPlant(data['plant']),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else
                            return CardTanaman(id, snapshot.data['name'], snapshot.data['latin'],
                                datagambar[snapshot.data['name']], data['progress']);
                        });
                  }).toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
    result.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text('Blog', style: AppStyle.heading1),
      ),
    );
    result.add(
      FutureBuilder(
        future: Article().getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          // for (var data in snapshot.data) {
          if (snapshot.data.length == 0) {
            return Center(child: Text('Tidak Ada Blog'));
          } else {
            return Post(
                id: snapshot.data[0]['id'],
                user: snapshot.data[0]['user'],
                date: snapshot.data[0]['date'],
                picture: snapshot.data[0]['picture'],
                title: snapshot.data[0]['title'],
                desc: snapshot.data[0]['desc']);
          }
        },
      ),
    );
    result.add(FutureBuilder(
      future: Article().getData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        // for (var data in snapshot.data) {

        if (snapshot.data.length <= 1) {
          return Text('');
        } else {
          return Post(
              id: snapshot.data[1]['id'],
              user: snapshot.data[1]['user'],
              date: snapshot.data[1]['date'],
              picture: snapshot.data[1]['picture'],
              title: snapshot.data[1]['title'],
              desc: snapshot.data[1]['desc']);
        }
      },
    ));
    result.add(
      FutureBuilder(
        future: Article().getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          if (snapshot.data.length <= 2) {
            return Text('');
          } else {
            return Post(
                id: snapshot.data[2]['id'],
                user: snapshot.data[2]['user'],
                date: snapshot.data[2]['date'],
                picture: snapshot.data[2]['picture'],
                title: snapshot.data[2]['title'],
                desc: snapshot.data[2]['desc']);
          }
          // for (var data in snapshot.data) {
          // }
        },
      ),
    );
    return result;
  }
}
