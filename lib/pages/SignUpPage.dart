import 'package:diu_project1/models/UIHelper.dart';
import 'package:diu_project1/models/UserModel.dart';
import 'package:diu_project1/pages/CompleteProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../lib3/const/app_color.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  bool obscureText = true;

  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if (email == "" || password == "" || cPassword == "") {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else if (password != cPassword) {
      UIHelper.showAlertDialog(context, "Password Mismatch",
          "The passwords you entered do not match!");
    } else {
      signUp(email, password);
    }
  }

  void signUp(String email, String password) async {
    UserCredential? credential;

    UIHelper.showLoadingDialog(context, "Creating new account..");

    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);

      UIHelper.showAlertDialog(
          context, "An error occured", ex.message.toString());
    }

    if (credential != null) {
      String uid = credential.user!.uid;
      UserModel newUser =
          UserModel(uid: uid, email: email, password:password, fullname: "", profilepic: "");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(newUser.toMap())
          .then((value) {
        print("New User Created!");
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return CompleteProfile(
                userModel: newUser, firebaseUser: credential!.user!);
          }),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.new_color,
        child: ListView(children: [
          Container(
            color: AppColors.new_color,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
          ),
          Container(
            color: AppColors.new_color,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  )),
              padding: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Container(
                // padding: EdgeInsets.symmetric(
                //   horizontal: 10,
                // ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Column(
                    children: [
                      Text(
                        "Tuition Finder",
                        style: TextStyle(
                            color: AppColors.new_color,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        enabled: true,
                        controller: emailController,
                        //obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIconColor: AppColors.new_color,
                          prefixIcon: Icon(Icons.email_outlined),
                          label: Text("Email"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: AppColors.new_color,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: AppColors.new_color),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: passwordController,
                        //obscureText: true,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIconColor: AppColors.new_color,
                          prefixIcon: Icon(Icons.password_rounded),
                          label: Text("Password"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: AppColors.new_color),
                          ),
                          suffixIconColor: AppColors.new_color,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: obscureText
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: cPasswordController,
                        //obscureText: true,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIconColor: AppColors.new_color,
                          prefixIcon: Icon(Icons.password_rounded),
                          label: Text("Confirm Password"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: AppColors.new_color),
                          ),
                          suffixIconColor: AppColors.new_color,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: obscureText
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          checkValues();
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 15),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(275, 50),
                            backgroundColor: AppColors.new_color,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(fontSize: 15),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Log In",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
