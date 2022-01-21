import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udbhav/Auth/auth_service.dart';
// import 'package:udbhav/Auth/user_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  authService.signOut();
                },
                child: const Text("Logout"))
          ],
        ),
      ),
    );
  }
}
