import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantae/resources/auth_methods.dart';
import 'package:plantae/screens/sigup_screen.dart';
import 'package:plantae/utils/dimenssions.dart';
import 'package:plantae/utils/utils.dart';
import 'package:plantae/widgets/text_field_input.dart';

import '../responsive/mobilescreenlayout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/webscreenlayout.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void logInUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().logInUsers(
        email: _emailController.text, password: _passwordController.text);
    if (res == "success") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const responsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MoblieScreenLayout(),
        );
      }));
    } else {
      showScanbar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
    debugPrint(res);
    // debugPrint(_auth.currentUser!.uid.toString());
  }

  void navigateToSignUp() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const SignUpScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: MediaQuery.of(context).size.width > webScreenSize
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3)
            : const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Container(),
            ),
            const Image(
              image: AssetImage('Logo.png'),
              height: 250,
              width: 250,
            ),
            const SizedBox(
              height: 44,
            ),
            TextFieldInput(
                LableText: "Email",
                hintText: "Enter Your Email",
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              LableText: "Password",
              hintText: "Enter Your Password",
              textEditingController: _passwordController,
              textInputType: TextInputType.visiblePassword,
              isPass: true,
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {
                logInUser();
              },
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text("Login"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  color: Colors.blue,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("Don't have an acoount?"),
                ),
                GestureDetector(
                  onTap: () {
                    navigateToSignUp();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
