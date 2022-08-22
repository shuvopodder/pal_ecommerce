
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../Controllers/cart_controller.dart';
import '../Model/route_argument.dart';
import '../elements/EmptyCartWidget.dart';
import '../helpers/helper.dart';

class CartWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  CartWidget({Key? key, required this.routeArgument}) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends StateMVC<CartWidget> {
  late CartController _con;

  _CartWidgetState() : super(CartController()) {
    _con = controller as CartController;
  }

  @override
  void initState() {
   // _con.listenForCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
   //     bottomNavigationBar: CartBottomDetailsWidget(con: _con),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              /*if (widget.routeArgument != null) {
                Navigator.of(context).pushReplacementNamed(widget.routeArgument.param, arguments: RouteArgument(id: widget.routeArgument.id));
              } else {
                Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
              }*/
              Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);

            },
            icon: Icon(Icons.arrow_back),
            color: Theme.of(context).hintColor,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text("Cart",),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _con.refreshCarts,
          child: _con.carts.isEmpty
              ? EmptyCartWidget()
              : Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    ListView(
                      primary: true,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            leading: Icon(
                              Icons.shopping_cart,
                              color: Theme.of(context).hintColor,
                            ),
                            title: Text(
                              S.of(context).shopping_cart,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            subtitle: Text(
                              S.of(context).verify_your_quantity_and_click_checkout,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                        ListView.separated(
                          padding: EdgeInsets.only(top: 15, bottom: 120),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: _con.carts.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 15);
                          },
                          itemBuilder: (context, index) {
                            return CartItemWidget(
                              cart: _con.carts.elementAt(index),
                              heroTag: 'cart',
                              increment: () {
                                _con.incrementQuantity(_con.carts.elementAt(index));
                              },
                              decrement: () {
                                _con.decrementQuantity(_con.carts.elementAt(index));
                              },
                              onDismissed: () {
                                _con.removeFromCart(_con.carts.elementAt(index));
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(18),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), offset: Offset(0, 2), blurRadius: 5.0)]),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        onSubmitted: (String value) {
                          _con.doApplyCoupon(value);
                        },
                        cursorColor: Theme.of(context).accentColor,
                        controller: TextEditingController()..text = coupon?.code ?? '',
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                          suffixText: coupon?.valid == null ? '' : (coupon.valid ? S.of(context).validCouponCode : S.of(context).invalidCouponCode),
                          suffixStyle: Theme.of(context).textTheme.caption.merge(TextStyle(color: _con.getCouponIconColor())),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(
                              Icons.confirmation_number,
                              color: _con.getCouponIconColor(),
                              size: 28,
                            ),
                          ),
                          hintText: S.of(context).haveCouponCode,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
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
