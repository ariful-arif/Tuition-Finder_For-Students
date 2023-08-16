// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ChatRoom extends StatelessWidget {
//    final Map<String, dynamic> userMap;
//    final String chatRoomId;
//
//   ChatRoom({ required this.chatRoomId,  required this.userMap});
//
//   final TextEditingController _message = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth =  FirebaseAuth.instance;
//
//   void sendMessage() async {
//     if(_message.text.isNotEmpty){
//       Map<String, dynamic> messages = {
//         "sendby": _auth.currentUser?.displayName,
//         "message": _message.text,
//         "type": "text",
//         "time": FieldValue.serverTimestamp(),
//       };
//
//       _message.clear();
//       await _firestore
//           .collection('chatroom')
//           .doc(chatRoomId)
//           .collection('chats')
//           .add(messages);
//     }else{
//       print("Enter some Text");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Name"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: size.height / 1.25,
//               width: size.width,
//               child: StreamBuilder<QuerySnapshot>(
//                   stream: _firestore
//                       .collection('chatroom')
//                       .doc(chatRoomId)
//                       .collection('chats')
//                       .orderBy("time", descending: false)
//                       .snapshots(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (snapshot.data != null) {
//                       return ListView.builder(
//                           itemCount: snapshot.data!.docs.length,
//                           itemBuilder: (context, index) {
//                              // Map<String,dynamic> map = snapshot.data!.docs[index]
//                              //    .data() as Map<String,dynamic>;
//                              // return messages (size,map,dynamic);
//                               return Text(snapshot.data!.docs[index]['message']);
//                           });
//                     } else {
//                       return Container();
//                     }
//                   }),
//             ),
//             Container(
//               height: size.height / 10,
//               width: size.width,
//               alignment: Alignment.center,
//               child: Container(
//                 height: size.height / 12,
//                 width: size.width / 1.1,
//                 child: Row(
//                   children: [
//                     Container(
//                       height: size.height / 12,
//                       width: size.width / 1.5,
//                       child: TextField(
//                         controller: _message,
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8))),
//                       ),
//                     ),
//                     IconButton(onPressed: () {
//                       sendMessage;
//                     }, icon: Icon(Icons.send))
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
