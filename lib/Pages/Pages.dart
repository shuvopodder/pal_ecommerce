import 'package:flutter/material.dart';
import 'package:pal_ecommerce/Pages/CategoryPage.dart';
import 'package:pal_ecommerce/Pages/profile.dart';
import 'package:pal_ecommerce/Pages/profile2.dart';

import '../Model/route_argument.dart';
import '../elements/DrawerWidget.dart';
import '../helpers/helper.dart';
import 'Home.dart';
import 'WishListPage.dart';

class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  late RouteArgument routeArgument;
  
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget currentPage =  Home();
  PagesWidget({
    Key? key,
    this.currentTab,}) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 2;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }
  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = CategoryPage(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          widget.currentPage = WishListPage( parentScaffoldKey: widget.scaffoldKey);
          break;
        case 2:
          widget.currentPage = Home(parentScaffoldKey: widget.scaffoldKey,);
          break;
        case 3:
          widget.currentPage = Home(parentScaffoldKey: widget.scaffoldKey,);
          break;
        case 4:
          widget.currentPage = ProfileWidget2( parentScaffoldKey: widget.scaffoldKey);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: widget.scaffoldKey,
        drawer: DrawerWidget(),
        /*endDrawer: FilterWidget(onFilter: (filter) {
          Navigator.of(context)
              .pushReplacementNamed('/Pages', arguments: widget.currentTab);
        }),*/

        body: widget.currentPage,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 22,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 28),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: widget.currentTab,
          onTap: (int i) {
            this._selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: '',
            ),
            BottomNavigationBarItem(
                label: '',
                icon: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).accentColor.withOpacity(0.4),
                          blurRadius: 40,
                          offset: Offset(0, 15)),
                      BoxShadow(
                          color: Theme.of(context).accentColor.withOpacity(0.4),
                          blurRadius: 13,
                          offset: Offset(0, 3))
                    ],
                  ),
                  child: const Icon(Icons.home,
                      color: Colors.white),
                )),
            const BottomNavigationBarItem(
              icon: Icon(Icons.arrow_back),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}