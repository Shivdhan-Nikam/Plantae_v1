import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantae/model/usermodel.dart';
import 'package:plantae/providers/user_provider.dart';
import 'package:plantae/resources/firestore_methods.dart';
import 'package:plantae/utils/utils.dart';
import 'package:provider/provider.dart';

class addPostScreen extends StatefulWidget {
  const addPostScreen({super.key});

  @override
  State<addPostScreen> createState() => _addPostScreenState();
}

class _addPostScreenState extends State<addPostScreen> {
  final TextEditingController _discriptionController = TextEditingController();
  Uint8List? _file;
  bool _isLoading = false;
  

  void postImage(
    String uid,
    String username,
    String profimage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _discriptionController.text, _file!, uid, username, profimage);
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showScanbar("Posted", context);
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showScanbar(res, context);
      }
    } catch (err) {
      showScanbar(err.toString(), context);
    }
  }

  _selectimage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create a post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take image"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Select from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _discriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userModel user = Provider.of<userProvider>(context).getUser;
    return _file == null
        ? Container(
            child: IconButton(
                onPressed: () {
                  _selectimage(context);
                },
                icon: const Icon(Icons.upload)),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  clearImage();
                },
                icon: Icon(Icons.arrow_back),
              ),
              title: Text("Post to"),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () {
                    return postImage(
                      user.uid,
                      user.username,
                      user.photourl,
                    );
                  },
                  child: const Text(
                    "Post",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(
                        padding: EdgeInsets.only(top: 0),
                      ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photourl),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: _discriptionController,
                        decoration: const InputDecoration(
                          hintText: "Add a caption...",
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ],
            ),
          );
  }
}
