import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../models/UserModel.dart';
import '../../pages/LoginPage.dart';
import '../const/app_color.dart';
import '../custom_wigets/main_drawer.dart';
import 'create_note.dart';
import 'edit_note.dart';

class NotePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  NotePage({required this.userModel, required this.firebaseUser});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  User? userId = FirebaseAuth.instance.currentUser;
  List _teacher = [];
  fetchTeacher() async {
    var fireStoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await fireStoreInstance.collection("notes").where("userId", isEqualTo: userId?.uid).get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _teacher.add({
          "note": qn.docs[i]["note"],
        });
      }
    });
  }

  @override
  void initState() {
    fetchTeacher();
    super.initState();
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
          "Notes",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
        ),
        //backgroundColor: Colors.transparent,
        elevation: 0,
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
      //     //color: Colors.red,
      //     child:
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
            child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("notes")
                    .where("userId", isEqualTo: userId?.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something is wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No data Found"));
                  }
                  if (snapshot != null && snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var note = snapshot.data!.docs[index]["note"];
                        var title = snapshot.data!.docs[index]["title"];
                        var noteId = snapshot.data!.docs[index]["userId"];
                        var docId = snapshot.data!.docs[index].id;
                        Timestamp date = snapshot.data!.docs[index]['createdAt'];
                        var finalDate = DateTime.parse(date.toDate().toString());

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 20,
                            color: Color(0xff73c5e0),
                            child:
                            // ListView.builder(
                            //   //physics: BouncingScrollPhysics(),
                            //   //scrollDirection: Axis.vertical,
                            //     itemCount: _teacher.length,
                            //     itemBuilder: (_, index) {
                            //       return ListTile(
                            //         title: Text(_teacher[index]["note"]),
                            //         subtitle: Text(GetTimeAgo.parse(finalDate)),
                            //         trailing: Row(
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: [
                            //             GestureDetector(
                            //                 onTap: () {
                            //                   Navigator.push(
                            //                       context,
                            //                       MaterialPageRoute(
                            //                         builder: (_) => EditNote(
                            //                             userModel: widget.userModel,
                            //                             firebaseUser:
                            //                             widget.firebaseUser),
                            //                       ));
                            //                   // Get.to(
                            //                   //   () => EditNote(),
                            //                   //   arguments: {
                            //                   //     'note': note,
                            //                   //     'docId': docId,
                            //                   //   },
                            //                   // );
                            //                   // Get.to(() => EditNote());
                            //                 },
                            //                 child: Icon(Icons.edit)),
                            //             GestureDetector(
                            //                 onTap: () async {
                            //                   await FirebaseFirestore.instance
                            //                       .collection("notes")
                            //                       .doc(docId)
                            //                       .delete();
                            //                 },
                            //                 child: Icon(Icons.delete)),
                            //           ],
                            //         ),
                            //       );
                            //     }),
                            Column(
                              children: [
                                ListTile(
                                  title: Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  subtitle: Text(note),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              () => EditNote(),
                                              arguments: {
                                                'note': note,
                                                'title': title,
                                                'docId': docId,
                                              },
                                            );
                                            // Get.to(() => EditNote());
                                          },
                                          child: Icon(Icons.edit)),
                                      GestureDetector(
                                          onTap: () async {
                                           await AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.WARNING,
                                              animType: AnimType.TOPSLIDE,
                                              showCloseIcon: true,
                                              title: "Warning",
                                              desc: "Sure, You want to delete!",
                                              btnOkText: "delete",
                                              btnCancelOnPress: () {
                                                //Navigator.pop(context);
                                              },
                                              btnOkOnPress: () async {
                                                //Navigator.pop(context);
                                                await FirebaseFirestore.instance
                                                    .collection("notes")
                                                    .doc(docId)
                                                    .delete();
                                              },
                                            ).show();

                                          },
                                          child: Icon(Icons.delete)),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 188.0),
                                    child: Text(GetTimeAgo.parse(finalDate),textAlign: TextAlign.end,),
                                  ),
                                ),
                              ],
                            ),

                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => CreateNotes(
                      userModel: widget.userModel,
                      firebaseUser: widget.firebaseUser)));
        },
        backgroundColor: AppColors.new_color,
        child: Icon(Icons.add),
      )
    );
  }
}
