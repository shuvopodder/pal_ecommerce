import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Model/CartModel.dart';
import '../Model/product.dart';
import '../Model/usermodel.dart';

class ProductProvider with ChangeNotifier {
  List<Product> feature = [];
  late Product featureData;

  List<CartModel> checkOutModelList = [];
  late CartModel checkOutModel;
  List<UserModel> userModelList = [];
  late UserModel userModel;

  Future<void> getUserData() async {
    List<UserModel> newList = [];
    User? currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapShot =
    await FirebaseFirestore.instance.collection("User").get();
    userSnapShot.docs.forEach(
          (element) {
        if (currentUser?.uid == element["UserId"]) {
          userModel = UserModel(
              userAddress: element["UserAddress"],
              userImage: element["UserImage"],
              userEmail: element["UserEmail"],
              userGender: element["UserGender"],
              userName: element["UserName"],
              userPhoneNumber: element["UserNumber"]);
          newList.add(userModel);
        }
        userModelList = newList;
      },
    );
  }

  List<UserModel> get getUserModelList {
    return userModelList;
  }

  void deleteCheckoutProduct(int index) {
    checkOutModelList.removeAt(index);
    notifyListeners();
  }

  void clearCheckoutProduct() {
    checkOutModelList.clear();
    notifyListeners();
  }

  void getCheckOutData({
    required int quantity,
    required double price,
    required String name,
    required String color,
    required String size,
    required String image,
  }) {
    checkOutModel = CartModel( color: color, size: size, price: price, name: name, image: image, quantity: quantity,);
    checkOutModelList.add(checkOutModel);
  }

  List<CartModel> get getCheckOutModelList {
    return List.from(checkOutModelList);
  }

  int get getCheckOutModelListLength {
    return checkOutModelList.length;
  }

  Future<void> getFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot = await FirebaseFirestore.instance
        .collection("Category")
        .get();

    featureSnapShot.docs.forEach((element) {
        featureData = Product(
            image: element["image"],
            name: element["name"],
            price: double.parse(element["price"].toString()));
        newList.add(featureData);
      },
    );
    feature = newList;
  }

  List<Product> get getFeatureList {
    return feature;
  }

  List<Product> homeFeature = [];

  Future<void> getHomeFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot =
    await FirebaseFirestore.instance.collection("Category").get();
    featureSnapShot.docs.forEach(
          (element) {
        featureData = Product(
            image: element["image"],
            name: element["name"],
            price: double.parse(element["price"].toString()));
        newList.add(featureData);
      },
    );
    homeFeature = newList;
    notifyListeners();
  }

  List<Product> get getHomeFeatureList {
    return homeFeature;
  }

  List<Product> homeAchive = [];

  Future<void> getHomeAchiveData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot =
    await FirebaseFirestore.instance.collection("Category").get();
    featureSnapShot.docs.forEach(
          (element) {
        featureData = Product(
            image: element["image"],
            name: element["name"],
            price: double.parse(element["price"].toString()));
        newList.add(featureData);
      },
    );
    homeAchive = newList;
    notifyListeners();
  }

  List<Product> get getHomeAchiveList {
    return homeAchive;
  }

  List<Product> newAchives = [];
  late Product newAchivesData;
  Future<void> getNewAchiveData() async {
    List<Product> newList = [];
    QuerySnapshot achivesSnapShot = await FirebaseFirestore.instance
        .collection("products")
        .doc("hfPmMokn0tbAuGZvRMy1")
        .collection("newachives")
        .get();
    achivesSnapShot.docs.forEach((element) {
      newAchivesData = Product(
          image: element["image"],
          name: element["name"],
          price: element["price"]);
      newList.add(newAchivesData);
      },
    );
    newAchives = newList;
    notifyListeners();
  }

  List<Product> get getNewAchiesList {
    return newAchives;
  }

  List<String> notificationList = [];

  void addNotification(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }

  get getNotificationList {
    return notificationList;
  }

  late List<Product> searchList;
  void getSearchList({required List<Product> list}) {
    searchList = list;
  }

  List<Product> searchProductList(String query) {
    List<Product> searchShirt = searchList.where((element) {
      return element.name.toUpperCase().contains(query) || element.name.toLowerCase().contains(query);
    }).toList();
    return searchShirt;
  }
}
