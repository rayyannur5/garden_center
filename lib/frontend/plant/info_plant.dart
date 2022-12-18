import 'package:flutter/material.dart';
import 'package:garden_center/backend/plant.dart';
import 'package:garden_center/frontend/plant/menu_plant.dart';
import 'package:garden_center/frontend/widgets/navigator.dart';
import 'package:garden_center/frontend/widgets/style.dart';

class InfoPlant extends StatelessWidget {
  final Map data;
  const InfoPlant({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String tips = "";
    for (var teks in data['tips']) {
      tips = tips + teks + "\n";
    }

    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 33),
          height: 50,
          child: Material(
            borderRadius: BorderRadius.circular(25),
            elevation: 10,
            color: AppColor.primary,
            child: InkWell(
              onTap: () {
                Future.delayed(Duration(microseconds: 100), () => Plant().add(data).then((value) => Nav.pop(context)));
              },
              child: Center(
                child: Text(
                  "Tanam",
                  style: TextStyle(fontFamily: "Poppins", color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              collapsedHeight: 120,
              pinned: true,
              backgroundColor: AppColor.primary,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    height: 40,
                    width: 40,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.navigate_before,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Material(
                      shape: CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: InkWell(
                          child: Image.asset("assets/icon/discord 1.png"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: data['name'],
                  child: Image.network(
                    data['picture'],
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(33, 10, 0, 10),
                  child: Text(
                    data['name'],
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
                  ),
                  decoration: BoxDecoration(color: Colors.white),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(33, 10, 33, 0),
                child: Text(
                  data['desc'],
                  textAlign: TextAlign.justify,
                  style: AppStyle.paragraph,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(33, 10, 33, 0),
                child: Text(
                  "Tips & Tricks",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(33, 10, 33, 0),
                child: Text(
                  tips,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontFamily: "Poppins"),
                ),
              ),
            ),
          ],
        ));
  }
}
