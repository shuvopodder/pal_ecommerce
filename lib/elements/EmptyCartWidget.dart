import 'dart:async';

import 'package:flutter/material.dart';

class EmptyCartWidget extends StatefulWidget {
  const EmptyCartWidget({
    Key? key,
  }) : super(key: key);

  @override
  _EmptyCartWidgetState createState() => _EmptyCartWidgetState();
}

class _EmptyCartWidgetState extends State<EmptyCartWidget> {
  bool loading = true;

  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        loading
            ? SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.2),
                ),
              )
            : const SizedBox(),
        Container(
          alignment: AlignmentDirectional.center,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Theme.of(context).focusColor.withOpacity(0.7),
                              Theme.of(context).focusColor.withOpacity(0.05),
                            ])),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 70,
                    ),
                  ),
                  Positioned(
                    right: -30,
                    bottom: -50,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.15),
                        borderRadius: BorderRadius.circular(150),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -20,
                    top: -50,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.15),
                        borderRadius: BorderRadius.circular(150),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Opacity(
                opacity: 0.4,
                child: Text(
                  "Don't have any item in your cart",
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              !loading
                  ? MaterialButton(
                      elevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      onPressed: () {
                        Navigator.of(context).pushNamed('/Pages', arguments: 2);
                      },
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                      color: Theme.of(context).accentColor.withOpacity(1),
                      shape: const StadiumBorder(),
                      child: const Text(
                        "Start exploring,",
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
