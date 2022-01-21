import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udbhav/Auth/LoginPage.dart';
import 'package:udbhav/Auth/auth_service.dart';
import 'package:udbhav/Auth/user_model.dart';
import 'package:udbhav/Screens/HomePage.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context,listen: false);
    return StreamBuilder<MyUser?>(
        stream: authService.wrapperUser,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if( snapshot.connectionState == ConnectionState.active) {
            MyUser? user = snapshot.data;
            if (user == null ){
              return LoginPage();
            }
            print("4444444444-->${user.email}");
            return Provider<MyUser>.value(
              value: user,
              child: HomePage(),
            );
          }
          return Scaffold(
            body: Center(
                child: CircularProgressIndicator()
            ),
          );
        }
    );
    // final authService =
    //     context.watch<User?>();

    //  if(authService!=null){
    //   return const HomePage();
    // }else{
    //    return const LoginPage();
    //  }


    // return StreamBuilder(
    //   stream: FirebaseAuth.instance.authStateChanges(),builder:(ctx,userSnapshot){
    //   if(userSnapshot.hasData){
    //     return HomePage();
    //   }
    //   return LoginPage();
    //   },
    // );
  }
}
