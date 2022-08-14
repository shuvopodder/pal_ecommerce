
import 'package:flutter/material.dart';
import 'package:pal_ecommerce/Pages/login.dart';

import 'Pages/Home.dart';
import 'Pages/Pages.dart';
import 'Pages/SplashScreen.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/Pages':
        return MaterialPageRoute(builder: (_) => PagesWidget(currentTab: args));
      case '/Home':
       // return MaterialPageRoute(builder: (_) => Home());
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());

      default:
      // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}