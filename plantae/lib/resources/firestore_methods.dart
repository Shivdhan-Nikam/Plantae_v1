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

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _Firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _Firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment(String postId, String text, String uid,
      String username, String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentsId = Uuid().v1();
        await _Firestore.collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentsId)
            .set({
          'profilePic': profilePic,
          'name': username,
          'uid': uid,
          'text': text,
          'commentId': commentsId,
          'datePublished': DateTime.now(),
        });
      } else {
        print("text Is empty");
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _Firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _Firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];
      if (following.contains(followId)) {
        await _Firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _Firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _Firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _Firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

}
