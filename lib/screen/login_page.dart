// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:cyra_ecommerce/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'registeration_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  //bool isLoggedin = false;
  @override
  void initState() {
    super.initState();
    prefsCheck(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Center(
                child: Text(
                  'Welcome Back!',
                  style: GoogleFonts.manrope(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  'Login with your username and password',
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(26, 100, 100, 100),
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          } else {
                            return null;
                          }
                        },
                        controller: usernameController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintText: 'Username',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(26, 100, 100, 100),
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          hintText: 'Password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  //prefsChech(context);
                  formCheck(context);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: GoogleFonts.manrope(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return RegiserationPage();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Go to register",
                      style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void prefsCheck(context) async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedin = prefs.getBool('isLoggedin') ?? false;
    print(isLoggedin);
    if (isLoggedin) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return HomePage();
        //return SharedP();
      }));
    }
  }

  dynamic formCheck(context) {
    formKey.currentState!.validate();
    final username = usernameController.text;
    final password = passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      return null;
    }
    postToApi(context: context, username: username, password: password);
  }

  //void isLoggedinCheck(context) async {
  postToApi({context, username, password}) async {
    var result;
    final Map<String, dynamic> loginData = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
        Uri.parse("http://bootcamp.cyralearnings.com/login.php"),
        body: loginData);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      if (response.body.contains("success")) {
        final prefs = await SharedPreferences.getInstance();
        final prefsBool = await prefs.setBool(
          "isLoggedin",
          true,
        );
        final prefsUsername = await prefs.setString("username", username);
        showSnackbar(context, "Login completed", Colors.green);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) {
              return HomePage();
            },
          ),
        );
        print('bool=$prefsBool');
        print('usernamep=$prefsUsername');
      } else {
        showSnackbar(
            context, "Something went wrong, please try again", Colors.red);
        print('login failed');
      }
    } else {
      result = {log(json.decode(response.body)['error'].toString())};
    }
    return result;
  }
}
