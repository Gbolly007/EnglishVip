import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider {
  Future<List<DocumentSnapshot>> fetchFirstList(String user) async {
    List<String> listitems = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user)
        .collection("watchedVideos")
        .get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      listitems.add(a.data()["id"]);
    }

    List<DocumentSnapshot> docSnap = List<DocumentSnapshot>();
    docSnap = (await FirebaseFirestore.instance
            .collection("videos")
            .orderBy("datePosted", descending: true)
            .limit(10)
            .get())
        .docs;
    List<DocumentSnapshot> userList = docSnap.where((element) {
      return !listitems.contains(element.id);
    }).toList();
    return userList;
  }

  Future<List<DocumentSnapshot>> fetchNextList(
      List<DocumentSnapshot> documentList, String user) async {
    List<String> listitems = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user)
        .collection("watchedVideos")
        .get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      listitems.add(a.data()["id"]);
    }

    List<DocumentSnapshot> docSnap = List<DocumentSnapshot>();
    docSnap = (await FirebaseFirestore.instance
            .collection("videos")
            .orderBy("datePosted")
            .startAfterDocument(documentList[documentList.length - 1])
            .limit(10)
            .get())
        .docs;

    List<DocumentSnapshot> userList = docSnap.where((element) {
      return !listitems.contains(element.id);
    }).toList();
    return userList;
  }
}
