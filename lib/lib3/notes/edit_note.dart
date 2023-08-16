import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/UserModel.dart';
import '../const/app_color.dart';

class EditNote extends StatefulWidget {
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController noteController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.new_color,
        title: Text("Edit Note",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
      ),
      body: Container(
        color: Colors.blue[50],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              TextFormField(
                maxLines: 5,
                minLines: 1,
                enabled: true,
                controller: titleController
                  ..text = "${Get.arguments['title'].toString()}",
                //obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIconColor: AppColors.new_color,
                  prefixIcon: Icon(Icons.edit),
                  label: Text("Edit Title"),
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
                controller: noteController
                  ..text = "${Get.arguments['note'].toString()}",
                //obscureText: true,
                decoration: InputDecoration(
                  filled: true,
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
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("notes")
                      .doc(Get.arguments['docId'].toString())
                      .update({
                    'title': titleController.text.trim(),
                    'note': noteController.text.trim(),
                  }).then((value) => Navigator.pop(context));
                },
                child: Text("Update"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.new_color,
                    minimumSize: Size(320, 50),
                    //primary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
