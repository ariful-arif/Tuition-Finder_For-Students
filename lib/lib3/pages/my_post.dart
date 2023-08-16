import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../pages/LoginPage.dart';
import '../const/app_color.dart';

class MyPost extends StatefulWidget {


  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {

  setData(data) {
    DateTime dateTime = (data["date"] as Timestamp).toDate();
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding:
        const EdgeInsets.only(top: 15.0, bottom: 40, left: 5, right: 5),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 20,
              child: Container(
                //height: 200,
                //width: 375,
                decoration: const BoxDecoration(
                    color: Color(0xff73c5e0),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      //color: Colors.white,
                      decoration: const BoxDecoration(
                          color: Color(0xff73c5e0),
                          borderRadius:
                          BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        data["title"],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45),
                      ),
                    ),
                    Text(data['name'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                    Text(data['email']),
                    Row(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 3.0, top: 0),
                          child: CircleAvatar(
                            radius: 12,
                            child: Icon(Icons.school,size: 15,color: AppColors.new_color,),
                            // backgroundImage: AssetImage("images/class.png"),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Class",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              Container(
                                width: 90,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    data['class'],
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 0,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 3.0, top: 0),
                          child: CircleAvatar(
                            radius: 12,
                            child: Icon(Icons.location_on_outlined,size: 18,color: AppColors.new_color,),
                            // backgroundImage: AssetImage("images/class.png"),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Location",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              Container(
                                width: 170,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    data["address"],
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 3.0, top: 0),
                          child: CircleAvatar(
                            radius: 12,
                            child: Icon(Icons.calendar_month_sharp,size: 12,color: AppColors.new_color,),
                            // backgroundImage: AssetImage("images/class.png"),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Days",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              Container(
                                width: 90,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    data["days"],
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding:
                          const EdgeInsets.only(left: 3.0, top: 0),
                          child: CircleAvatar(
                            radius: 12,
                            child: Icon(Icons.menu_book_sharp,size: 12,color: AppColors.new_color,),
                            // backgroundImage: AssetImage("images/class.png"),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Subject",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              Container(
                                width: 180,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    data["subject"],
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 3.0, top: 0),
                          child: CircleAvatar(
                            radius: 12,
                            child: Icon(Icons.money,size: 12,color: AppColors.new_color,),
                            // backgroundImage: AssetImage("images/class.png"),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Salary",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              Container(
                                width: 90,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    data["salary"],
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding:
                          const EdgeInsets.only(left: 3.0, top: 0),
                          child: CircleAvatar(
                            radius: 12,
                            child: Icon(Icons.language,size: 12,color: AppColors.new_color,),
                            // backgroundImage: AssetImage("images/class.png"),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Curriculum",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              Container(
                                width: 180,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                   data["curriculum"],
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
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
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.man, size: 20,
                              color: AppColors.new_color,
                              //color: Colors.grey,
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
                            //fontWeight: FontWeight.bold,
                            //color: Colors.black54
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
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: FaIcon(
                              FontAwesomeIcons.calendarCheck,
                              color: AppColors.new_color,
                              size: 15,
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
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.phone,
                              size: 15,
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
                              color: Colors.black54),
                        ),
                        Text(
                          data['phone'],
                          style: TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.bold,
                            // color: Colors.black54
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.money,
                              size: 15,
                              color: AppColors.new_color,
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Salary : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        Container(
                          width: 215,
                          child: Text(
                            data['salary'],
                            style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              // color: Colors.black54
                            ),
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
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.menu_book,
                              size: 15,
                              color: AppColors.new_color,
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Subject : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        Container(
                          width: 215,
                          child: Text(
                            data['subject'],
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                              // color: Colors.black54
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 188.0,bottom: 10,right: 5),
                        child: Text(
                          "Posted In: ${_formatDateTime(dateTime)}",
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    // TextField(
                    //   controller: text =
                    //       TextEditingController(text: _teacher[index]['teacher-subject']),
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  String _formatDateTime(DateTime dateTime) {
    // Define the desired date format
    final DateFormat formatter = DateFormat("h:mm a  d MMMM, y ");
    return formatter.format(dateTime);
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

        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: AppColors.new_color,
          centerTitle: true,
          title: Text(
            "My Request",
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
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("students")
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    var data = snapshot.data;

                    if (data == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return setData(data);
                  })),
        )

    );
  }
}
