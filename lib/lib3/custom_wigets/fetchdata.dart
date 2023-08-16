import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_project1/lib3/const/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget fetchData(String collectionName) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: Text("Something is wrong"),
        );
      }

      return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];

            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 20,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(_documentSnapshot['images'])),
                ),
                title: Text(
                  _documentSnapshot['name'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.lightBlue),
                ),
                subtitle: Text(_documentSnapshot['email']),
                trailing: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: AppColors.new_color,
                    child: Icon(Icons.delete_forever,color: Colors.black,),
                  ),
                  onTap: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.WARNING,
                      animType: AnimType.TOPSLIDE,
                      showCloseIcon: true,
                      title: "Warning",
                      desc: "Sure, You want to remove!",
                      btnCancelOnPress: () {
                        //Navigator.pop(context);
                      },
                      btnOkOnPress: () {
                        //Navigator.pop(context);
                        FirebaseFirestore.instance
                            .collection(collectionName)
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection("items")
                            .doc(_documentSnapshot.id)
                            .delete();
                      },
                    ).show();

                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         title: Text("Choose an Option"),
                    //         content: Column(
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [
                    //             ListTile(
                    //               onTap: () {
                    //                 Navigator.pop(context);
                    //                 FirebaseFirestore.instance
                    //                     .collection(collectionName)
                    //                     .doc(FirebaseAuth.instance.currentUser!.email)
                    //                     .collection("items")
                    //                     .doc(_documentSnapshot.id)
                    //                     .delete();
                    //               },
                    //               leading: Icon(Icons.favorite),
                    //               title: Text("Do you want to delete this from favourite list"),
                    //             ),
                    //             ListTile(
                    //               onTap: () {
                    //                 Navigator.pop(context);
                    //
                    //               },
                    //               leading: Icon(Icons.watch_later),
                    //               title: Text("Later"),
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     });
                  },
                ),
              ),
            );
          });
    },
  );
}



