import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantae/screens/add_post_screen.dart';
import 'package:plantae/screens/feed_screen.dart';
import 'package:plantae/screens/profile_screen.dart';
import 'package:plantae/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItem = [
  const FeedScreen(),
  // SearchScreen(),
  const  Center(
    child: Text("search"),
  ),
  const addPostScreen(),
  const Center(
    child: Text("notif"),
  ),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
];
