import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garden_center/backend/auth_service.dart';

class User {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getUser(id) {
    return _firestore.collection('users').doc(id).snapshots();
  }

  update([String name = "", String bio = "", String profilePhoto = ""]) {
    _firestore.collection('users').doc(AuthService().user.uid).get().then((value) {
      var data = value.data();

      if (name == "") name = data!['name'];
      if (bio == "") bio = data!['bio'];
      if (profilePhoto == "") profilePhoto = data!['profilePhoto'];
      _firestore
          .collection('users')
          .doc(AuthService().user.uid)
          .update({'name': name, 'bio': bio, 'profilePhoto': profilePhoto});
    });
    // name = AuthService().user.displayName!;
    // profilePhoto = AuthService().user.photoURL!;
  }

  reset() {
    _firestore.collection('users').doc(AuthService().user.uid).update({
      'name': AuthService().user.displayName,
      'bio': 'Ubah bio di update profil',
      'profilePhoto': AuthService().user.photoURL
    });
  }
}
