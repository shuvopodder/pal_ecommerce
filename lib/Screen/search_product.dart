import 'package:flutter/material.dart';
import 'package:pal_ecommerce/Screen/singeproduct.dart';
import 'package:provider/provider.dart';

import '../Model/product.dart';
import '../provider/ProductProvider.dart';
import 'DetailScreen.dart';

class SearchProduct extends SearchDelegate<void> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ProductProvider providerProvider = Provider.of<ProductProvider>(context);
    List<Product> searchCategory = providerProvider.searchProductList(query);

    return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: searchCategory
            .map((e) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => DetailScreen(
                          image: e.image,
                          name: e.name,
                          price: e.price,
                        ),
                      ),
                    );
                  },
                  child: SingleProduct(
                    image: e.image,
                    name: e.name,
                    price: e.price,
                  ),
                ))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ProductProvider providerProvider = Provider.of<ProductProvider>(context);
    List<Product> searchCategory = providerProvider.searchProductList(query);
    return GridView.count(
        childAspectRatio: 0.76,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: searchCategory
            .map((e) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => DetailScreen(
                          image: e.image,
                          name: e.name,
                          price: e.price,
                        ),
                      ),
                    );
                  },
                  child: SingleProduct(
                    image: e.image,
                    name: e.name,
                    price: e.price,
                  ),
                ))
            .toList());
  }
}
