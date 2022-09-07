import 'package:flutter/material.dart';

class ProfileWidget2 extends StatelessWidget {

  final GlobalKey<ScaffoldState> parentScaffoldKey;
  ProfileWidget2({Key? key, required this.parentScaffoldKey}) : super(key: key);


  List<String> title = [
    "Personal Details",
    "Change Password",
    "Order History",
    "Contact Us",
    "Privacy Policy",
    "Tearms & Conditions",
    "FAQs",
    "Feedback",
    "Share This App",
    "Sing Out"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Back",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        "Account",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                color: Color(0xFF060606),
                endIndent: 10,
                indent: 10,
                thickness: 4,
                // height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                    itemCount: title.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 50,
                            child: ListTile(
                              onTap: () {},
                              title: Text(
                                title[index],
                                style: const TextStyle(
                                    color: Color(0xFF090909),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF090909),
                                size: 20,
                              ),
                            ),
                          ),
                          const Divider(
                            color: Color(0xFF060606),
                            endIndent: 10,
                            indent: 10,
                            thickness: 2.5,
                            // height: 10,
                          ),
                        ],
                      );
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
