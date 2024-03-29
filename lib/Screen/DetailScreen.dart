
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pal_ecommerce/Pages/Pages.dart';
import 'package:provider/provider.dart';

import '../Pages/Home.dart';
import '../provider/ProductProvider.dart';
import '../provider/WishListProvider.dart';
import 'checkout.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  const DetailScreen({required this.image, required this.name, required this.price});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int count = 1;
  bool isFavourite =false;


  late ProductProvider productProvider;

  Widget _buildColorProduct({required Color color}) {
    return Container(
      height: 40,
      width: 40,
      color: color,
    );
  }

  final TextStyle myStyle = const TextStyle(
    fontSize: 18,
  );
  Widget _buildImage() {
    return Center(
      child: Container(
        width: 380,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(13),
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.image),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameToDescriptionPart() {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.name, style: myStyle),
              Text(
                "\$ ${widget.price.toString()}",
                style: const TextStyle(
                    color: Color(0xff9b96d6),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text("Description", style: myStyle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscription() {
    return Container(
      height: 170,
      child: Wrap(
        children: const <Widget>[
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  List<bool> sized = [true, false, false, false];
  List<bool> colored = [true, false, false, false];
  int sizeIndex = 0;
  late String size;
  void getSize() {
    if (sizeIndex == 0) {
      setState(() {
        size = "S";
      });
    } else if (sizeIndex == 1) {
      setState(() {
        size = "M";
      });
    } else if (sizeIndex == 2) {
      setState(() {
        size = "L";
      });
    } else if (sizeIndex == 3) {
      setState(() {
        size = "XL";
      });
    }
  }

  int colorIndex = 0;
  late String color;
  void getColor() {
    if (colorIndex == 0) {
      setState(() {
        color = "Light Blue";
      });
    } else if (colorIndex == 1) {
      setState(() {
        color = "Light Green";
      });
    } else if (colorIndex == 2) {
      setState(() {
        color = "Light Yellow";
      });
    } else if (colorIndex == 3) {
      setState(() {
        color = "Cyan";
      });
    }
  }

  Widget _buildSizePart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Size",
          style: myStyle,
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: 265,
          child: ToggleButtons(
            children: const [
              Text("S"),
              Text("M"),
              Text("L"),
              Text("XL"),
            ],
            onPressed: (int index) {
              setState(() {
                for (int indexBtn = 0; indexBtn < sized.length; indexBtn++) {
                  if (indexBtn == index) {
                    sized[indexBtn] = true;
                  } else {
                    sized[indexBtn] = false;
                  }
                }
              });
              setState(() {
                sizeIndex = index;
              });
            },
            isSelected: sized,
          ),
        ),
      ],
    );
  }

  Widget _buildColorPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          "Color",
          style: myStyle,
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: 265,
          child: ToggleButtons(
            fillColor: const Color(0xff746bc9),
            renderBorder: false,
            children: [
              _buildColorProduct(color: Colors.blue),
              _buildColorProduct(color: Colors.green),
              _buildColorProduct(color: Colors.yellow),
              _buildColorProduct(color: Colors.cyan),
            ],
            onPressed: (int index) {
              setState(() {
                for (int indexBtn = 0; indexBtn < colored.length; indexBtn++) {
                  if (indexBtn == index) {
                    colored[indexBtn] = true;
                  } else {
                    colored[indexBtn] = false;
                  }
                }
              });
              setState(() {
                colorIndex = index;
              });
            },
            isSelected: colored,
          ),
        ),
      ],
    );
  }

  Widget _buildQuentityPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          "Quantity",
          style: myStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          width: 130,
          decoration: BoxDecoration(
            color: Color(0xff746bc9),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
                onTap: () {
                  setState(() {
                    if (count > 1) {
                      count--;
                    }
                  });
                },
              ),
              Text(
                count.toString(),
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              GestureDetector(
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  setState(() {
                    count++;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWishlistPart(){
    WishListProvider _wishListProvider;
    _wishListProvider = Provider.of<WishListProvider>(context);

    return Container(
        alignment: Alignment.topRight,

        child: InkWell(
          onTap: (){
            isFavourite ? "": _wishListProvider.addToWishList(widget.name.toString(), widget.image.toString(), widget.price);
            isFavourite ? "":
            Fluttertoast.showToast(
                msg: "Product added to favourite",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0
            );
            setState(() {
              isFavourite ? isFavourite = false : isFavourite = true;
            });
          },
          child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isFavourite
                        ? const Icon(Icons.favorite, size: 50, color: Color(0xFFEF7532))
                        : const Icon(Icons.favorite_border, size: 50, color: Color(0xFFEF7532)),
                  ]
              )
          ),
        )
    );
  }

  Widget _buildButtonPart() {
    return Container(
      //height: 60,
      height: 45,
      width: double.infinity,
      child: RaisedButton(
        child: const Text(
          "Add To Cart",
          style: TextStyle(color: Colors.white),
        ),
        color: const Color(0xff746bc9),
        onPressed: () {
          getSize();
          getColor();
          productProvider.getCheckOutData(
            image: widget.image,
            color: color,
            size: size,
            name: widget.name,
            price: widget.price,
            quantity: count,
          );
          Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => CheckOut(),
          ),
        );},
        //onLongPress: onPressed,
        //onPressed: onPressed,
      ),

      /*MyButton(
        name: "Add To Cart",
        onPressed: () {
          getSize();
          getColor();
          productProvider.getCheckOutData(
            image: widget.image,
            color: color,
            size: size,
            name: widget.name,
            price: widget.price,
            quantity: count,
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => CheckOut(),
            ),
          );
        },
      ),*/
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return await Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => Home(),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Detail Page", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => PagesWidget(),
                ),
              );
            },
          ),
          /*actions: <Widget>[
            NotificationButton(),
          ],*/
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              _buildImage(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildWishlistPart(),
                    _buildNameToDescriptionPart(),
                    _buildDiscription(),
                    _buildSizePart(),
                    _buildColorPart(),
                    _buildQuentityPart(),
                    const SizedBox(
                      height: 15,
                    ),
                    _buildButtonPart(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}