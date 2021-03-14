import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';

class AuthenticationFunction {
  FirebaseAuth _auth = FirebaseAuth.instance;
  static const ROOT =
      "https://sales.english-vip.com:443/crm/index.php?entryPoint=WebToLeadCapture";
  static const Campaign_Id = "b7051103-97fe-c627-96a3-6048d37afd0b";
  static const Assigned_User_Id = "1";

  Future<String> registerUser(String email, String password, String username,
      String phone, String country) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      if (user != null) {
        user.sendEmailVerification();
        saveUserInfoToFireStore(user, username, phone);
        addUser(username, email, country, phone);
      }
      return '';
    } catch (error) {
      print(error.message.toString());
      return error.message.toString();
    }
  }

  Future saveUserInfoToFireStore(
      User user, String fullName, String phone) async {
    FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      "uid": user.uid,
      "email": user.email,
      "fullName": fullName == null ? "user" : fullName,
      "accountSetup": false,
      "phone": phone,
      "learningPoint": 0
    });
  }

  Future signIn(String email, String password) async {
    User user;
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = credential.user;
      if (user != null) {
        if (user.emailVerified) {
          print(user.emailVerified);
          return '';
        } else {
          return emailNotVerified;
        }
      }
    } catch (error) {
      print(error.message.toString());
      return error.message.toString();
    }
  }

  Future<bool> setUpAccount() async {
    bool ret;
    try {
      var firebaseUser = _auth.currentUser;
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid);

      await documentReference.get().then((datasnapshot) {
        if (datasnapshot.exists) {
          ret = datasnapshot.data()['accountSetup'];
        } else {
          ret = false;
        }
      });
    } catch (e) {}
    return ret;
  }

  Future<String> setupAccountInfo(String gender, String occupation,
      String level, DateTime dob, String desc) async {
    var firebaseUser = _auth.currentUser;

    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser.uid)
          .update({
        "gender": gender,
        "occupation": occupation,
        "level": level,
        "dob": dob,
        "accountSetup": true,
        "desc": desc
      });
      return '';
    } catch (e) {
      return "Error Occurred";
    }
  }

  Future<bool> validatePassword(String password) async {
    var firebaseUser = _auth.currentUser;
    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser.email, password: password);
    try {
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void updatePassword(String password) async {
    try {
      var firebaseUser = _auth.currentUser;
      firebaseUser.updatePassword(password);
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      //await _googleSignIn.signOut();
    } catch (e) {
      print('Failed to signOut' + e.toString());
    }
  }

  Future<String> sendPasswordResetEmail(String email) async {
    String confirm = '';
    try {
      await _auth.sendPasswordResetEmail(email: email);
      confirm = 'Reset Link has been sent';
    } catch (e) {
      return confirm = 'Email is badly formatted or does not exist';
    }
    return confirm;
  }

  Future<String> addUser(
      String lastName, String email, String country, String phoneno) async {
    try {
      print("here");

      Map<String, dynamic> body = {
        'last_name': lastName,
        'email1': email,
        'phone_work': phoneno,
        'campaign_id': Campaign_Id,
        'assigned_user_id': Assigned_User_Id,
        'primary_address_country': country
      };

      var uri = new Uri.https("sales.english-vip.com:443", "/crm/index.php",
          {'entryPoint': 'WebToLeadCapture'});
      final response = await http.post(uri, body: body);
      print(response.body);
    } catch (e) {
      return "error";
    }
  }
}
