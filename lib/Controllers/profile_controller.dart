import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class ProfileController extends ControllerMVC {
  //List<Order> recentOrders = [];
  late GlobalKey<ScaffoldState> scaffoldKey;
  var email;
  var name;
  var users;

  ProfileController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    userInfo();
    //listenForRecentOrders();
  }
/*
  void listenForRecentOrders({String message}) async {
    final Stream<Order> stream = await getRecentOrders();
    stream.listen((Order _order) {
      setState(() {
        recentOrders.add(_order);
      });
    }, onError: (a) {
      logger.e(a);
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  Future<void> refreshProfile() async {
    recentOrders.clear();
    listenForRecentOrders(message: S.of(state.context).orders_refreshed_successfuly);
  }*/
  userInfo(){
    this.users = FirebaseAuth.instance.authStateChanges();
    this.name = FirebaseAuth.instance.currentUser!.displayName;
    this.email = FirebaseAuth.instance.currentUser!.email;
  }
  Stream<User?> get user {
    return FirebaseAuth.instance.authStateChanges();
  }
}
