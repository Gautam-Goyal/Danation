import 'package:concentric_transition/page_view.dart';
import "package:flutter/material.dart";
import 'package:udbhav/Auth/LoginPage.dart';
import 'package:udbhav/Auth/wrapper.dart';
import 'package:udbhav/Data/scrollable_content.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        onFinish: () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Wrapper())),
        radius: 40,
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (index, value) {
          return ItemWidget(data: data[index]);
        },
      ),
    );
  }
}
