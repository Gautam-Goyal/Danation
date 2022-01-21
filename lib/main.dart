import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udbhav/Auth/auth_service.dart';
import 'Auth/user_model.dart';
import 'Screens/IntroPage.dart';
import 'package:udbhav/Auth/wrapper.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          // initialData: AuthService(),
          create:(_)=> AuthService(),
          // create: (_) => AuthService().wrapperUser,
        ),
      ],
      child: const MaterialApp(
        title: "Udbhav",
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      prefs.clear();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Wrapper(),
        ),
      );
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const IntroPage(),
        ),
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen(context);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
