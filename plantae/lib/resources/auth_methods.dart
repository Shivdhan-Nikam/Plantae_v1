import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantae/model/usermodel.dart' as model;
import 'package:plantae/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.userModel?> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.userModel.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String bio,
    required String username,
    required Uint8List file,
  }) async {
    String res = 'Some error Occure';
    try {
      if (email.isNotEmpty ||
          bio.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          file != null) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await storageMethods()
            .UploadImageToStorage('profilePics', file, false);

        model.userModel user = model.userModel(
            username: username,
            email: email,
            uid: credential.user!.uid,
            bio: bio,
            followers: [],
            photourl: photoUrl,
            following: []);
        await _firestore.collection('users').doc(credential.user!.uid).set(
              user.toJson(),
            );
        res = "succsses";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> logInUsers({
    required String email,
    required String password,
  }) async {
    String res = "Some error ocured";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
