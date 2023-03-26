import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String discription;
  final String username;
  final String uid;
  final String postid;
  final String profImage;
  final String posturl;
  final  datePublished;
  final likes;

  const Post(
      {required this.username,
      required this.discription,
      required this.uid,
      required this.postid,
      required this.profImage,
      required this.posturl,
      required this.datePublished,
      required this.likes});

  Map<String, dynamic> toJson() => {
        "username": username,
        "discription": discription,
        "uid": uid,
        "postid": postid,
        "profImage": profImage,
        "datePublished": datePublished,
        "posturl": posturl,
        "likes": likes,
      };

  static Post? fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
        username: snapshot["username"],
        discription: snapshot["discription"],
        uid: snapshot["uid"],
        postid: snapshot["postid"],
        datePublished: snapshot["datePublished"],
        posturl: snapshot["posturl"],
        profImage: snapshot["profImage"],
        likes: snapshot["likes"]);
  }
}
