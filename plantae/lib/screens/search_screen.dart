import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/usermodel.dart';
import '../providers/user_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isShowUser = false;
  final TextEditingController searchController = TextEditingController();

  // @override
  // void dispose() {
  //   super.dispose();
  //   searchController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final userModel user = Provider.of<userProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: 'Search for user',
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUser = true;
            });
          },
        ),
      ),
      body: isShowUser
          ? StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('username', isGreaterThanOrEqualTo: searchController.text)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data!.docs[index]['photourl'].toString()),
                          ),
                          title: Text(snapshot.data!.docs[index]['username'].toString()),
                        ),
                      );
                    });
              })
          : Text("post"),
    );
  }
}
