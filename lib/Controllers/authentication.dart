import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/FireStore.dart';

class Authentication extends ChangeNotifier{
  late final GoogleSignIn googleSignIn;
  late final FirebaseAuth firebaseAuth;
  late final FirebaseFirestore firebaseFirestore;
  final SharedPreferences prefs;

  late GlobalKey<ScaffoldState> scaffoldKey;

  Status _status = Status.uninitialized;

  Status get status => _status;

  Authentication( {
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.prefs,
    required this.firebaseFirestore,
  });


  Future<bool> handleGoogleSignIn() async {
    notifyListeners();
    

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User? firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;

      if (firebaseUser != null) {
        final QuerySnapshot result = await firebaseFirestore
            .collection("users")
            .where(FirestoreConstant.id, isEqualTo: firebaseUser.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.length == 0) {
          // Writing data to server because here is a new user
          firebaseFirestore.collection(FirestoreConstant.pathUserCollection).doc(firebaseUser.uid).set({
            FirestoreConstant.name: firebaseUser.displayName,
            // FirestoreConstant.photoUrl: firebaseUser.photoURL,
            FirestoreConstant.id: firebaseUser.uid,
            FirestoreConstant.phone: firebaseUser.phoneNumber,
          });

          // Write data to local storage
          User? currentUser = firebaseUser;
          await prefs.setString(FirestoreConstant.id, currentUser.uid);
          await prefs.setString(FirestoreConstant.name, currentUser.displayName ?? "");
          //await prefs.setString(FirestoreConstant.photoUrl, currentUser.photoURL ?? "");
        } else {
        }

        notifyListeners();

        return true;
      } else {
        notifyListeners();
        return false;
      }
      Navigator.of(scaffoldKey.currentContext!).pushReplacementNamed('/Pages', arguments: 2);

    } else {
      notifyListeners();
      return false;
    }
  }

  handleSignUp(String txtName, String txtEmail, String txtPhn, String txtPass) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: txtEmail, password: txtPass);
      if(userCredential.user!=null){
        final QuerySnapshot result = await firebaseFirestore.collection(FirestoreConstant.pathUserCollection)
            .where(FirestoreConstant.id, isEqualTo:  userCredential.user!.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;

        if(documents.length == 0){
          //when user not exist in database

          firebaseFirestore.collection(FirestoreConstant.pathUserCollection).doc(userCredential.user!.uid).set(
              {
                FirestoreConstant.name : txtName,
                FirestoreConstant.id : userCredential.user!.uid,
                FirestoreConstant.phone : txtPhn,
              });
        }
        print("User Created");
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  handleSignIn(String txtEmail, txtPassword) async {
    _status = Status.authenticating;

    notifyListeners();

    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: txtEmail, password: txtPassword);
      if(userCredential.user!=null){
        _status = Status.authenticated;
        notifyListeners();
        return true;
      }else{
        _status = Status.authenticateCanceled;
        notifyListeners();
        return false;
      }
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');

      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;

    } catch(e){}

  }

}

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateCanceled,
}