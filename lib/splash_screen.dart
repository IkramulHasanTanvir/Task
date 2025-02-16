import 'package:flutter/material.dart';
import 'package:tanvir/auth/sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _moveNextScreen();
    super.initState();
  }
  Future<void> _moveNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if(mounted) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return const SignIn();
    }), (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.grey.shade600, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Task Manager',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
