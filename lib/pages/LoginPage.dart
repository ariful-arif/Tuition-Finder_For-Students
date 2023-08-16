import 'package:diu_project1/lib3/const/app_color.dart';
import 'package:diu_project1/models/UIHelper.dart';
import 'package:diu_project1/models/UserModel.dart';
import 'package:diu_project1/pages/HomePage.dart';
import 'package:diu_project1/pages/SignUpPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../lib3/pages/forgot_password.dart';

class LoginPage extends StatefulWidget {
  // final UserModel userModel;
  // final User firebaseUser;
  // LoginPage({required this.userModel, required this.firebaseUser});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText =true;

  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else {
      logIn(email, password);
    }
  }

  void logIn(String email, String password) async {
    UserCredential? credential;

    UIHelper.showLoadingDialog(context, "Logging In..");

    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      // Close the loading dialog
      Navigator.pop(context);

      // Show Alert Dialog
      UIHelper.showAlertDialog(
          context, "An error occured", ex.message.toString());
    }

    if (credential != null) {
      String uid = credential.user!.uid;

      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      UserModel userModel =
          UserModel.fromMap(userData.data() as Map<String, dynamic>);

      // Go to HomePage
      print("Log In Successful!");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return HomePage(
              userModel: userModel, firebaseUser: credential!.user!);
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      body: Container(
        color: AppColors.new_color,
        child: ListView(
          children: [
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await LaunchApp.openApp(
                                //androidPackageName: 'com.example.tuition_admin_app',
                                androidPackageName:
                                    'org.whiteglow.quickeycalculator',
                                //androidPackageName: 'com.adobe.reader',
                                // iosUrlScheme: 'whiteglow://',
                                // openStore: true
                              );
                            },
                            child: Text(
                              "Become a Tutor",
                              style: TextStyle(fontSize: 10),
                            ),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(60, 30),
                                //primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)))),
                          ),
                          Container(
                            height: 40,
                            width: 4,
                            color: Colors.grey,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Hire a Tutor",
                              style: TextStyle(fontSize: 10),
                            ),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(60, 30),
                                //primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
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
                            onTap: (){
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                              child:obscureText?
                              Icon(Icons.visibility)
                                  :Icon(Icons.visibility_off),),
                        ),
                      ),

                      Padding(
                        padding:  EdgeInsets.zero,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ForgotPassword()));
                            },
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(fontSize: 12,color: Colors.red),
                            ),
                            // style: ElevatedButton.styleFrom(
                            //     minimumSize: Size(150, 50),
                            //     primary: AppColors.new_color,
                            //     shape: RoundedRectangleBorder(
                            //         borderRadius:
                            //         BorderRadius.all(Radius.circular(20)))),
                          ),
                        ),
                      ),
                      Container(alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            checkValues();
                          },
                          child: Text(
                            "Log In",
                            style: TextStyle(fontSize: 14),
                          ),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(200, 50),
                              primary: AppColors.new_color,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(fontSize: 15),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return SignUpPage();
                                  }),
                                );
                              },
                              child: Text(
                                "Sign Up",
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
          ],
        ),
      ),
    );
  }
}
