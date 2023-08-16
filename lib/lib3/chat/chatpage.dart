import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/UserModel.dart';
import '../../pages/LoginPage.dart';
import '../const/app_color.dart';
import 'message.dart';

class chatpage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  chatpage({required this.userModel, required this.firebaseUser});
  @override
  _chatpageState createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  //String email;
  _chatpageState();

  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController message = new TextEditingController();

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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.new_color,
        title: Text(
          'Group Chat',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)
        ),
        actions: [
          PopupMenuButton<int>(
            // color: Colors.black,
              onSelected: (item) => onSelected(context, item),
              //color: Colors.black,
              itemBuilder: (context) =>
              [
                // PopupMenuItem(value: 0,
                //   child: Text("Search",)),
                PopupMenuItem(value: 1,
                    child: Text("Log Out",)),

              ]),

        ],
        // actions: [
        //   MaterialButton(
        //     onPressed: () {
        //       _auth.signOut().whenComplete(() {
        //         Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => Home(),
        //           ),
        //         );
        //       });
        //     },
        //     child: Text(
        //       "signOut",
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.blue[50],
              height: MediaQuery.of(context).size.height * 0.79,
              child: messages(
                 userModel:widget.userModel, firebaseUser: widget.firebaseUser,
              ),
            ),
            Container(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0,bottom: 8,right: 8,top: 8),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:Border.all(width: 1,color: AppColors.new_color) ,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  //color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: message,
                          maxLines: null,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter message"),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (message.text.isNotEmpty) {
                            fs.collection('Messages').doc().set({
                              'message': message.text.trim(),
                              'time': DateTime.now(),
                              'email': widget.userModel.email,
                            });

                            message.clear();
                          }
                        },
                        icon: Icon(Icons.send_sharp,color: AppColors.new_color,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //   color: Colors.blue[50],
            //   // height: MediaQuery.of(context).size.height * .08,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: TextFormField(
            //           minLines: 1,
            //           maxLines: null,
            //           controller: message,
            //           decoration: InputDecoration(
            //             filled: true,
            //             fillColor: Colors.white,
            //             hintText: 'Enter message',
            //             enabled: true,
            //             contentPadding: const EdgeInsets.only(
            //                 left: 14.0, bottom: 8.0, top: 8.0),
            //             focusedBorder: OutlineInputBorder(
            //               borderSide: new BorderSide(),
            //               borderRadius: new BorderRadius.circular(10),
            //             ),
            //             enabledBorder: UnderlineInputBorder(
            //               borderSide: new BorderSide(),
            //               borderRadius: new BorderRadius.circular(10),
            //             ),
            //           ),
            //           validator: (value) {},
            //           onSaved: (value) {
            //             message.text = value!;
            //           },
            //         ),
            //       ),
            //       IconButton(
            //         onPressed: () {
            //           if (message.text.isNotEmpty) {
            //             fs.collection('Messages').doc().set({
            //               'message': message.text.trim(),
            //               'time': DateTime.now(),
            //               'email': widget.userModel.email,
            //             });
            //
            //             message.clear();
            //           }
            //         },
            //         icon: Icon(Icons.send_sharp,color: AppColors.new_color,),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}