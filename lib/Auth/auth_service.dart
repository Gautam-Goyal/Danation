import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udbhav/Auth/register_page.dart';
import 'package:udbhav/Auth/verify_page.dart';
import 'package:udbhav/Screens/HomePage.dart';
import 'LoginPage.dart';
import 'user_model.dart';
import 'wrapper.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;



  MyUser? _userFromFirebase(auth.User? newUser) {
    if (newUser == null) {
      return null;
    }
    return MyUser(newUser.uid, newUser.email);
  }

  Stream<MyUser?>? get wrapperUser {
    final currentUser = _firebaseAuth.authStateChanges().map(_userFromFirebase);
    return currentUser;
  }

  // Stream<User?>? get user {
  //   final currentUser = _firebaseAuth.authStateChanges();
  //   return currentUser;
  // }

  // MyUser? _userFromFirebase(auth.User? newUser) {
  //   if (newUser == null) {
  //     return null;
  //   }
  //   return MyUser(newUser.uid, newUser.email);
  // }

  signInWithEmailAndPassword(
      String email, String password, BuildContext ctx) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (err) {
      var message = 'An error occurred. Please check your credentials!';

      if (err.message != null) {
        message = err.message!;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    } catch (err) {
      print("*******");
      print(err);
    }
    // await _firebaseAuth.signInWithEmailAndPassword(
    //     email: email, password: password);
    // _userFromFirebase(credential.user);
  }

  createUserWithEmailAndPassword(
      String email, String password, BuildContext ctx) async {
    try {
      auth.UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        Navigator.of(ctx).push(
          MaterialPageRoute(
            builder: (context) => VerifyPage(user),
          ),
        );
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: const Text("Server returned null! Please try again!"),
          backgroundColor: Theme
              .of(ctx)
              .errorColor,
        ));
      }

      //TODO: To check what to do if user is returned null

    } on FirebaseAuthException catch (err) {
      var message = 'An error occurred. Please check your credentials!';

      if (err.message != null) {
        message = err.message!;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (err) {
      print("*******");
      print(err);
    }
    // return _userFromFirebase(credential.user);
  }

  signOut() async {
    await _firebaseAuth.signOut();
  }

  // handleAuthState() {
  //   return StreamBuilder(
  //       stream: _firebaseAuth.authStateChanges(),
  //       builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
  //         if (snapshot.connectionState == ConnectionState.active) {
  //           final User? user = snapshot.data;
  //           return user == null ? LoginPage() : HomePage();
  //         } else {
  //           return Scaffold(
  //             body: Center(
  //               child: CircularProgressIndicator(),
  //             ),
  //           );
  //         }
  //       }
  //   );
  // }
}
