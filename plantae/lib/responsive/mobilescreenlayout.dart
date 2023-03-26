import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantae/utils/dimenssions.dart';

class MoblieScreenLayout extends StatefulWidget {
  const MoblieScreenLayout({super.key});

  @override
  State<MoblieScreenLayout> createState() => _MoblieScreenLayoutState();
}

class _MoblieScreenLayoutState extends State<MoblieScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItem,
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _page == 0 ? Colors.blue : Colors.grey,
              ),
              label: '',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _page == 1 ? Colors.blue : Colors.grey,
              ),
              label: '',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: _page == 2 ? Colors.blue : Colors.grey,
              ),
              label: '',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: _page == 3 ? Colors.blue : Colors.grey,
              ),
              label: '',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _page == 4 ? Colors.blue : Colors.grey,
              ),
              label: '',
              backgroundColor: Colors.white),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
