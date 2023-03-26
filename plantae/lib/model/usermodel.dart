import 'package:cloud_firestore/cloud_firestore.dart';

class userModel {
  final String email;
  final String username;
  final String uid;
  final String photourl;
  final String bio;
  final List followers;
  final List following;

  const userModel(
      {required this.username,
      required this.email,
      required this.uid,
      required this.bio,
      required this.followers,
      required this.photourl,
      required this.following});

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "uid": uid,
        "bio": bio,
        "followers": followers,
        "photourl": photourl,
        "following": following,
      };

  static userModel? fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return userModel(
        username: snapshot["username"],
        email: snapshot["email"],
        uid: snapshot["uid"],
        bio: snapshot["bio"],
        followers: snapshot["followers"],
        photourl: snapshot["photourl"],
        following: snapshot["following"]);
  }
}
