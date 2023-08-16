import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/UserModel.dart';
import '../const/app_color.dart';

class messages extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  messages({required this.userModel, required this.firebaseUser});
  @override
  _messagesState createState() => _messagesState();
}

class _messagesState extends State<messages> {
  _messagesState();

  Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection('Messages')
      .orderBy('time')
      .snapshots();
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(

      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("something is wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          physics: ClampingScrollPhysics(),
          //physics: ScrollPhysics(),
          //shrinkWrap: true,
          //reverse: true,
          //primary: true,
          itemBuilder: (_, index) {
            QueryDocumentSnapshot qs = snapshot.data!.docs[index];
            Timestamp t = qs['time'];
            DateTime d = t.toDate();
            print(d.toString());
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(

                crossAxisAlignment: widget.userModel.email == qs['email']
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    child: Card(
                      elevation: 10,
                      color: AppColors.new_color,
                      shape: RoundedRectangleBorder(
                        // side: BorderSide(
                        //   color: Colors.purple,
                        // ),

                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          // side: BorderSide(
                          //   color: Colors.purple,
                          // ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(
                          qs['email'],
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,
                            color: Colors.black45
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              //color: Colors.blue[200],
                              width: 216,
                              child: Text(
                                qs['message'],
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black
                                ),
                              ),
                            ),
                            Text(
                              d.hour.toString() + ":" + d.minute.toString(),style: TextStyle(
                                // fontSize: 15,
                                color: Colors.black45
                            ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}