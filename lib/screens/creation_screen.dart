import 'dart:io';
import 'package:blog_final/services/crud.dart';
import 'package:blog_final/utils/routes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreationScreen extends StatefulWidget {
  const CreationScreen({super.key});

  @override
  State<CreationScreen> createState() => _CreationScreenState();
}

class _CreationScreenState extends State<CreationScreen> {
  late String authorName, title, desc;

  File? selectedImg;
  bool _isLoading = false;

  CrudMethod crud = CrudMethod();
  Future getImage() async {
    final ImagePicker img = ImagePicker();
    final image = await img.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImg = File(image!.path);
    });
  }

  uploadBlog() async {
    setState(() {
      _isLoading = true;
    });
    // ignore: prefer_typing_uninitialized_variables
    var imageUrl;
    if (selectedImg != null) {
      // upload img to firebase
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");
      UploadTask task = firebaseStorageRef.putFile(selectedImg!);
      task.whenComplete(() async {
        try {
          imageUrl = await firebaseStorageRef.getDownloadURL();
        } catch (e) {
          print(e);
        }
        print(imageUrl);

        Map<String, String> blogMap = {
          "imgUrl": imageUrl,
          "authorName": authorName,
          "title": title,
          "desc": desc,
        };

        crud.addData(blogMap).then((value) {
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, MyRoutes.homeRoute);
        });
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              uploadBlog();
            },
            icon: const Icon(
              Icons.upload_rounded,
              color: Colors.black,
            ),
          ),
        ],
        title:
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "C R E A T E",
            style: TextStyle(
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ]),
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          getImage();
                        },
                        child: selectedImg != null
                            ? Container(
                                height: 170,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.file(
                                    selectedImg!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                height: 170,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey.shade600),
                                child: const Icon(
                                  Icons.add_a_photo_rounded,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                              hintText: "Author",
                              hintStyle: TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                              )),
                            ),
                            onChanged: (val) {
                              authorName = val;
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              hintText: "Title",
                              hintStyle: TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.grey,
                              )),
                            ),
                            onChanged: (val) {
                              title = val;
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              hintText: "Description",
                              hintStyle: TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.grey,
                              )),
                            ),
                            onChanged: (val) {
                              desc = val;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
