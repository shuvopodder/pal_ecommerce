import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleCategory extends StatelessWidget {
  final String image;
  final String name;
  const SingleCategory({Key? key, required this.image, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 150,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(image),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xff9b96d6),
                          )),
                    )))
          ],
        ),
      ),
    );
  }
}
