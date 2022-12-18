import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:garden_center/backend/plant.dart';
import 'package:garden_center/frontend/widgets/button.dart';
import 'package:garden_center/frontend/widgets/dialogCard.dart';
import 'package:garden_center/frontend/widgets/navigator.dart';
import 'package:garden_center/frontend/widgets/style.dart';
import 'package:intl/intl.dart';

class MenuPlant extends StatefulWidget {
  final String id;
  final String name;
  MenuPlant({super.key, required this.id, required this.name});

  @override
  State<MenuPlant> createState() => _MenuPlantState(id, name);
}

class _MenuPlantState extends State<MenuPlant> {
  String id;
  String name;
  _MenuPlantState(this.id, this.name);
  bool start = false;
  bool finish = false;
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: 100),
      () {
        if (!start) {
          setState(() {
            print('masuk sini');
            start = true;
          });
        }
      },
    );
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(left: 20),
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
        actions: [
          IconButton(
              onPressed: () => DialogCard().call(
                  context,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Hapus ?', style: AppStyle.heading1),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button(
                              onPressed: () {
                                Plant().delete(id).then((value) {
                                  Nav.pop(context);
                                  Nav.pop(context);
                                });
                              },
                              child: Center(child: Text('Hapus', style: AppStyle.paragraphLight))),
                          SizedBox(width: 20),
                          Button(
                              onPressed: () => Nav.pop(context),
                              color: AppColor.light,
                              child: Center(child: Text('Batal', style: AppStyle.paragraph)))
                        ],
                      )
                    ],
                  )),
              icon: Icon(
                Icons.delete,
                color: AppColor.primary,
              ))
        ],
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
        title: Row(
          children: [
            Text(name, style: AppStyle.heading1),
          ],
        ),
      ),
      body: StreamBuilder<dynamic>(
          stream: Plant().getMyPlantId(id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
            var date = DateTime.parse(snapshot.data['timestamp']);
            var now = DateTime.now();
            var count = now.difference(date).inDays;
            var progressw = count / snapshot.data['umur'] * 100;

            List values = snapshot.data['valuepenyiraman'];
            int trueValue = 0;
            for (int i = 0; i < values.length; i++) {
              if (values[i]) {
                trueValue++;
              }
            }
            var progressiram = (trueValue / values.length) * 100;

            List valuesorganik = snapshot.data['valuepemupukan_organik'];
            List valuesanorganik = snapshot.data['valuepemupukan_anorganik'];
            int trueOrganik = 0, trueAnorganik = 0;
            for (int i = 0; i < valuesorganik.length; i++) {
              if (valuesorganik[i]) trueOrganik++;
            }
            for (int i = 0; i < valuesanorganik.length; i++) {
              if (valuesanorganik[i]) trueAnorganik++;
            }
            var progrespemupukan =
                ((trueOrganik / valuesorganik.length * 100) + (trueAnorganik / valuesanorganik.length * 100)) / 2;

            Plant().updateProgres(id, (progressw + progressiram + progrespemupukan) / 3);
            return ListView(
              children: [
                cardMenu(size, 'assets/img/time.png', "Waktu", "sekitar " + snapshot.data['umur'].toString() + " hari",
                    progressw, 'waktu', snapshot.data),
                cardMenu(
                    size,
                    'assets/img/watering.png',
                    "Penyiraman",
                    snapshot.data['intervalpenyiraman'].toString() + " hari sekali",
                    progressiram,
                    'penyiraman',
                    snapshot.data),
                cardMenu(size, 'assets/img/pemupukan.png', "Pemupukan", "Pemupukan Organik dan Anorganik",
                    progrespemupukan, 'pemupukan', snapshot.data),
              ],
            );
          }),
    );
  }

  Widget cardMenu(var size, var image, var title, var desc, double progress, var fungsi, var data) {
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Container(
            width: size.width,
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: AppColor.gatau,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              onEnd: () {
                print('msuk finish');
                finish = true;
                setState(() {});
              },
              height: 100,
              width: start ? (size.width - 40) * progress / 100 : 0,
              decoration: BoxDecoration(
                color: AppColor.light,
                borderRadius: progress == 100 && finish == true
                    ? BorderRadius.circular(25)
                    : BorderRadius.only(topLeft: Radius.circular(25), bottomLeft: Radius.circular(25)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    image,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(title, style: AppStyle.heading1),
                      Text('$desc\nProgress ' + progress.toStringAsFixed(2) + '%', style: AppStyle.miniparagraph),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 100,
                  margin: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.navigate_next,
                    size: 40,
                  ),
                ),
              )
            ],
          ),
          Container(
            height: 100,
            margin: EdgeInsets.only(top: 20),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () {
                  if (fungsi == 'waktu')
                    waktu(context, data);
                  else if (fungsi == 'penyiraman')
                    penyiraman(context, data);
                  else if (fungsi == 'pemupukan') pemupukan(context, data);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void waktu(BuildContext context, var data) {
    var date = DateTime.parse(data['timestamp']);
    var now = DateTime.now();
    var count = now.difference(date).inDays;
    var persentase = (count / data['umur']) * 100;
    print(count);
    var size = MediaQuery.of(context).size;
    return DialogCard().call(
      context,
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Waktu', style: AppStyle.heading1),
          SizedBox(height: 10),
          Text("sekitar " + (data['umur'] - now.difference(date).inDays).toString() + " hari lagi",
              style: AppStyle.paragraph),
          SizedBox(height: 20),
          Center(
            // alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  height: 50,
                  width: size.width / 2,
                  decoration: BoxDecoration(color: AppColor.gatau, borderRadius: BorderRadius.circular(15)),
                ),
                Container(
                  height: 50,
                  width: (size.width / 2) * persentase / 100,
                  decoration: BoxDecoration(
                      color: AppColor.light,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                ),
                Container(
                  height: 50,
                  // alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 10, top: 5),
                  child: Text(persentase.toString() + ' %', style: AppStyle.heading1thin),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Text('Tanggal Tanam', style: AppStyle.heading2),
          Text(data['start']),
          Text('Perkiraan Selesai', style: AppStyle.heading2),
          Text(data['finish']),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 100,
              child: Button(
                onPressed: () => Nav.pop(context),
                color: AppColor.primary,
                child: Center(
                  child: Text("Oke", style: AppStyle.paragraphLight),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void penyiraman(BuildContext context, var data) {
    var size = MediaQuery.of(context).size;
    List values = data['valuepenyiraman'];
    print(values);
    List date = [];
    var startdate = DateTime.parse(data['timestamp']);
    var tempdate = startdate;
    var formatterDate = DateFormat('dd MMMM yyyy');
    date.add(formatterDate.format(startdate));
    for (int i = 0; i < values.length; i++) {
      var tambah = tempdate.add(Duration(days: data['intervalpenyiraman']));
      date.add(formatterDate.format(tambah));
      tempdate = tambah;
    }
    print(date);

    int trueValue = 0;
    for (int i = 0; i < values.length; i++) {
      if (values[i]) trueValue++;
    }
    var progres = (trueValue / values.length) * 100;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          List<Widget> wdgt = [];
          wdgt.add(Text('Penyiraman', style: AppStyle.heading1));
          wdgt.add(SizedBox(height: 10));
          wdgt.add(Center(
            // alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  height: 50,
                  width: size.width / 2,
                  decoration: BoxDecoration(color: AppColor.gatau, borderRadius: BorderRadius.circular(15)),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 50,
                  width: (size.width / 2) * progres / 100,
                  decoration: BoxDecoration(
                      color: AppColor.light,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                ),
                Container(
                  height: 50,
                  // alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 10, top: 5),
                  child: Text(progres.toStringAsFixed(2) + '%', style: AppStyle.heading1thin),
                )
              ],
            ),
          ));
          wdgt.add(SizedBox(height: 20));
          for (int i = 0; i < values.length; i++) {
            wdgt.add(CheckboxListTile(
                title: Text(date[i]),
                value: values[i],
                onChanged: (value) {
                  setState(() {
                    values[i] = value;
                    Plant().updatePenyiraman(id, values);
                  });
                }));
          }
          wdgt.add(Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 100,
              child: Button(
                onPressed: () => Nav.pop(context),
                color: AppColor.primary,
                child: Center(
                  child: Text("Oke", style: AppStyle.paragraphLight),
                ),
              ),
            ),
          ));
          return BlurryContainer(
            blur: 15,
            child: Dialog(
              elevation: 25,
              insetAnimationCurve: Curves.decelerate,
              insetAnimationDuration: Duration(milliseconds: 300),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.all(20),
                child: ListView(children: wdgt),
              ),
            ),
          );
        });
      },
    );
  }

  void pemupukan(BuildContext context, var data) {
    var size = MediaQuery.of(context).size;
    List valuesOrganik = data['valuepemupukan_organik'];
    List valuesAnorganik = data['valuepemupukan_anorganik'];
    List dateOrganik = [];
    List dateAnorganik = [];
    var startdate = DateTime.parse(data['timestamp']);
    var tempdate = startdate;
    var formatterDate = DateFormat('dd MMMM yyyy');
    for (int i = 0; i < valuesOrganik.length; i++) {
      var tambah = tempdate.add(Duration(days: data['intervalpemupukan_organik']));
      dateOrganik.add(formatterDate.format(tambah));
      tempdate = tambah;
    }
    tempdate = startdate;
    for (int i = 0; i < valuesAnorganik.length; i++) {
      var tambah = tempdate.add(Duration(days: data['intervalpemupukan_anorganik']));
      dateAnorganik.add(formatterDate.format(tambah));
      tempdate = tambah;
    }

    int trueValueOrganik = 0;
    for (int i = 0; i < valuesOrganik.length; i++) {
      if (valuesOrganik[i]) trueValueOrganik++;
    }
    var progresOrganik = (trueValueOrganik / valuesOrganik.length) * 100;
    int trueValueAnorganik = 0;
    for (int i = 0; i < valuesAnorganik.length; i++) {
      if (valuesAnorganik[i]) trueValueAnorganik++;
    }
    var progresAnorganik = (trueValueAnorganik / valuesAnorganik.length) * 100;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          List<Widget> wdgt = [];
          wdgt.add(Text('Pemupukan Organik', style: AppStyle.heading1));
          wdgt.add(SizedBox(height: 10));
          wdgt.add(Center(
            // alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  height: 50,
                  width: size.width / 2,
                  decoration: BoxDecoration(color: AppColor.gatau, borderRadius: BorderRadius.circular(15)),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 50,
                  width: (size.width / 2) * progresOrganik / 100,
                  decoration: BoxDecoration(
                      color: AppColor.light,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                ),
                Container(
                  height: 50,
                  // alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 10, top: 5),
                  child: Text(progresOrganik.toStringAsFixed(2) + '%', style: AppStyle.heading1thin),
                )
              ],
            ),
          ));
          wdgt.add(SizedBox(height: 20));
          if (data['intervalpemupukan_organik'] > data['umur']) {
            wdgt.add(Text('Tidak ada data', style: AppStyle.heading1grey));
          } else {
            for (int i = 0; i < valuesOrganik.length; i++) {
              wdgt.add(CheckboxListTile(
                  title: Text(dateOrganik[i]),
                  value: valuesOrganik[i],
                  onChanged: (value) {
                    setState(() {
                      valuesOrganik[i] = value;
                      Plant().updatePemupukanOrganik(id, valuesOrganik);
                    });
                  }));
            }
          }
          wdgt.add(Text('Pemupukan Anorganik', style: AppStyle.heading1));
          wdgt.add(SizedBox(height: 10));
          wdgt.add(Center(
            // alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  height: 50,
                  width: size.width / 2,
                  decoration: BoxDecoration(color: AppColor.gatau, borderRadius: BorderRadius.circular(15)),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 50,
                  width: (size.width / 2) * progresAnorganik / 100,
                  decoration: BoxDecoration(
                      color: AppColor.light,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                ),
                Container(
                  height: 50,
                  // alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 10, top: 5),
                  child: Text(progresAnorganik.toStringAsFixed(2) + '%', style: AppStyle.heading1thin),
                )
              ],
            ),
          ));
          wdgt.add(SizedBox(height: 20));
          if (data['intervalpemupukan_anorganik'] > data['umur']) {
            wdgt.add(Text('Tidak ada data', style: AppStyle.heading1grey));
          } else {
            for (int i = 0; i < valuesAnorganik.length; i++) {
              wdgt.add(CheckboxListTile(
                  title: Text(dateAnorganik[i]),
                  value: valuesAnorganik[i],
                  onChanged: (value) {
                    setState(() {
                      valuesAnorganik[i] = value;
                      Plant().updatePemupukanAnorganik(id, valuesAnorganik);
                    });
                  }));
            }
          }
          wdgt.add(Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 100,
              child: Button(
                onPressed: () => Nav.pop(context),
                color: AppColor.primary,
                child: Center(
                  child: Text("Oke", style: AppStyle.paragraphLight),
                ),
              ),
            ),
          ));
          return BlurryContainer(
            blur: 15,
            child: Dialog(
              elevation: 25,
              insetAnimationCurve: Curves.decelerate,
              insetAnimationDuration: Duration(milliseconds: 300),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.all(20),
                child: ListView(children: wdgt),
              ),
            ),
          );
        });
      },
    );
  }
}
