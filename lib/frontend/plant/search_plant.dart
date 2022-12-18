import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:garden_center/backend/plant.dart';
import 'package:garden_center/frontend/plant/info_plant.dart';
import 'package:garden_center/frontend/widgets/navigator.dart';
import 'package:garden_center/frontend/widgets/style.dart';

class SearchPlant extends StatelessWidget {
  const SearchPlant({super.key});

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(fontFamily: 'Poppins');

    var size = MediaQuery.of(context).size;
    TextEditingController search = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: Container(
            margin: EdgeInsets.all(8),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.light,
            ),
            child: IconButton(
              icon: Icon(Icons.navigate_before, color: AppColor.primary),
              onPressed: () => Nav.pop(context),
            ),
          ),
          backgroundColor: Colors.white.withAlpha(200),
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          elevation: 0,
          title: Text('Tanaman', style: AppStyle.heading1),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          child: FutureBuilder<dynamic>(
            future: Plant().getAll(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
              print(snapshot.data[0]['name']);
              print(snapshot.data[0]['desc']);
              print(snapshot.data[0]['picture']);
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => tanaman(snapshot.data[index], context),
              );
            },
          ),
        ));
  }

  Widget tanaman(var data, BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 125,
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 0,
        color: AppColor.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(10),
                child: Hero(
                  tag: data['name'],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: NetworkImage(data['picture']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                width: size.width / 2.5,
                child: ListTile(
                  title: Text(data['name'], style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                  subtitle: Text("Umur sekitar " + data['umur'].toString() + " hari",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.navigate_next),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return InfoPlant(data: data);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
