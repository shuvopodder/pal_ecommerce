import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pal_ecommerce/Controllers/UserController.dart';

class LoginPage extends StatefulWidget {
 // const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateMVC<LoginPage> {
  late UserController con;

  _LoginPageState() : super(UserController()){
    con = controller as UserController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 50, right: 50, left: 50),
                  child: Form(
                    key: con.loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/shopping.jpg',
                          scale: 6,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        const Text(
                          "Pal Ecommerce",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        //email
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input)=> con.usermodel.email=input!,
                          validator: (input)=>input!.contains('@')
                              ?"Should be a valid email":null,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: const Icon(Icons.alternate_email),
                            labelStyle: const TextStyle(color: Colors.black),
                            hintText: "xyz@gmail.com",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        //password
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input)=> con.usermodel.password=input!,
                          validator: (input)=>input!.length < 3
                              ?"Should be more than 3 character!":null,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.lock_outline),
                            labelStyle: const TextStyle(color: Colors.black),
                            hintText: "*********",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  con.hidePassword = !con.hidePassword;
                                });
                              },
                              //color: Theme.of(context).focusColor,
                              icon: Icon(con.hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        //login button
                        MaterialButton(
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            con.login();
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "  Login ",
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

                        const SizedBox(
                          height: 25,
                        ),
                        MaterialButton(
                          elevation: 0,
                          focusElevation: 0,
                          highlightElevation: 0,
                          onPressed: () {
                            /*Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );*/
                          },
                          textColor: Theme.of(context).hintColor,
                          child: const Text("Signup"),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text("- Or -"),
                      ],
                    ),
                  )
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10, left: 25, right: 25),
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    try {
                      showLoaderDialog(context);
                      con.google_login();
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

  void showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
