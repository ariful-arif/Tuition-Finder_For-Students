import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../pages/LoginPage.dart';
import '../const/app_color.dart';

class ForgotPassword extends StatefulWidget {
  // final UserModel userModel;
  // final User firebaseUser;
  // ForgotPassword({required this.userModel, required this.firebaseUser});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
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
              child: Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TextField(
                        enabled: true,
                        controller: passwordController,
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
                      // TextField(
                      //   controller: passwordController,
                      //   decoration: InputDecoration(
                      //       hintText: "Email", border: OutlineInputBorder()),
                      // ),
                    ),
                    const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "<   Back",
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(90, 50),
                          primary: AppColors.new_color,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)))),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          var forgotEmail = passwordController.text.trim();
                          try {
                            FirebaseAuth.instance
                                .sendPasswordResetEmail(email: forgotEmail)
                                .then((value) => {
                                      print("Email sent"),
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => LoginPage(
                                                  // userModel: widget.userModel, firebaseUser: widget.firebaseUser,
                                                  ))),
                                    });
                          } on FirebaseAuthException catch (e) {
                            print("Error $e");
                          }
                          ;
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(180, 50),
                            primary: AppColors.new_color,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        child: Text("Forgot Password",style: TextStyle(fontSize: 13),)),
  ]),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
