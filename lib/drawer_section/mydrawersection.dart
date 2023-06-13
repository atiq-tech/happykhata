import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:poss/home_page.dart';
import 'package:poss/login_page/log_in_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawerSection extends StatefulWidget {
  const MyDrawerSection({super.key, required this.name});
  final String? name;
  @override
  State<MyDrawerSection> createState() => _MyDrawerSectionState();
}

class _MyDrawerSectionState extends State<MyDrawerSection> {
  bool isClick = true;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 200.0,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 7, 125, 180),
                // image: DecorationImage(
                //     image: AssetImage("assets/dwr.jpg"), fit: BoxFit.cover),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRw8tnmRAobUlTWwXTzG0yJevfymCAQw00wZw&usqp=CAU'),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "${widget.name}",
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 209, 233, 240)),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_alarm,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5.0),
                        RichText(
                            text: TextSpan(
                                text: "http://testapi.happykhata.com",
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontSize: 16.0),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launch("http://testapi.happykhata.com");
                                  })),
                        // Text(
                        //   "http://testapi.happykhata.com",
                        //   style: TextStyle(
                        //       fontSize: 16.0,
                        //       fontWeight: FontWeight.w400,
                        //       color: Colors.white60),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePage(name: widget.name)));
            },
            child: Container(
              height: 45.0,
              width: double.infinity,
              // color: isClick == false ? Colors.black : Colors.blue,
              padding: const EdgeInsets.only(top: 14.0, left: 15.0),
              child: const Text(
                "Profile",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 7, 125, 180),
                ),
              ),
            ),
          ),
          const Divider(thickness: 0.5, height: 1.0, color: Colors.grey),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePage(
                        name: widget.name,
                      )));
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        height: 150.0,
                        width: double.infinity,
                        padding:
                            const EdgeInsets.only(top: 10.0, left: 10.0, right: 5.0),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 8.0, top: 10.0),
                              child: Text(
                                "Logout...!",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 8.0, top: 10.0),
                              child: Text(
                                "Are You Sure Went To Log Out?",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0),
                              ),
                            ),
                            const SizedBox(height: 35.0),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LogInPage()));
                                    },
                                    child: Container(
                                      height: 35.0,
                                      width: 60.0,
                                      decoration: BoxDecoration(
                                          color:
                                              const Color.fromARGB(255, 209, 55, 55),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: const Center(
                                          child: Text(
                                        "YES",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0),
                                      )),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 35.0,
                                      width: 60.0,
                                      decoration: BoxDecoration(
                                          color:
                                              const Color.fromARGB(255, 7, 125, 180),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: const Center(
                                          child: Text(
                                        "NO",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  );
            },
            child: Container(
              height: 45.0,
              width: double.infinity,
              // color: Color.fromARGB(255, 224, 221, 221),
              padding: const EdgeInsets.only(top: 14.0, left: 15.0),
              child: const Text(
                "Sign out",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 7, 125, 180),
                ),
              ),
            ),
          ),
          const Divider(thickness: 0.5, height: 1.0, color: Colors.grey),
        ],
      ),
    );
  }
}
