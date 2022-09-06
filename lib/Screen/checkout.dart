import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/CartModel.dart';
import '../Pages/Home.dart';
import '../provider/ProductProvider.dart';
import 'CheckOutSingleProduct.dart';
import 'mybutton.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextStyle myStyle = const TextStyle(
    fontSize: 18,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late ProductProvider productProvider;

  Widget _buildBottomSingleDetail(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: myStyle,
        ),
        Text(
          endName,
          style: myStyle,
        ),
      ],
    );
  }

  late User user;
  late double total;
  late List<CartModel> myList;

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () {
        productProvider.userModelList.map((e) {
          if (productProvider.getCheckOutModelList.isNotEmpty) {
            FirebaseFirestore.instance.collection("Order").add({
              "Product": productProvider.getCheckOutModelList
                  .map((c) => {
                        "ProductName": c.name,
                        "ProductPrice": c.price,
                        "ProductQuantity": c.quantity,
                        "ProductImage": c.image,
                        "Product Color": c.color,
                        "Product Size": c.size,
                      })
                  .toList(),
              "TotalPrice": total.toStringAsFixed(2),
              "UserName": e.userName,
              "UserEmail": e.userEmail,
              "UserNumber": e.userPhoneNumber,
              "UserAddress": e.userAddress,
              "UserId": user.uid,
            });
            setState(() {
              myList.clear();
            });

            // productProvider.addNotification("Notification");
          } else {
            _scaffoldKey.currentState?.showSnackBar(
              const SnackBar(
                content: Text("No Item Yet"),
              ),
            );
          }
        });
        print("Buy Button pressed!");
      },
      child: const Text(
        "Buy",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  /*Widget _buildButton() {
    return Column(
        children: productProvider.userModelList.map((e) {
      return Container(
        height: 50,
        child: RaisedButton(
          child: const Text(
            "Buy",
            style: TextStyle(color: Colors.white),
          ),
          color: const Color(0xff746bc9),
          onPressed: () {

          if (productProvider.getCheckOutModelList.isNotEmpty) {
              FirebaseFirestore.instance.collection("Order").add({
                "Product": productProvider.getCheckOutModelList
                    .map((c) => {
                          "ProductName": c.name,
                          "ProductPrice": c.price,
                          "ProductQuantity": c.quantity,
                          "ProductImage": c.image,
                          "Product Color": c.color,
                          "Product Size": c.size,
                        })
                    .toList(),
                "TotalPrice": total.toStringAsFixed(2),
                "UserName": e.userName,
                "UserEmail": e.userEmail,
                "UserNumber": e.userPhoneNumber,
                "UserAddress": e.userAddress,
                "UserId": user.uid,
              });
              setState(() {
                myList.clear();
              });

             // productProvider.addNotification("Notification");
            } else {
              _scaffoldKey.currentState?.showSnackBar(
                const SnackBar(
                  content: Text("No Item Yet"),
                ),
              );
            }
          },
        ),

        /*MyButton(
          name: "Buy",
          onPressed: () {
            if (productProvider.getCheckOutModelList.isNotEmpty) {
              FirebaseFirestore.instance.collection("Order").add({
                "Product": productProvider.getCheckOutModelList
                    .map((c) => {
                          "ProductName": c.name,
                          "ProductPrice": c.price,
                          "ProductQuantity": c.quantity,
                          "ProductImage": c.image,
                          "Product Color": c.color,
                          "Product Size": c.size,
                        })
                    .toList(),
                "TotalPrice": total.toStringAsFixed(2),
                "UserName": e.userName,
                "UserEmail": e.userEmail,
                "UserNumber": e.userPhoneNumber,
                "UserAddress": e.userAddress,
                "UserId": user.uid,
              });
              setState(() {
                myList.clear();
              });

             // productProvider.addNotification("Notification");
            } else {
              _scaffoldKey.currentState?.showSnackBar(
                const SnackBar(
                  content: Text("No Item Yet"),
                ),
              );
            }
          },
        ),*/
      );
    }).toList());
  }*/

  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    myList = productProvider.checkOutModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser!;
    double subTotal = 0;
    double discount = 3;
    double discountRupees;
    double shipping = 60;

    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getCheckOutModelList.forEach((element) {
      subTotal += element.price * element.quantity;
    });

    discountRupees = discount / 100 * subTotal;
    total = subTotal + shipping - discountRupees;
    if (productProvider.checkOutModelList.isEmpty) {
      total = 0.0;
      discount = 0.0;
      shipping = 0.0;
    }

    return WillPopScope(
      onWillPop: () async {
        return await Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => Home(),
          ),
        );
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("CheckOut Page",
              style: TextStyle(color: Colors.black)),
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
                  builder: (ctx) => Home(),
                ),
              );
            },
          ),
          /* actions: <Widget>[
            NotificationButton(),
          ],*/
        ),
        bottomNavigationBar: Container(
          height: 70,
          width: 100,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.only(bottom: 15),
          child: _buildButton(),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: ListView.builder(
                    itemCount: myList.length,
                    itemBuilder: (ctx, myIndex) {
                      return CheckOutSingleProduct(
                        index: myIndex,
                        color: myList[myIndex].color,
                        size: myList[myIndex].size,
                        image: myList[myIndex].image,
                        name: myList[myIndex].name,
                        price: myList[myIndex].price,
                        quantity: myList[myIndex].quantity,
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildBottomSingleDetail(
                        startName: "Subtotal",
                        endName: "\$ ${subTotal.toStringAsFixed(2)}",
                      ),
                      _buildBottomSingleDetail(
                        startName: "Discount",
                        endName: "${discount.toStringAsFixed(2)}%",
                      ),
                      _buildBottomSingleDetail(
                        startName: "Shipping",
                        endName: "\$ ${shipping.toStringAsFixed(2)}",
                      ),
                      _buildBottomSingleDetail(
                        startName: "Total",
                        endName: "\$ ${total.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
