import 'package:cloud_firestore/cloud_firestore.dart';

class WrongVideosFirebaseProvider {
  Future<List<DocumentSnapshot>> fetchFirstList(String user) async {
    return (await FirebaseFirestore.instance
            .collection("users")
            .doc(user)
            .collection("failed")
            .orderBy("timePosted", descending: true)
            .limit(10)
            .get())
        .docs;
  }

  Future<List<DocumentSnapshot>> fetchNextList(
      List<DocumentSnapshot> documentList, String user) async {
    return (await FirebaseFirestore.instance
            .collection("users")
            .doc(user)
            .collection("failed")
            .orderBy("timePosted", descending: true)
            .startAfterDocument(documentList[documentList.length - 1])
            .limit(10)
            .get())
        .docs;
  }
}
