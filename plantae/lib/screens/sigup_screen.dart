import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantae/resources/auth_methods.dart';
import 'package:plantae/responsive/mobilescreenlayout.dart';
import 'package:plantae/screens/login_screen.dart';
import 'package:plantae/utils/utils.dart';
import 'package:plantae/widgets/text_field_input.dart';

import '../responsive/responsive_layout_screen.dart';
import '../responsive/webscreenlayout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isLoading = false;
  Uint8List? _image;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      username: _userNameController.text,
      file: _image!,
    );
    debugPrint(res);
    setState(() {
      _isLoading = false;
    });
    if (res != 'succsses') {
      showScanbar(res, context);
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const responsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MoblieScreenLayout(),
        );
      }));
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const LogInScreen();
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Image(
              image: AssetImage('JoinLogo.png'),
              height: 250,
              width: 250,
            ),
            const SizedBox(
              height: 24,
            ),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: AssetImage('profile_logo.png'),
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: Icon(Icons.add_a_photo)),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
                LableText: "User Name",
                hintText: "Enter Your User Name",
                textEditingController: _userNameController,
                textInputType: TextInputType.text),
            const SizedBox(
              height: 24,
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
            TextFieldInput(
                LableText: "Bio",
                hintText: "Enter Your Bio",
                textEditingController: _bioController,
                textInputType: TextInputType.text),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {
                signUpUser();
              },
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text("Sign Up"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  color: Colors.blue,
                ),
              ),
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text("Already have an acoount?"),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: () {
                    navigateToLogin();
                  },
                  child: Container(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
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
