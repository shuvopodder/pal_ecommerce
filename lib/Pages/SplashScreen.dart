import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SplashScreen extends StatefulWidget {
  //const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends StateMVC<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
