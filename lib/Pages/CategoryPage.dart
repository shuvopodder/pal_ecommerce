import 'package:flutter/material.dart';
import 'package:pal_ecommerce/Model/Category.dart';
import 'package:pal_ecommerce/Pages/CategoryWiseView.dart';
import 'package:pal_ecommerce/provider/CategoryProvider.dart';
import 'package:provider/provider.dart';

import '../Screen/SingleCategory.dart';
import '../elements/CardsCarouselLoaderWidget.dart';
import '../elements/DrawerWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';

class CategoryPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  CategoryPage({Key? key, parentScaffoldKey}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

late CategoryProvider _categoryProvider;

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    _categoryProvider = Provider.of<CategoryProvider>(context);
    _categoryProvider.getCategoryData();

    List<Category> categoryDataList;
    categoryDataList = _categoryProvider.categorylist;

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
        title: const Text("Pal Ecommerce"),
        actions: const <Widget>[
          ShoppingCartButtonWidget(
              iconColor: Colors.white, labelColor: Colors.white),
        ],
      ),
      drawer: DrawerWidget(),
      body: categoryDataList.isEmpty
          ? const CardsCarouselLoaderWidget()
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: categoryDataList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => CategoryWiseView(id: categoryDataList[index].id),
                      ),
                    );
                  },
                  child: SingleCategory(
                    image: categoryDataList[index].image.toString(),
                    name: categoryDataList[index].name.toString(),
                  ),
                );
              },
            ),
    );
  }
}
