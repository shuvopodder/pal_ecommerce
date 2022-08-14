import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SplashScreenController extends ControllerMVC{
  late GlobalKey<ScaffoldState> scaffoldKey;

  SplashScreenController(){
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
}