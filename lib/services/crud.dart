import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class CrudMethod {
  Future<void> addData(blogData) async {
    FirebaseFirestore.instance
        .collection("blogs")
        .add(blogData)
        // ignore: body_might_complete_normally_catch_error
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return FirebaseFirestore.instance.collection("blogs").get();
  }
}
