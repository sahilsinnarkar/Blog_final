import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:blog_final/services/crud.dart';
import 'package:blog_final/utils/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  CrudMethod crud = CrudMethod();

  // ignore: non_constant_identifier_names
  Widget BlogsList() {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("blogs").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final userSnapshot = snapshot.data?.docs;
              if (userSnapshot!.isEmpty) {
                return const Text("no data");
              }
              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shrinkWrap: true,
                  itemCount: userSnapshot.length,
                  itemBuilder: (context, index) {
                    return BlogTile(
                      authorName: snapshot.data?.docs[index]['authorName'],
                      title: snapshot.data?.docs[index]['title'],
                      desc: snapshot.data?.docs[index]['desc'],
                      imgUrl: snapshot.data?.docs[index]['imgUrl'],
                    );
                  },
                ),
              );
            })
      ],
    );
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, MyRoutes.logRegRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlogsList(),
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: signUserOut,
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "H O M E",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(8),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes.createRoute);
          },
          child: const Icon(
            Icons.create,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BlogTile extends StatelessWidget {
  String authorName, imgUrl, title, desc;

  BlogTile(
      {Key? key,
      required this.authorName,
      required this.imgUrl,
      required this.desc,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 170,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              imgUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black45.withOpacity(0.4),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  desc,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  authorName,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
