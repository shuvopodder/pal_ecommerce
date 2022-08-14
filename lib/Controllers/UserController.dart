import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pal_ecommerce/Model/User.dart';

class UserController extends ControllerMVC{

  UserModel usermodel = UserModel();
  bool hidePassword = true;
  var isLoggedIn = false;
  var googleSignIn = GoogleSignIn();
  var firebaseauth = FirebaseAuth.instance.currentUser;
  //OverlayEntry loader;


  late GlobalKey<FormState> loginFormKey;
  late GlobalKey<ScaffoldState> scaffoldKey;

  UserController(){
    loginFormKey = GlobalKey<FormState>();
    scaffoldKey = GlobalKey<ScaffoldState>();
  }
  getName(){
    return firebaseauth?.displayName.toString();
  }
  isLogedIn(){
    if(firebaseauth == null){
      return false;
    }else{
      return true;
    }
  }
  Stream<User?> get user {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }


  void login() async {
    /*
    loader = Helper.overlayLoader(state.context);
    FocusScope.of(state?.context).unfocus();
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState?.save();
      Overlay.of(state!.context).insert(loader);
      repository.login(user).then((value) {
        if (value != null && value.apiToken != null) {
          Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
        } else {
          ScaffoldMessenger.of(scaffoldKey.currentContext).showSnackBar(SnackBar(
            content: Text(S.of(state.context).wrong_email_or_password),
          ));
        }
      }).catchError((e) {
        loader.remove();
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(S.of(state.context).this_account_not_exist),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }*/
  }
  Future<void> google_login() async {
    //Navigator.of(scaffoldKey.currentContext!).pushReplacementNamed('/Home');

    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    if(googleSignInAccount == null){

    }else{
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      OAuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      try{
        await FirebaseAuth.instance.signInWithCredential(authCredential);
        print(FirebaseAuth.instance.currentUser?.displayName.toString());
        //isLoggedIn.value = true;
        Navigator.of(scaffoldKey.currentContext!).pushReplacementNamed('/Pages', arguments: 2);


      }catch (e){}
    }
  }
}