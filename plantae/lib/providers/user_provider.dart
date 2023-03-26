import 'package:flutter/material.dart';
import 'package:plantae/model/usermodel.dart';
import 'package:plantae/resources/auth_methods.dart';

class userProvider with ChangeNotifier {
  userModel? _user;
  final AuthMethods _authMethods = AuthMethods();

  userModel get getUser => _user!;

  Future<void> refreshUser() async {
    userModel? user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
