import 'package:flutter/material.dart';
import 'package:plantae/screens/add_post_screen.dart';
import 'package:plantae/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItem = [
  FeedScreen(),
  Center(
    child: Text("search"),
  ),
  addPostScreen(),
  Center(
    child: Text("notif"),
  ),
  Center(
    child: Text("profile"),
  ),
];
