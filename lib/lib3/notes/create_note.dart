import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_project1/lib3/const/app_color.dart';
import 'package:diu_project1/lib3/notes/note_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/UserModel.dart';

class CreateNotes extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  CreateNotes({required this.userModel, required this.firebaseUser});

  @override
  State<CreateNotes> createState() => _CreateNotesState();
}

class _CreateNotesState extends State<CreateNotes> {
  TextEditingController noteController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.new_color,
        title: Text("Create Notes",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
      ),
      body: Container(
        color: Colors.blue[50],
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    maxLines: 5,
                    minLines: 1,
                    enabled: true,
                    controller: titleController,
                    //obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIconColor: AppColors.new_color,
                      prefixIcon: Icon(Icons.edit),
                      label: Text("Add Title"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.new_color,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        borderSide: BorderSide(color: AppColors.new_color),
                      ),
                    ),
                  ),
                  TextFormField(
                    maxLines: 20,
                    minLines: 2,
                    enabled: true,
                    controller: noteController,
                    //obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "Add Note",
                      fillColor: Colors.white,
                      prefixIconColor: AppColors.new_color,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.new_color,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        borderSide: BorderSide(color: AppColors.new_color),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 5, right: 20),
              child: ElevatedButton(
                onPressed: () async {
                  var note = noteController.text.trim();
                  var title = titleController.text.trim();
                  if (note != "") {
                    try {
                      await FirebaseFirestore.instance
                          .collection("notes")
                          .doc()
                          .set({
                        "createdAt": DateTime.now(),
                        "note": note,
                        "title": title,
                        "userId": userId?.uid,
                      });
                    } catch (e) {
                      Fluttertoast.showToast(msg: '"Error $e"');
                    }
                  }
                  ;
                  Navigator.pop(context);
                  // await  Navigator.pushReplacement(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (_) => NotePage(
                  //                 userModel: widget.userModel,
                  //                 firebaseUser: widget.firebaseUser),
                  //           ));
                },
                child: Text("Add Note"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.new_color,
                    minimumSize: Size(320, 50),
                    //primary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
