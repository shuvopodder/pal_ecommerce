import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pal_ecommerce/Controllers/authentication.dart';
import 'package:pal_ecommerce/Pages/login.dart';
import 'package:pal_ecommerce/provider/CategoryProvider.dart';
import 'package:pal_ecommerce/provider/HomePageProvider.dart';
import 'package:pal_ecommerce/provider/ProductProvider.dart';
import 'package:pal_ecommerce/provider/WishListProvider.dart';
import 'package:pal_ecommerce/route_generator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/Pages.dart';
import 'Pages/login2.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<HomePageProvider>(
              create: (context) => HomePageProvider()),
          ChangeNotifierProvider<CategoryProvider>(
              create: (context) => CategoryProvider()),
          ChangeNotifierProvider<ProductProvider>(
              create: (context) => ProductProvider()),
          ChangeNotifierProvider<WishListProvider>(
              create: (context) => WishListProvider()),
          ChangeNotifierProvider<Authentication>(
              create: (context) => Authentication(
                  firebaseAuth: FirebaseAuth.instance,
                  googleSignIn: GoogleSignIn(),
                  prefs: prefs,
                  firebaseFirestore: firebaseFirestore
              )),
        ], child: const MyApp(),),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalKey<NavigatorState>(),
      //initialRoute:'/Login',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PagesWidget();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
