import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:poss/const_page.dart';
import 'package:poss/home_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Fetchlogin() async {
    String link = "${BaseUrl}api/v1/login";
    try {
      final formData = FormData.fromMap({
        "username": "${_usernameController.text}",
        "password": "${_passwordController.text}"
      });
      final response = await Dio().post(link, data: formData);
      var item = jsonDecode(response.data);
      print(item);
      // if (item["message"] == "User login successfully") {
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (context) => HomePage()));
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       backgroundColor: Color.fromARGB(255, 7, 125, 180),
      //       duration: Duration(seconds: 1),
      //       content: Center(child: Text("Login successfull"))));
      // }
      GetStorage().write("token", "${item["token"]}");
      GetStorage().write("id", "${item["data"]["id"]}");
      GetStorage().write("name", "${item["data"]["name"]}");
      GetStorage().write("usertype", "${item["data"]["usertype"]}");
      GetStorage().write("image_name", "${item["data"]["image_name"]}");
      GetStorage().write("branch", "${item["data"]["branch"]}");
      print("token : ${GetStorage().read("token")}");
      print("id : ${GetStorage().read("id")}");
      print("name : ${GetStorage().read("name")}");
      print("usertype : ${GetStorage().read("usertype")}");
      print("image_name : ${GetStorage().read("image_name")}");
      print("branch : ${GetStorage().read("branch")}");
      print("name : ${GetStorage().read("name")}");
      var user_name = "${GetStorage().read("name")}";
      print(item["message"]);
      if (item["message"] == "User login successfully") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      name: user_name,
                    )));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromARGB(255, 7, 125, 180),
            duration: Duration(seconds: 1),
            content: Center(child: Text("Login successfull"))));
      }
    } catch (e) {
      print(e);
    }
  }

  String? user_name;
  bool _isObscure = true;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            color: Color.fromARGB(255, 6, 126, 196),
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 9,
                    ),
                    Container(
                      child: CircleAvatar(
                        radius: 45.0,
                        backgroundImage: NetworkImage(GetStorage()
                                    .read("token") ==
                                null
                            ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1Ef6Tfc-iINWf5MeZMwImrhKmY2gKbIQzDA&usqp=CAU"
                            : "http://happykhata.com/uploads/users/${GetStorage().read("image_name")}"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: Text(
                      "Pos Express",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25.0,
                          color: Colors.white),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 260.0,
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.only(left: 20.0, right: 20.0, top: 45.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                color: Color.fromARGB(255, 11, 7, 248),
                                width: 3.2)),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) => value!.isEmpty
                                  ? 'user cannot be blank'
                                  : null,
                              controller: _usernameController,
                              decoration: InputDecoration(
                                label: Text("User Name"),
                                hintText: "User Name",
                                errorStyle: TextStyle(fontSize: 0.0),
                                hintStyle: TextStyle(fontSize: 18.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromARGB(255, 155, 152, 152)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromARGB(255, 185, 185, 185)),
                                ),
                              ),
                              onTap: () async {},
                            ),
                            SizedBox(height: 15.0),
                            TextFormField(
                              obscureText: _isObscure,
                              validator: (value) => value!.isEmpty
                                  ? 'Password cannot be blank'
                                  : null,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(_isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                                suffixIconColor: Colors.grey,
                                errorStyle: TextStyle(fontSize: 0.0),
                                label: Text("Password"),
                                hintText: "Password",
                                hintStyle: TextStyle(fontSize: 18.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromARGB(255, 155, 152, 152)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromARGB(255, 185, 185, 185)),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            AnimatedButton(
                              height: 40,
                              width: 200,
                              text: 'LOG IN',
                              isReverse: true,
                              selectedTextColor: Colors.black,
                              transitionType: TransitionType.BOTTOM_TO_TOP,
                              textStyle: TextStyle(color: Colors.brown),
                              backgroundColor:
                                  Color.fromARGB(255, 154, 183, 233),
                              borderColor: const Color.fromARGB(255, 0, 0, 0),
                              borderRadius: 50,
                              borderWidth: 2,
                              onPress: () {
                                if (_formkey.currentState!.validate()) {
                                  Fetchlogin();
                                  _usernameController.text = "";
                                  _passwordController.text = "";
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Text("Fill all the field")));
                                }
                              },
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     if (_formkey.currentState!.validate()) {
                            //       Fetchlogin();
                            //       _usernameController.text = "";
                            //       _passwordController.text = "";
                            //     } else {
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //           SnackBar(
                            //               duration: Duration(seconds: 1),
                            //               content: Text("Fill all the field")));
                            //     }
                            //   },
                            //   child: Container(
                            //     height: 35.0,
                            //     width: MediaQuery.of(context).size.width,
                            //     decoration: BoxDecoration(
                            //       border: Border.all(
                            //           color: Color.fromARGB(255, 88, 204, 91),
                            //           width: 2.0),
                            //       color: Color.fromARGB(255, 5, 114, 165),
                            //       borderRadius: BorderRadius.circular(10.0),
                            //     ),
                            //     child: Center(
                            //         child: Text(
                            //       "LOG IN",
                            //       style: TextStyle(
                            //           letterSpacing: 1.0,
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.w400),
                            //     )),
                            //   ),
                            // ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
