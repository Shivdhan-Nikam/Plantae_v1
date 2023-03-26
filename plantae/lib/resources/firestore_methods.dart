import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantae/model/postmodel.dart';
import 'package:plantae/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _Firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String discription,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "Some error Occured";

    try {
      String photourl =
          await storageMethods().UploadImageToStorage("posts", file, true);
      String postid = const Uuid().v1();
      Post post = Post(
          username: username,
          discription: discription,
          uid: uid,
          postid: postid,
          profImage: profImage,
          posturl: photourl,
          datePublished: DateTime.now(),
          likes: []);

      _Firestore.collection('posts').doc(postid).set(post.toJson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
