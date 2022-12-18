import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garden_center/backend/auth_service.dart';
import 'package:intl/intl.dart';

class Plant {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  getAll() async {
    QuerySnapshot querySnapshot = await _firestore.collection('plants').get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  getPlant(String id) async {
    id = id.toLowerCase();
    return await _firestore.collection('plants').doc(id).get();
  }

  getMyPlant() {
    return _firestore.collection('userPlant').where("user", isEqualTo: AuthService().user.uid).snapshots();
  }

  getMyPlantId(id) {
    return _firestore.collection('userPlant').doc(id).snapshots();
  }

  add(var plant) async {
    List<bool> valuepenyiraman = [];
    List<bool> valuepemupukanorganik = [];
    List<bool> valuepemupukananorganik = [];
    valuepenyiraman.add(false);
    for (int i = 0; i < plant['umur'] / plant['intervalpenyiraman']; i++) {
      valuepenyiraman.add(false);
    }
    for (int i = 0; i < plant['umur'] / plant['intervalpemupukan_organik']; i++) {
      valuepemupukanorganik.add(false);
    }
    for (int i = 0; i < plant['umur'] / plant['intervalpemupukan_anorganik']; i++) {
      valuepemupukananorganik.add(false);
    }
    var formatterDate = DateFormat('dd MMMM yyyy');
    String id = AuthService().user.uid + plant['name'] + Random().nextInt(100).toString();
    await _firestore.collection('userPlant').doc(id).set({
      'id': id,
      'plant': plant['name'],
      'user': AuthService().user.uid,
      'timestamp': DateTime.now().toString(),
      'umur': plant['umur'],
      'start': formatterDate.format(DateTime.now()),
      'finish': formatterDate.format(DateTime.now().add(Duration(days: plant['umur']))),
      'valuepenyiraman': valuepenyiraman,
      'valuepemupukan_organik': valuepemupukanorganik,
      'valuepemupukan_anorganik': valuepemupukananorganik,
      'intervalpenyiraman': plant['intervalpenyiraman'],
      'intervalpemupukan_organik': plant['intervalpemupukan_organik'],
      'intervalpemupukan_anorganik': plant['intervalpemupukan_anorganik'],
      'progress': 0.0,
    });
  }

  updatePenyiraman(id, data) async {
    await _firestore.collection('userPlant').doc(id).update({'valuepenyiraman': data});
  }

  updatePemupukanOrganik(id, data) async {
    await _firestore.collection('userPlant').doc(id).update({'valuepemupukan_organik': data});
  }

  updatePemupukanAnorganik(id, data) async {
    await _firestore.collection('userPlant').doc(id).update({'valuepemupukan_anorganik': data});
  }

  updateProgres(id, value) async {
    await _firestore.collection('userPlant').doc(id).update({'progress': value});
  }

  delete(id) async {
    await _firestore.collection('userPlant').doc(id).delete();
  }
}
