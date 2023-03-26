import 'package:flutter/material.dart';
// import 'package:plantae/model/usermodel.dart';
// import 'package:plantae/providers/user_provider.dart';
// import 'package:provider/provider.dart';

// class WebSreenLayout extends StatelessWidget {
//   const WebSreenLayout({
//     Key? key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("web"),
//         );
//   }
// }

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  @override
  Widget build(BuildContext context) {
    // userModel user = Provider.of<userProvider>(context).getUser;
    return const Center(
      child: Text("web"),
    );
  }
}
