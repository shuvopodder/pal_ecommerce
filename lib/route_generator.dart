
import 'package:flutter/material.dart';
import 'package:pal_ecommerce/Pages/login.dart';
import 'package:pal_ecommerce/Screen/checkout.dart';

import 'Model/route_argument.dart';
import 'Pages/Home.dart';
import 'Pages/Pages.dart';
import 'Pages/SplashScreen.dart';
import 'Pages/cart.dart';

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
      case '/CheckOut':
        return MaterialPageRoute(builder: (_)=>CheckOut());

      case '/Cart':
        return MaterialPageRoute(builder: (_) => CartWidget(routeArgument: args as RouteArgument));

      default:
      // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}