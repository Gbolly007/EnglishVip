import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_vip/provider/wvFirebaseProviders.dart';
import 'package:rxdart/rxdart.dart';

class FailedVideoListBloc {
  WrongVideosFirebaseProvider firebaseProvider;

  bool showIndicator = false;
  List<DocumentSnapshot> documentList;

  BehaviorSubject<List<DocumentSnapshot>> movieController;

  BehaviorSubject<bool> showIndicatorController;

  FailedVideoListBloc() {
    movieController = BehaviorSubject<List<DocumentSnapshot>>();
    showIndicatorController = BehaviorSubject<bool>();
    firebaseProvider = WrongVideosFirebaseProvider();
  }

  Stream get getShowIndicatorStream => showIndicatorController.stream;

  Stream<List<DocumentSnapshot>> get movieStream => movieController.stream;

/*This method will automatically fetch first 10 elements from the document list */
  Future fetchFirstList(String uid) async {
    try {
      documentList = await firebaseProvider.fetchFirstList(uid);
      print(documentList);
      movieController.sink.add(documentList);
      try {
        if (documentList.length == 0) {
          movieController.sink.addError("No Data Available");
        }
      } catch (e) {}
    } on SocketException {
      movieController.sink.addError(SocketException("No Internet Connection"));
    } catch (e) {
      print(e.toString());
      movieController.sink.addError(e);
    }
  }

/*This will automatically fetch the next 10 elements from the list*/
  fetchNextMovies(String uid) async {
    try {
      updateIndicator(true);
      List<DocumentSnapshot> newDocumentList =
          await firebaseProvider.fetchNextList(documentList, uid);
      documentList.addAll(newDocumentList);
      movieController.sink.add(documentList);
      try {
        if (documentList.length == 0) {
          movieController.sink.addError("No Data Available");
          updateIndicator(false);
        }
      } catch (e) {
        updateIndicator(false);
      }
    } on SocketException {
      movieController.sink.addError(SocketException("No Internet Connection"));
      updateIndicator(false);
    } catch (e) {
      updateIndicator(false);
      print(e.toString());
      movieController.sink.addError(e);
    }
  }

/*For updating the indicator below every list and paginate*/
  updateIndicator(bool value) async {
    showIndicator = value;
    showIndicatorController.sink.add(value);
  }

  void dispose() {
    movieController.close();
    showIndicatorController.close();
  }
}
