// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_final/utils/routes.dart';
import 'package:flutter/material.dart';

class LogRegisterScreen extends StatefulWidget {
  static String route = "/logReg";
  const LogRegisterScreen({super.key});

  @override
  State<LogRegisterScreen> createState() => _LogRegisterScreenState();
}

class _LogRegisterScreenState extends State<LogRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Colors.grey.shade300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LogRegButton(
              buttonName: "Log User In",
              onPress: () {
                Navigator.pushNamed(context, MyRoutes.loginRoute);
              },
            ),
            const SizedBox(
              height: 30,
            ),
            LogRegButton(
              buttonName: "Register User",
              onPress: () {
                Navigator.pushNamed(context, MyRoutes.registerRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LogRegButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPress;

  const LogRegButton({
    Key? key,
    required this.buttonName,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            buttonName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
