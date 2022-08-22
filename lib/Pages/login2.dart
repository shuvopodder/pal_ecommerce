import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Controllers/authentication.dart';

class LoginPage2 extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

 // const Login2({Key? key}) : super(key: key);

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  @override
  Widget build(BuildContext context) {
    Authentication auth = Provider.of<Authentication>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10, left: 25, right: 25),
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    try {
                      //showLoaderDialog(context);
                      var authres = auth.handleGoogleSignIn();
                      if(authres==true){
                        Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);

                      }
                      // c.login();
                    } on PlatformException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('No PlayStore Detected on the device!')));
                    }
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Google.png',
                            scale: 30,
                          ),
                          const Text(
                            "  Login with Google",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      )),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ));
  }
}
