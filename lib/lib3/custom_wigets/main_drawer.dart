import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_project1/lib3/profile/profile.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/UserModel.dart';
import '../../pages/HomePage.dart';
import '../../pages/LoginPage.dart';
import '../const/app_color.dart';
import '../notes/note_page.dart';
import '../pages/about.dart';
import '../pages/help_page.dart';
import '../pages/log_in.dart';

class MainDrawer extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  MainDrawer({required this.userModel, required this.firebaseUser});

  List _profile = [];

  var fireStoreInstance = FirebaseFirestore.instance;
  fetchImage() async {
    QuerySnapshot qn = await fireStoreInstance.collection("users").get();
    for (int i = 0; i < qn.docs.length; i++) {
      _profile.add({
        "proimg": qn.docs[i]['profilepic'],
        "fullname": qn.docs[i]['fullname'],
        "email": qn.docs[i]['email'],
      });
    }
    return qn.docs;
  }

  setData(data) {
    return UserAccountsDrawerHeader(
     // margin: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(

        color: AppColors.new_color
      ),
        currentAccountPicture: CircleAvatar(
          //backgroundColor: AppColors.new_color,
            radius: 75,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: Image.network(
                  data['profilepic'],
                ))),
        accountName: Text(
          data['fullname'],
        ),
        accountEmail: Text(
          data['email'],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 265,
      child: Drawer(
        child: Material(
          // color: Colors.blue[50],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    var data = snapshot.data;

                    if (data == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return setData(data);
                  }),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 8),
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      leading: Icon(
                        Icons.home,
                        color: AppColors.new_color,
                      ),
                      title: Text(
                        "Home",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: AppColors.new_color),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 8),
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        size: 25,
                        color: AppColors.new_color,
                      ),
                      title: Text(
                        "Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: AppColors.new_color),
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Profile(
                                  userModel: userModel,
                                  firebaseUser: firebaseUser,
                                )));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 8),
                    child: ListTile(
                      leading: Icon(
                        Icons.note,
                        size: 25,
                        color: AppColors.new_color,
                      ),
                      title: Text(
                        "Note",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: AppColors.new_color),
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => NotePage(
                                  userModel: userModel,
                                  firebaseUser: firebaseUser,
                                )));
                      },
                    ),
                  ),
                  // ListTile(
                  //   leading: Icon(Icons.note),
                  //   title: Text("Note"),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (_) => NotePage(
                  //                   userModel: userModel,
                  //                   firebaseUser: firebaseUser,
                  //                 )));
                  //   },
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 8),
                    child: ListTile(
                      onTap: () async {
                        Navigator.pop(context);
                        await LaunchApp.openApp(
                            androidPackageName: 'com.example.tuition_admin_app',
                            openStore: true);
                        // await LaunchApp.openApp(
                        //    //androidPackageName: 'com.example.tuition_admin_app',
                        //    androidPackageName: 'org.whiteglow.quickeycalculator',
                        //    //androidPackageName: 'com.adobe.reader',
                        //   iosUrlScheme: 'whiteglow://',
                        //  // openStore: true
                        //  );
                      },
                      leading: Icon(
                        Icons.apps,
                        color: AppColors.new_color,
                      ),
                      title: Text(
                        "Teacher App",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: AppColors.new_color),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 8),
                    child: ListTile(
                      onTap: () async {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => About()));
                      },
                      leading: Icon(Icons.info,color: AppColors.new_color,),
                      title: Text("About",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: AppColors.new_color),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0,right: 8),
                    child: ListTile(
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.WARNING,
                          animType: AnimType.TOPSLIDE,
                          showCloseIcon: true,
                          btnOkText: 'Yes',
                          btnCancelText: 'No',
                          title: "Warning",
                          desc: "Do You want to LogOut?",
                          btnCancelOnPress: () {
                            Navigator.pop(context);
                          },
                          btnOkOnPress: () {
                            //Navigator.pop(context);
                            FirebaseAuth.instance.signOut();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginPage(
                                      // userModel: userModel, firebaseUser: firebaseUser,
                                    )));
                          },
                        ).show();
                      },
                      leading: Icon(Icons.logout,color: AppColors.new_color,),
                      title: Text("Logout",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: AppColors.new_color),),
                    ),
                  ),
                  Divider(
                    height: 30,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0,right: 8),
                    child: ListTile(
                      onTap: () async {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => HelpPage()));
                      },
                      leading: Icon(Icons.help,color: AppColors.new_color,),
                      title: Text("Help",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: AppColors.new_color),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0,right: 8,top: 110),
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.search,color: AppColors.new_color,),
                          Text("Tuition Finder",style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 20,
                              color: AppColors.new_color),),
                          Icon(Icons.search,color: AppColors.new_color,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    //   Drawer(
    //   child: Column(
    //     children: [
    //       StreamBuilder(
    //           stream: FirebaseFirestore.instance
    //               .collection("users")
    //               .doc(FirebaseAuth.instance.currentUser!.uid)
    //               .snapshots(),
    //           builder: (BuildContext context, AsyncSnapshot snapshot) {
    //             var data = snapshot.data;
    //
    //             if (data == null) {
    //               return Center(
    //                 child: CircularProgressIndicator(),
    //               );
    //             }
    //             return setData(data);
    //           }),
    //       Column(
    //         children: [
    //           ListTile(
    //             onTap: () {
    //               Navigator.pop(context);
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (_) => HomePage(
    //                             userModel: userModel,
    //                             firebaseUser: firebaseUser,
    //                           )));
    //             },
    //             leading: Icon(Icons.home),
    //             title: Text("Home"),
    //           ),
    //           ListTile(
    //             leading: Icon(Icons.person),
    //             title: Text("Profile"),
    //             onTap: () {
    //               Navigator.pop(context);
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (_) => Profile(
    //                             userModel: userModel,
    //                             firebaseUser: firebaseUser,
    //                           )));
    //             },
    //           ),
    //           ListTile(
    //             leading: Icon(Icons.note),
    //             title: Text("Note"),
    //             onTap: () {
    //               Navigator.pop(context);
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (_) => NotePage(
    //                             userModel: userModel,
    //                             firebaseUser: firebaseUser,
    //                           )));
    //             },
    //           ),
    //           ListTile(
    //             onTap: ()async{
    //              await LaunchApp.openApp(
    //                 androidPackageName: 'com.example.tuition_admin_app',
    //
    //                openStore: true
    //               );
    //
    //             },
    //             leading: Icon(Icons.info),
    //             title: Text("Teacher App"),
    //           ),
    //           ListTile(
    //             onTap: ()async{
    //             // await LaunchApp.openApp(
    //               //   //androidPackageName: 'com.example.tuition_admin_app',
    //               //   androidPackageName: 'org.whiteglow.quickeycalculator',
    //               //   //androidPackageName: 'com.adobe.reader',
    //               //  iosUrlScheme: 'whiteglow://',
    //               // // openStore: true
    //               // );
    //
    //             },
    //             leading: Icon(Icons.info),
    //             title: Text("About"),
    //           ),
    //           ListTile(
    //             onTap: () {
    //               AwesomeDialog(
    //                 context: context,
    //                 dialogType: DialogType.WARNING,
    //                 animType: AnimType.TOPSLIDE,
    //                 showCloseIcon: true,
    //                 btnOkText: 'Yes',
    //                 btnCancelText: 'No',
    //                 title: "Warning",
    //                 desc: "Do You want to LogOut?",
    //                 btnCancelOnPress: () {
    //                   //Navigator.pop(context);
    //                 },
    //                 btnOkOnPress: () {
    //                   //Navigator.pop(context);
    //                   FirebaseAuth.instance.signOut();
    //                   Navigator.push(
    //                       context, MaterialPageRoute(builder: (_) =>
    //                       LoginPage(
    //                         // userModel: userModel, firebaseUser: firebaseUser,
    //                       )));
    //                 },
    //               ).show();
    //
    //             },
    //             leading: Icon(Icons.logout),
    //             title: Text("Logout"),
    //           ),
    //
    //           Divider(
    //             height: 30,
    //             color: Colors.grey,
    //           ),
    //           ListTile(
    //             leading: Icon(Icons.help),
    //             title: Text("Help"),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
