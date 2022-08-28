import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePageProvider with ChangeNotifier{
  List<String> bannerList = [];

  getBanner(){
    FirebaseFirestore.instance.collection('Banner').get()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            bannerList.add(doc['image'].toString());
          //  print("print: "+doc["image"]);
      });
    });
    notifyListeners();
  }
}