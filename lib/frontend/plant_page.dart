import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:garden_center/frontend/info_plant.dart';

class PlantPage extends StatelessWidget {
  const PlantPage({super.key});

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(fontFamily: 'Poppins');

    var size = MediaQuery.of(context).size;
    TextEditingController search = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.green.shade800,
      body: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        child: Container(
          height: size.height,
          width: size.width,
          color: Color.fromARGB(255, 245, 247, 254),
          child: Stack(
            children: [
              ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: size.height / 6),
                  tanaman(
                      "Jagung",
                      "Umur panen adalah 86-96 hari setelah tanam",
                      'https://asset.kompas.com/crops/SUtUYLeiCclWljut0zrslqBE7HM=/0x0:1000x667/750x500/data/photo/2021/10/04/615a966655301.jpg',
                      size,
                      context),
                ],
              ),
              BlurryContainer(
                width: size.width,
                height: size.height / 4.78,
                blur: 20,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(20, 40, 20, 10),
                      child: Text(
                        'Tanaman',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w900,
                            fontSize: 25),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 5),
                            height: 50,
                            width: size.width / 1.4,
                            child: TextField(
                              controller: search,
                              decoration: InputDecoration(
                                  label: Text('Cari tanaman'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ),
                          ClipOval(
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  child: IconButton(
                                      icon: Icon(Icons.search),
                                      onPressed: () {})),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget tanaman(var name, var desc, var img, var size, BuildContext context) {
    return Container(
      height: 125,
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(10),
                child: Hero(
                  tag: name,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: NetworkImage(img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                width: size.width / 2.5,
                child: ListTile(
                  title: Text(name,
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                  subtitle: Text(desc,
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
                ),
              ),
              Container(
                  child: IconButton(
                      icon: Icon(Icons.navigate_next),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return InfoPlant(title: name, desc: desc, img: img);
                        }));
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
