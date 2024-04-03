//import 'package:flutter/material.dart';

//class RegisterationForm extends StatelessWidget {
//  RegisterationForm({
//    super.key,
//  });
//  final formKey = GlobalKey<FormState>();
//  @override
//  Widget build(BuildContext context) {
//    return Form(
//      key: formKey,
//      child: Column(
//        children: [
//          Container(
//            margin: const EdgeInsets.only(bottom: 18),
//            decoration: BoxDecoration(
//              color: const Color.fromARGB(26, 100, 100, 100),
//              borderRadius: BorderRadius.circular(
//                15,
//              ),
//            ),
//            child: TextFormField(
//              validator: (value) {
//                if (value == null || value.isEmpty) {
//                  return 'enter name';
//                }
//              },
//              controller: nameController,
//              decoration: const InputDecoration(
//                contentPadding: EdgeInsets.symmetric(horizontal: 15),
//                hintText: 'Name',
//                border: InputBorder.none,
//              ),
//            ),
//          ),
//          Container(
//            margin: const EdgeInsets.only(bottom: 18),
//            decoration: BoxDecoration(
//              color: const Color.fromARGB(26, 100, 100, 100),
//              borderRadius: BorderRadius.circular(
//                15,
//              ),
//            ),
//            child: TextFormField(
//              controller: phoneController,
//              keyboardType: TextInputType.phone,
//              decoration: const InputDecoration(
//                contentPadding: EdgeInsets.symmetric(horizontal: 15),
//                hintText: 'Phone no.',
//                border: InputBorder.none,
//              ),
//            ),
//          ),
//          Container(
//            height: 100,
//            margin: const EdgeInsets.only(bottom: 18),
//            decoration: BoxDecoration(
//              color: const Color.fromARGB(26, 100, 100, 100),
//              borderRadius: BorderRadius.circular(
//                15,
//              ),
//            ),
//            child: TextFormField(
//              controller: addressController,
//              textDirection: TextDirection.ltr,
//              scrollPhysics: const NeverScrollableScrollPhysics(),
//              decoration: const InputDecoration(
//                contentPadding: EdgeInsets.symmetric(horizontal: 15),
//                hintText: 'address',
//                border: InputBorder.none,
//              ),
//            ),
//          ),
//          Container(
//            margin: const EdgeInsets.only(bottom: 18),
//            decoration: BoxDecoration(
//              color: const Color.fromARGB(26, 100, 100, 100),
//              borderRadius: BorderRadius.circular(
//                15,
//              ),
//            ),
//            child: TextFormField(
//              controller: usernameController,
//              decoration: const InputDecoration(
//                contentPadding: EdgeInsets.symmetric(horizontal: 15),
//                hintText: 'Username',
//                border: InputBorder.none,
//              ),
//            ),
//          ),
//          Container(
//            margin: const EdgeInsets.only(bottom: 18),
//            decoration: BoxDecoration(
//              color: const Color.fromARGB(26, 100, 100, 100),
//              borderRadius: BorderRadius.circular(
//                15,
//              ),
//            ),
//            child: TextFormField(
//              controller: passwordController,
//              obscureText: true,
//              decoration: const InputDecoration(
//                contentPadding: EdgeInsets.symmetric(horizontal: 15),
//                hintText: 'Password',
//                border: InputBorder.none,
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
