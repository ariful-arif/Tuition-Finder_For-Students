import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../lib3/const/app_color.dart';
import 'LoginPage.dart';

class SearchSubjectPage extends StatefulWidget {
  // final UserModel userModel;
  // final User firebaseUser;
  // var student;
  // SearchSubjectPage(this.student,{required this.userModel, required this.firebaseUser});

  @override
  State<SearchSubjectPage> createState() => _SearchSubjectPageState();
}

class _SearchSubjectPageState extends State<SearchSubjectPage> {
  TextEditingController seachtf = TextEditingController();

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
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('teachers')
        .where(
          'subject',
          isLessThanOrEqualTo: seachtf.text,
        )
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.new_color,
        title: Text("Search Teacher"),
        centerTitle: true,
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
      body: Container(
        color: Colors.blue[50],
        padding: EdgeInsets.all(10
            // left: 0,
            // right: 0,
            ),
        child: Column(
          children: [
            Text(
              "Search by Subject",
              style: TextStyle(
                  fontSize: 15,
                  color: AppColors.new_color,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: TextField(
                onChanged: (value) {
                  setState(() {});
                },
                enabled: true,
                controller: seachtf,
                //obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIconColor: AppColors.new_color,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Bangla,Math,English...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: AppColors.new_color,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppColors.new_color),
                  ),
                ),
              ),
            ),
            // StreamBuilder(
            //     stream: _usersStream,
            //     builder: (BuildContext context,
            //         AsyncSnapshot<QuerySnapshot> snapshot) {
            //       if (snapshot.hasError) {
            //         return Text("something is wrong");
            //       }
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       }
            //       return Container(
            //         //color:  Color(0xff73c5e0),
            //         //width: 300,
            //         width: MediaQuery.of(context).size.width,
            //         //height: 300,
            //         height: MediaQuery.of(context).size.height / 1.24,
            //         decoration: BoxDecoration(
            //             color: Colors.blue[50],
            //             borderRadius: BorderRadius.only(
            //               topLeft: Radius.circular(20),
            //               topRight: Radius.circular(20),
            //             )),
            //         child: ListView.builder(
            //             itemCount: snapshot.data!.docs.length,
            //             itemBuilder: (_, index) {
            //               return StudentScrolling(
            //                 userModel: widget.userModel,
            //                 firebaseUser: widget.firebaseUser,
            //               );
            //             }),
            //       );
            //     })

            Expanded(
              child: Container(
                child: StreamBuilder(
                  stream: _usersStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      itemBuilder: (_, index) {
                        final DocumentSnapshot docSnap =
                            snapshot.data!.docs[index];
                        return Card(
                          elevation: 10,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ListTile(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => SearchPage(
                                  //           documentSnapshot: documentSnapshot,
                                  //               userModel: widget.userModel,
                                  //               firebaseUser: widget.firebaseUser,
                                  //             )));
                                },
                                leading: CircleAvatar(
                                  radius: 25,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(
                                        docSnap['profileTea'],
                                      )),
                                ),
                                title: Text(
                                  snapshot.data!.docChanges[index].doc['name'],
                                  style: TextStyle(color: AppColors.new_color),
                                ),
                                subtitle: Text(
                                  docSnap['email'],
                                  // "Subject : ${snapshot.data!.docChanges[index].doc['subject']}"
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Class: ",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.new_color),
                                    ),
                                    Container(
                                      width: 93,
                                      child: Text(
                                        docSnap['class'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Text(
                                      "Subject: ",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.new_color),
                                    ),
                                    Container(
                                      width: 110,
                                      child: Text(
                                        docSnap['subject'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      "Age: ",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.new_color),
                                    ),
                                    Container(
                                      width: 97,
                                      child: Text(
                                        docSnap['age'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Text(
                                      "Location: ",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.new_color),
                                    ),
                                    Container(
                                      width: 110,
                                      child: Text(
                                        docSnap['address'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      "Gender: ",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.new_color),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text(
                                        docSnap['gender'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Text(
                                      "Institute: ",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.new_color),
                                    ),
                                    Container(
                                      width: 110,
                                      child: Text(
                                        docSnap['institute'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      "Phone: ",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.new_color),
                                    ),
                                    Container(
                                      width: 87,
                                      child: Text(
                                        docSnap['phone'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Text(
                                      "Department: ",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.new_color),
                                    ),
                                    Container(
                                      width: 105,
                                      child: Text(
                                        docSnap['department'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                            onTap: () async {
                                              String? encodeQueryParameters(
                                                  Map<String, String> params) {
                                                return params.entries
                                                    .map((MapEntry<String, String> e) =>
                                                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                                    .join('&');
                                              }
                                              final Uri emailLaunchUri = Uri(
                                                scheme: 'mailto',
                                                path: docSnap['email'],
                                                query:
                                                encodeQueryParameters(<String, String>{
                                                  'subject':
                                                  'Example Subject & Symbols are allowed!',
                                                }),
                                              );
                                              if (await canLaunchUrl(emailLaunchUri)) {
                                                launchUrl(emailLaunchUri);
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.email,
                                                  color: AppColors.new_color,
                                                ),
                                                Text("Email",style: TextStyle(fontSize: 10),)
                                              ],
                                            ),
                                        ),

                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () async {
                                          final Uri call = Uri(
                                              scheme: 'tel',
                                              path: docSnap['phone'],);
                                          if (await canLaunchUrl(call)) {
                                            await launchUrl(call);
                                          } else {
                                            print("cant launch url");
                                          }
                                          ;
                                        },
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.call,
                                              color: Colors.green,
                                            ),
                                            Text("call",style: TextStyle(fontSize: 10),)
                                          ],
                                        ),

                                   ),
                                    GestureDetector(
                                        onTap: () async {
                                          final Uri call = Uri(
                                              scheme:'sms',
                                              path: docSnap['phone'],);
                                          if(await canLaunchUrl(call)){
                                            await launchUrl(call);
                                          }else{
                                            print("cant launch url");
                                          };

                                        },
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.sms,
                                              color: AppColors.new_color,
                                            ),
                                            Text("SMS",style: TextStyle(fontSize: 10),)
                                          ],
                                        )),
                                    GestureDetector(
                                        onTap: () async {
                                          final Uri call = Uri(
                                            scheme:'sms',
                                            path: docSnap['phone'],);
                                          if(await canLaunchUrl(call)){
                                            await launchUrl(call);
                                          }else{
                                            print("cant launch url");
                                          };

                                        },
                                        child: Column(
                                          children: [
                                            FaIcon(FontAwesomeIcons.squareWhatsapp,color: Colors.green,),
                                            Text("WhatsApp",style: TextStyle(fontSize: 10),)
                                          ],
                                        )

                        ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
