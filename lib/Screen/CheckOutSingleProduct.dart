import 'package:flutter/cupertino.dart';

class CheckOutSingleProduct extends StatefulWidget {
  const CheckOutSingleProduct({Key? key, required int index, required String color, required String size, required String image, required String name, required double price, required int quantity}) : super(key: key);

  @override
  State<CheckOutSingleProduct> createState() => _CheckOutSingleProductState();
}

class _CheckOutSingleProductState extends State<CheckOutSingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
