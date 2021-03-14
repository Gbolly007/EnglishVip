import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileFunc {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> addDesc(String desc) async {
    String feedback = "";
    try {
      var firebaseUser = _firebaseAuth.currentUser;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser.uid)
          .update({"description": desc});
      feedback = "";
    } catch (e) {
      feedback = "An error occurred, please try again later";
    }
    return feedback;
  }
}
