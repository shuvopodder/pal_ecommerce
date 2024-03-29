import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../Controllers/profile_controller.dart';
import '../elements/DrawerWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../elements/ProfileAvatarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';

class ProfileWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  const ProfileWidget({ Key? key, required this.parentScaffoldKey}) : super(key: key);
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends StateMVC<ProfileWidget> {
  late ProfileController _con;

  _ProfileWidgetState() : super(ProfileController()) {
    _con = controller as ProfileController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.sort, color: Colors.black),
          onPressed: () => _con.scaffoldKey.currentState!.openDrawer(),
        ),
        automaticallyImplyLeading: false,
       // backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headline6?.merge(TextStyle(letterSpacing: 1.3,
              color: Theme.of(context).primaryColor)),
        ),
        actions: const <Widget>[
          ShoppingCartButtonWidget(iconColor: Colors.white, labelColor: Colors.white),
        ],
      ),
      body: _con.user == null
          ? PermissionDeniedWidget()
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Column(
                children: <Widget>[
                //  ProfileAvatarWidget(user: currentUser.value, usermodel: null,),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: Icon(
                      Icons.person,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      "S.of(context).about",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
    /* Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "currentUser.value?.bio" ?? "",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: Icon(
                      Icons.shopping_basket,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      S.of(context).recent_orders,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  _con.recentOrders.isEmpty
                      ? EmptyOrdersWidget()
                      : ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: _con.recentOrders.length,
                          itemBuilder: (context, index) {
                            var _order = _con.recentOrders.elementAt(index);
                            return OrderItemWidget(expanded: index == 0 ? true : false, order: _order);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20);
                          },
                        ),*/
                ],
              ),
            ),
    );
  }
}
