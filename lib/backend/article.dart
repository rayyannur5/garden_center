import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:garden_center/backend/auth_service.dart';
import 'package:garden_center/backend/user.dart';

class Article {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  search(String query) {
    return _firestore
        .collection("blog")
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThan: query + 'z')
        .snapshots();
  }

  get(id) {
    return _firestore.collection("blog").where("user", isEqualTo: id).snapshots();
  }

  getAll() {
    return _firestore.collection('blog').orderBy('date', descending: true).snapshots();
  }

  create(title, desc, date, String path) async {
    if (path == "") {
      await _firestore.collection('blog').doc('id_' + title).set({
        'id': 'id_' + title,
        'title': title,
        'desc': desc,
        'date': date,
        'picture': "",
        'user': AuthService().user.uid,
      });
    } else {
      File file = File(path);
      String filename = basename(file.path);
      Reference ref = FirebaseStorage.instance.ref().child(filename);
      UploadTask task = ref.putFile(file);

      task.whenComplete(() async {
        await _firestore.collection('blog').doc('id_' + title).set({
          'id': 'id_' + title,
          'title': title,
          'desc': desc,
          'date': date,
          'picture': await ref.getDownloadURL(),
          'pictureChild': filename,
          'user': AuthService().user.uid,
        });
      });
    }
  }

  update(id, title, desc, date) async {
    await _firestore.collection('blog').doc(id).update({
      'id': id,
      'title': title,
      'desc': desc,
      'date': date,
      'user': AuthService().user.uid,
    });
  }

  delete(id) async {
    DocumentSnapshot doc = await _firestore.collection('blog').doc(id).get();
    var data = doc.data() as Map;
    print(data['pictureChild']);
    Reference ref = FirebaseStorage.instance.ref().child(data['pictureChild']);
    await ref.delete();
    await _firestore.collection('blog').doc(id).delete();
  }
}
