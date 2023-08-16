import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_project1/lib3/const/app_color.dart';
import 'package:diu_project1/lib3/profile/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/UserModel.dart';
import '../../pages/LoginPage.dart';

class Profile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  Profile({required this.userModel, required this.firebaseUser});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  setData(data) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15.0, bottom: 40, left: 15, right: 15),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: AppColors.new_color),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)

                  )),
              //margin: EdgeInsets.all(15),
              alignment: Alignment.center,
              //height: 200,
              //color: Colors.black12,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: AppColors.new_color,
                      child: CircleAvatar(
                        radius: 60,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(data['profilepic'],))
                      ),
                    ),
                  ),
                  Text(
                    data['fullname'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    data['email'],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      //mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                                backgroundColor: Colors.black12,
                                child: Icon(
                                  Icons.man,size: 20,
                                  color: AppColors.new_color,
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Gender : ",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(
                              data['gender'],
                              style: TextStyle(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.bold,
                                  // color: Colors.black54
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                                backgroundColor: Colors.black12,
                                child: Icon(
                                  Icons.date_range_sharp,size: 15,
                                  color: AppColors.new_color,
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Age : ",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),
                            ),
                            Text(
                              data['age'],
                              style: TextStyle(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.bold,
                                  // color: Colors.black54
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                                backgroundColor: Colors.black12,
                                child: Icon(
                                  Icons.date_range,size:15,
                                  color: AppColors.new_color,
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Date of birth : ",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(
                              data['dob'],
                              style: TextStyle(
                                fontSize: 14,
                                // fontWeight: FontWeight.bold,
                                // color: Colors.black54
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                                backgroundColor: Colors.black12,
                                child: Icon(
                                  Icons.phone,size: 15,
                                  color: AppColors.new_color,
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Phone : ",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),
                            ),
                            Text(
                              data['phone'],
                              style: TextStyle(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.bold,
                                  // color: Colors.black54
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EditProfile(
                                          userModel: widget.userModel,
                                          firebaseUser: widget.firebaseUser,
                                        )));
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(300, 60),
                             // primary: Colors.white,
                              backgroundColor: AppColors.new_color,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                          child: Text("Edit Profile"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSelected(BuildContext context, item) {
    switch (item) {
      case 1:
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
            //Navigator.pop(context);
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
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MainDrawer(
      //   userModel: widget.userModel,
      //   firebaseUser: widget.firebaseUser,
      // ),
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.new_color,
        centerTitle: true,
        title: Text(
          "My Profile",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
        ),
        actions: [
          PopupMenuButton<int>(
            // color: Colors.black,
              onSelected: (item) => onSelected(context, item),
              color: Colors.black,
              itemBuilder: (context) =>
              [
                // PopupMenuItem(value: 0,
                //   child: Text("Search",)),
                PopupMenuItem(value: 1,
                    child: Text("Log Out",style: TextStyle(color: Colors.white),)),

              ]),

        ],
        //backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:
      // Container(
      //     padding: EdgeInsets.only(top: 90),
      //     decoration: BoxDecoration(color: Colors.lightBlue
      //       // gradient: LinearGradient(colors: [
      //       //   Colors.deepPurple,
      //       //   Colors.deepOrange
      //       // ])
      //     ),
          //color: Colors.red,
          // child:
        Container(
            decoration: BoxDecoration(
                color: Colors.blue[50],
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(50),
                //   topRight: Radius.circular(50),
                // )
    ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
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
                )),
          )

    );
  }
}
