import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pal_ecommerce/elements/CardsCarouselLoaderWidget.dart';
import 'package:pal_ecommerce/elements/DrawerWidget.dart';
import 'package:pal_ecommerce/provider/ProductProvider.dart';
import 'package:provider/provider.dart';
import '../Controllers/home_controller.dart';
import '../Model/product.dart';
import '../Screen/DetailScreen.dart';
import '../Screen/ListProduct.dart';
import '../Screen/singeproduct.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../provider/HomePageProvider.dart';

class Home extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //late final GlobalKey<ScaffoldState> parentScaffoldKey;

  Home({Key? key, parentScaffoldKey}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

late HomePageProvider _homePageProvider;
late ProductProvider _productProvider;

class _HomeState extends StateMVC<Home> {
  late HomeController _con;

  _HomeState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  @override
  Widget build(BuildContext context) {
    _homePageProvider = Provider.of<HomePageProvider>(context);
    _productProvider = Provider.of<ProductProvider>(context);

    _homePageProvider.getBanner();
    _productProvider.getNewAchiveData();
    _productProvider.getFeatureData();
    _productProvider.getHomeFeatureData();
    _productProvider.getHomeAchiveData();

    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.scaffoldKey.currentState?.openDrawer(),
        ),

        automaticallyImplyLeading: false,
        //backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Pal Ecommerce"),
        actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Colors.black, labelColor: Colors.black),
        ],
      ),
      drawer: DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: _con.refreshHome,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildImageSlider(),
              const SizedBox(
                height: 10,
              ),
              _productProvider.feature.isEmpty
                  ? const CardsCarouselLoaderWidget()
                  : _buildDealsOfTheDay(),

              //const SizedBox(height: 10,),
              _buildAllProducts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSlider() {
    List<String> list = _homePageProvider.bannerList;
    return list.isEmpty
        ? CardsCarouselLoaderWidget()
        : Container(
            //height: 100,
            child: ImageSlideshow(
              autoPlayInterval: 3000,
              width: double.infinity,

              /// Width of the [ImageSlideshow].
              height: 200,

              /// Height of the [ImageSlideshow].
              initialPage: 0,

              /// The page to show when first creating the [ImageSlideshow].
              indicatorColor: Colors.blue,

              /// The color to paint the indicator.
              indicatorBackgroundColor: Colors.grey,

              /// The color to paint behind th indicator.
              /// The widgets to display in the [ImageSlideshow].
              /// Add the sample image file into the images folder

              children: [
                /*ListView.builder(
          itemBuilder: (context, index) {
            return Image(image: NetworkImage(list[index]));
          }
          ),*/
                /*Image.asset(
            'assets/images/Google.png',
            fit: BoxFit.cover,
          ),*/

                Image(image: NetworkImage(list[0].toString())),
                Image(image: NetworkImage(list[1].toString())),
                Image(image: NetworkImage(list[2].toString())),
              ],
            ),
          );
  }

  Widget _buildDealsOfTheDay() {
    List<Product> featureProduct;

    featureProduct = _productProvider.getFeatureList;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "Deals Of The Day",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => ListProduct(
                      name: "Featured",
                      isCategory: false,
                      snapShot: featureProduct,
                    ),
                  ),
                );
              },
              child: const Text(
                "View more",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        featureProduct.isEmpty
            ? const CardsCarouselLoaderWidget()
            : Container(
                height: 250, //288,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: featureProduct.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                                image: featureProduct[index].image,
                                price: featureProduct[index].price,
                                name: featureProduct[index].name),
                          ),
                        );
                      },
                      child: SingleProduct(
                        image: featureProduct[index].image,
                        price: featureProduct[index].price,
                        name: featureProduct[index].name,
                      ),
                    );
                  },
                ),
              ),
/*
        Row(
          children: _productProvider.getHomeFeatureList.map((e) {
            return Expanded(
              child:
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                        image: e.image,
                        price: e.price,
                        name: e.name,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(),
                        ),
                      );
                    },
                    child: SingleProduct(
                      image: e.image,
                      price: e.price,
                      name: e.name,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        */
      ],
    );
  }

  Widget _buildAllProducts() {
    //List<Product> newAchivesProduct = productProvider.getNewAchiesList;

    List<Product> featureProduct = _productProvider.getFeatureList;
    return Column(
      children: <Widget>[
        Container(
          height: 50,//250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "All Product",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => ListProduct(
                            name: "All Products",
                            isCategory: false,
                            snapShot: featureProduct,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "View more",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        /*Container(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: featureProduct.length,
              itemBuilder: (BuildContext,int index){
                return Card(
                  color: Colors.amber,
                  child:Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (ctx) => DetailScreen(
                                              image: featureProduct[index].image,
                                              price: featureProduct[index].price,
                                              name: featureProduct[index].name,
                                            ),
                                          ),
                                        );
                                      },
                                      child: SingleProduct(
                                          image: featureProduct[index].image, price: featureProduct[index].price, name: featureProduct[index].name),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (ctx) => DetailScreen(
                                            image: featureProduct[index].image,
                                            price: featureProduct[index].price,
                                            name: featureProduct[index].name,
                                          ),
                                        ),
                                      );
                                    },
                                    child: SingleProduct(
                                        image: featureProduct[index].image, price: featureProduct[index].price, name: featureProduct[index].name),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ) ,
                );
              }),
        )*/
        Row(
            children: _productProvider.getHomeFeatureList.map((e) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => DetailScreen(
                                      image: e.image,
                                      price: e.price,
                                      name: e.name,
                                    ),
                                  ),
                                );
                              },
                              child: SingleProduct(
                                  image: e.image, price: e.price, name: e.name),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }).toList()),
      ],
    );
  }
}
