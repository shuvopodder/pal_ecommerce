import 'package:flutter/cupertino.dart';
import 'package:pal_ecommerce/Model/WishList.dart';

import '../Model/WishList.dart';

class WishListProvider with  ChangeNotifier{
  List<WishList> wishlist = [];
  late WishList wishListData;

  addToWishList(String name, String image, double price){
    wishlist.add(WishList(name: name, image: image, price: price));
    notifyListeners();
  }

}