import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Constant/FireStore.dart';

class Authentication extends ChangeNotifier{
  late final GoogleSignIn googleSignIn;
  late final FirebaseAuth firebaseAuth;
  late final FirebaseFirestore firebaseFirestore;

  late GlobalKey<ScaffoldState> scaffoldKey;

  Authentication( {
    required this.firebaseAuth,
    required this.googleSignIn,
   // required this.prefs,
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
/*
          // Write data to local storage
          User? currentUser = firebaseUser;
          await prefs.setString(FirestoreConstant.id, currentUser.uid);
          await prefs.setString(FirestoreConstant.nickname, currentUser.displayName ?? "");
          await prefs.setString(FirestoreConstant.photoUrl, currentUser.photoURL ?? "");*/
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
}