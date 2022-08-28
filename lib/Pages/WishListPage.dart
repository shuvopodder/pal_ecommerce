import 'package:flutter/material.dart';
import 'package:pal_ecommerce/Model/WishList.dart';
import 'package:pal_ecommerce/provider/WishListProvider.dart';
import 'package:provider/provider.dart';

import '../Screen/DetailScreen.dart';
import '../Screen/singeproduct.dart';
import '../elements/CardsCarouselLoaderWidget.dart';
import '../elements/DrawerWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';

class WishListPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  WishListPage({Key? key, parentScaffoldKey}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}
late WishListProvider _wishListProvider;

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    _wishListProvider = Provider.of<WishListProvider>(context);
    final Orientation orientation = MediaQuery.of(context).orientation;

    // _categoryProvider.getCategoryData();

    List<WishList> wishDataList;
    wishDataList = _wishListProvider.wishlist;

    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.scaffoldKey.currentState?.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: const Text("Favourite"),
        actions: const <Widget>[
          ShoppingCartButtonWidget(
              iconColor: Colors.white, labelColor: Colors.white),
        ],
      ),
      drawer: DrawerWidget(),
      body: wishDataList.isEmpty
          ? const CardsCarouselLoaderWidget()
          : Container(
        height: 700,
        child: GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          childAspectRatio: orientation == Orientation.portrait ? 0.8 : 0.9,
          scrollDirection: Axis.vertical,
          children: wishDataList
              .map((e) => GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => DetailScreen(
                      image: e.image,
                      price: e.price,
                      name: e.name
                  )));
            },
            child: SingleProduct(
              price: e.price,
              image: e.image,
              name: e.name,
            ),
          ),
          ).toList(),
        ),
      )
    );
  }
}
