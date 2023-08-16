// import 'dart:developer';
// import 'dart:ui';
//
// import 'package:diu_project1/lib3/pages/log_in.dart';
// import 'package:diu_project1/lib3/pages/user_form.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class SignUp extends StatefulWidget {
//   static const String routeName = '/signup';
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _cPasswordController = TextEditingController();
//   final TextEditingController _userNameController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Signup Screen..',
//                     style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black26),
//                   ),
//                   const SizedBox(height: 30),
//                   TextFormField(
//                     //keyboardType: TextInputType.emailAddress,
//                     controller: _userNameController,
//                     onSaved: (value) {},
//                     decoration: const InputDecoration(
//                         icon: Icon(Icons.supervised_user_circle),
//                         hintText: 'User Name',
//                         filled: true,
//                         border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(15)))),
//                   ),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     keyboardType: TextInputType.emailAddress,
//                     controller: _emailController,
//                     onSaved: (value) {},
//                     decoration: const InputDecoration(
//                       icon: Icon(Icons.email),
//                       hintText: 'Email',
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     //keyboardType: TextInputType.emailAddress,
//                     controller: _cPasswordController,
//                     onSaved: (value) {},
//                     decoration: const InputDecoration(
//                       icon: Icon(Icons.password),
//                       hintText: 'Password',
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     //keyboardType: TextInputType.emailAddress,
//                     controller: _passwordController,
//                     onSaved: (value) {},
//                     decoration: const InputDecoration(
//                       icon: Icon(Icons.password),
//                       hintText: 'Confirm Password',
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   InkWell(
//                     onTap: () {
//                       createAccount();
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       height: 50,
//                       width: 180,
//                       decoration: BoxDecoration(
//                           color: Colors.grey.shade300,
//                           borderRadius: BorderRadius.circular(15),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Colors.purple,
//                                 spreadRadius: 1,
//                                 blurRadius: 8,
//                                 offset: Offset(5, 5)),
//                             BoxShadow(
//                                 color: Colors.grey,
//                                 spreadRadius: 1,
//                                 blurRadius: 8,
//                                 offset: Offset(3, 3)),
//                           ]),
//                       child: const Text(
//                         "SignUp",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.purple),
//                       ),
//                     ),
//                   ),
//                   // ElevatedButton(
//                   //     onPressed: () {
//                   //       createAccount();
//                   //     },
//                   //     child: Text("Sign Up"))
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const Text("Already have an account?"),
//               TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, LogIn.routeName);
//                   },
//                   child: const Text("Login")),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void createAccount() async {
//     String user = _userNameController.text.trim();
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();
//     String cPassword = _cPasswordController.text.trim();
//
//     if (user == "" || email == "" || password == "" || cPassword == "") {
//       Fluttertoast.showToast(msg: "Please fill all the details");
//     } else if (password != cPassword) {
//       Fluttertoast.showToast(msg: "Passwords don't match");
//     } else {
//       try {
//         UserCredential userCredential = await FirebaseAuth.instance
//             .createUserWithEmailAndPassword(email: email, password: password);
//         if (userCredential.user != null) {
//           // Navigator.pop(context);
//           Navigator.push(context, MaterialPageRoute(builder: (_)=>UserForm()));
//         }
//       } on FirebaseAuthException catch (ex) {
//         log(ex.code.toString());
//       }
//     }
//   }
// }
