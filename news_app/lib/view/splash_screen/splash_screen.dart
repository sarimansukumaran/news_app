import 'package:flutter/material.dart';
import 'package:news_app/utils/color_constants.dart';
import 'package:news_app/view/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.primaryColor,
        body: Center(
            child: Image(
          image: NetworkImage(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/ABC_News_logo_2021.svg/512px-ABC_News_logo_2021.svg.png"),
          fit: BoxFit.fill,
          height: 80,
          width: 150,
        )));
  }
}
