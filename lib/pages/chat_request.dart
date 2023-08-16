import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_project1/lib3/const/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/ChatRoomModel.dart';
import '../models/FirebaseHelper.dart';
import '../models/UserModel.dart';
import 'ChatRoomPage.dart';
import 'LoginPage.dart';


class ChatRequest extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  var _student1;
  ChatRequest({required this.userModel, required this.firebaseUser});

  @override
  State<ChatRequest> createState() => _ChatRequestState();
}

class _ChatRequestState extends State<ChatRequest> {

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
        title: Text("Chat Request",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
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
      body: SafeArea(
        child: Container(
          color: Colors.blue[50],
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("chatrooms")
                .where("participants.${widget.userModel.uid}", isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot chatRoomSnapshot =
                      snapshot.data as QuerySnapshot;

                  return ListView.builder(
                    itemCount: chatRoomSnapshot.docs.length,
                    itemBuilder: (context, index) {
                      ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                          chatRoomSnapshot.docs[index].data()
                              as Map<String, dynamic>);

                      Map<String, dynamic> participants =
                          chatRoomModel.participants!;

                      List<String> participantKeys = participants.keys.toList();
                      participantKeys.remove(widget.userModel.uid);

                      return FutureBuilder(
                        future:
                            FirebaseHelper.getUserModelById(participantKeys[0]),
                        builder: (context, userData) {
                          if (userData.connectionState ==
                              ConnectionState.done) {
                            if (userData.data != null) {
                              UserModel targetUser = userData.data as UserModel;

                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0,left: 10,right: 10),
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                                  elevation: 10,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return ChatRoomPage(
                                            chatroom: chatRoomModel,
                                            firebaseUser: widget.firebaseUser,
                                            userModel: widget.userModel,
                                            targetUser: targetUser,
                                          );
                                        }),
                                      );
                                    },
                                    leading: CircleAvatar(
                                      backgroundColor: AppColors.new_color,
                                      backgroundImage: NetworkImage(
                                          targetUser.profilepic.toString()),
                                    ),
                                    trailing: Icon(Icons.arrow_forward,color: AppColors.new_color,),
                                    title: Text(targetUser.fullname.toString(),style: TextStyle(color: AppColors.new_color),),
                                    subtitle: (chatRoomModel.lastMessage
                                                .toString() !=
                                            "")
                                        ? Text(chatRoomModel.lastMessage.toString(),style: TextStyle(fontWeight: FontWeight.w500))
                                        : Text(
                                            "Say hi to your new friend!",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          } else {
                            return Container();
                          }
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Center(
                    child: Text("No Chats"),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.new_color,
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
      //       return SearchPage(
      //           widget._student1['email'],
      //           userModel: widget.userModel, firebaseUser: widget.firebaseUser);
      //     }));
      //   },
      //   child: Icon(Icons.search),
      // ),
    );
  }
}
