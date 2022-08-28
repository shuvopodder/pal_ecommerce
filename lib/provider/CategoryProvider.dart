import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Model/Category.dart';


class CategoryProvider with ChangeNotifier{
  List<Category> categorylist = [];
  late Category categoryData;

  Future<void> getCategoryData() async {
    List<Category> list = [];
    QuerySnapshot categorySnapShot = await FirebaseFirestore.instance.collection("CATEGORIES_LIST").get();
    categorySnapShot.docs.forEach((element) {
      categoryData = Category(id: element.id.toString(), name: element["category_name"], image: element["category_image"]);
      list.add(categoryData);
     // print("print: "+element["category_image"]);
      //print("print: "+element.id.toString());

    });
    categorylist = list;
    notifyListeners();
  }
  List<Category> get CategoryList{return categorylist;}

}