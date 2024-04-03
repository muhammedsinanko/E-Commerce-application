// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print

import 'package:cyra_ecommerce/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'login_page.dart';

class RegiserationPage extends StatelessWidget {
  RegiserationPage({super.key});
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 32,
              ),
              Center(
                child: Text(
                  'Register Account',
                  style: GoogleFonts.manrope(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Complete your details',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 40,
                ),
                child: Form(
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
                              return 'Please enter your name';
                            } else {
                              return null;
                            }
                          },
                          controller: nameController,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            hintText: 'Name',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
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
                              return 'enter a valid phone number';
                            } else if (value.length < 10 || value.length > 10) {
                              return 'enter a valid phone number';
                            } else {
                              return null;
                            }
                          },
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            hintText: 'Phone no.',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        margin: const EdgeInsets.only(
                          bottom: 18,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(26, 100, 100, 100),
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            } else {
                              return null;
                            }
                          },
                          controller: addressController,
                          maxLines: 4,
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            hintText: 'address',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 18,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(26, 100, 100, 100),
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            //print('value=$value');
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            } else {
                              return null;
                            }
                          },
                          controller: usernameController,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            hintText: 'Username',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
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
                              return 'Please enter a password';
                            } else {
                              return null;
                            }
                          },
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            hintText: 'Password',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  right: 20,
                  left: 20,
                ),
                child: InkWell(
                  onTap: () {
                    formCheck(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Register',
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
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do you have an account?  ',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return LoginPage();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Log in',
                      style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w900,
                          color: Colors.blueAccent),
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

  formCheck(context) {
    formKey.currentState!.validate();
    final registerName = nameController.text;
    final registerPhoneNo = phoneController.text;
    final registeraAddress = addressController.text;
    final registerUsername = usernameController.text;
    final registerPassword = passwordController.text;
    print('name=$registerName');
    print('phoneNo=$registerPhoneNo');
    print('address=$registeraAddress');
    print('username=$registerUsername');
    print('password=$registerPassword');
    if (registerName.isEmpty ||
        registerPhoneNo.isEmpty ||
        registeraAddress.isEmpty ||
        registerUsername.isEmpty ||
        registerPassword.isEmpty) {
      return null;
    } else {
      registrationToApi(
        context,
        name: registerName,
        phone: registerPhoneNo,
        address: registeraAddress,
        username: registerUsername,
        password: registerPassword,
      );
    }
  }

  registrationToApi(
    context, {
    name,
    phone,
    address,
    username,
    password,
  }) async {
    final Map<String, dynamic> formData = {
      'name': name,
      'phone': phone,
      'address': address,
      'username': username,
      'password': password
    };
    final response = await http.post(
        Uri.parse("http://bootcamp.cyralearnings.com/registration.php"),
        body: formData);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body.contains("success"));
      if (response.body.contains("success")) {
        showSnackbar(
          context,
          "Registeration successfully completed",
          Colors.green,
        );
        print('Registration successfully completed');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return LoginPage();
            },
          ),
        );
      } else {
        String apiFailMessage = 'Something went wrong please try again';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
            content: Text(
              apiFailMessage,
              style: TextStyle(color: Colors.red),
            )));
      }
    } else {
      String apiFailMessage = 'Something went wrong please try again';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          content: Text(
            apiFailMessage,
            style: TextStyle(color: Colors.red),
          )));
    }
  }
}
