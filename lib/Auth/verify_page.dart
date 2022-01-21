import 'dart:async';
import 'package:provider/provider.dart';
import 'package:udbhav/Auth/wrapper.dart';
import 'package:udbhav/screens/HomePage.dart';
import 'package:udbhav/Auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyPage extends StatefulWidget {
  VerifyPage(this.user);
  final User user;
  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  // late User user = widget.user;
  late Timer timer;
  // final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    widget.user.sendEmailVerification(); //com.example.udbhav
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  checkEmailVerified() async {
    // User? user = FirebaseAuth.instance.currentUser;
    print("222222222**********${widget.user.emailVerified}  && ${widget.user.email}");
    await widget.user.reload();
    print("333333333**********${widget.user.emailVerified}  && ${widget.user.email}");
    if (widget.user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Wrapper(),
        ),
      );
    }
  }

  // checkEmailVerified() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   print("222222222**********${user!.emailVerified}  && ${user!.email}");
  //   await user!.reload();
  //   print("333333333**********${user!.emailVerified}  && ${user!.email}");
  //   if (user!.emailVerified) {
  //     timer.cancel();
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => const Wrapper(),
  //       ),
  //     );
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService>(context);
    final _size = MediaQuery.of(context).size;
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 0,
          ),
          body: SafeArea(
            child: Container(
              height: _size.height,
              width: _size.width,
              decoration: const BoxDecoration(
                // border: Border.all(),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/message_sent.svg",
                      height:  _size.height / 3,
                    ),
                    SizedBox(
                      height: _size.height / 30,
                    ),
                    Text(
                      "Email Verification",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    SizedBox(
                      height:_size.height / 30 ,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(100),
                                  topRight: Radius.circular(100),
                                ),
                          color: Colors.blueGrey,
                        ),
                        alignment: Alignment.center,
                        width: _size.width ,
                        height:  _size.height / 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "We have send a verification link to ${widget.user.email}. Click on the link to verify your account.",
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height:_size.height / 30 ,
                    ),
                    const Text(
                      "Waiting for verification",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: _size.height / 30,
                    ),
                    const CircularProgressIndicator(
                      color: Colors.blueGrey,
                      strokeWidth: 10,
                    ),
                    SizedBox(
                      height:_size.height / 30 ,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

  }
}
