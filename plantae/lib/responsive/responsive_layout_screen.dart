import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plantae/providers/user_provider.dart';
import 'package:plantae/utils/dimenssions.dart';
import 'package:provider/provider.dart';

// class responsiveLayout extends StatelessWidget {
//   final Widget webScreenLayout;
//   final Widget mobileScreenLayout;
//   const responsiveLayout(
//       {Key? key,
//       required this.webScreenLayout,
//       required this.mobileScreenLayout})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, Constraints) {
//       if (Constraints.maxWidth > webScreenSize) {
//         return webScreenLayout;
//       }
//       return mobileScreenLayout;
//     });
//   }
// }

class responsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const responsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);
  @override
  State<responsiveLayout> createState() => _responsiveLayoutState();
}

class _responsiveLayoutState extends State<responsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    userProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth > webScreenSize) {
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
    });
  }
}
