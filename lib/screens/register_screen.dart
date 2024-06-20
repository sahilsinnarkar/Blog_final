import 'dart:async';
import 'package:blog_final/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onPressed;

  const RegisterScreen({super.key, this.onPressed});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();

  void signUserUp() async {
    // create user
    try {
      // if password and confirmed password are same
      if (passwordController.text == confirmedPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // ignore: use_build_context_synchronously
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          Timer(const Duration(seconds: 0),
              () => Navigator.pushNamed(context, MyRoutes.homeRoute));
        } else {
          Timer(const Duration(seconds: 0),
              () => Navigator.pushNamed(context, MyRoutes.loginRoute));
        }
      } else {
        showErrorMessage("Passwords dont match!");
      }
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // show error msg
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/images/login_blog.png"),
                ),

                const SizedBox(
                  height: 30,
                ),

                const Text(
                  "Hey Blogger!",
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(
                  height: 30,
                ),

                // login details
                MyTextField(
                  controller: emailController,
                  hintext: "Email ID",
                  obsecuretext: false,
                ),

                const SizedBox(
                  height: 15,
                ),

                MyTextField(
                  controller: passwordController,
                  hintext: "Password",
                  obsecuretext: true,
                ),

                const SizedBox(
                  height: 15,
                ),

                MyTextField(
                  controller: confirmedPasswordController,
                  hintext: "Confirm Password",
                  obsecuretext: true,
                ),

                const SizedBox(
                  height: 15,
                ),

                // Sign in button
                GestureDetector(
                  onTap: signUserUp,
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                // Continue with

                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: Colors.grey.shade500,
                    )),
                    const Text("Already a User?"),
                    Expanded(
                        child: Divider(
                      color: Colors.grey.shade500,
                    ))
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),

                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.loginRoute);
                  },
                  child: const Text(
                    "Log User In",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintext;
  final bool obsecuretext;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintext,
      required this.obsecuretext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: obsecuretext,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintext,
        ),
      ),
    );
  }
}
