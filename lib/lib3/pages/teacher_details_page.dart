import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/UserModel.dart';
import '../const/app_color.dart';

class TeacherDetailsPage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  var _teacher1;
  TeacherDetailsPage(this._teacher1, {super.key, required this.userModel,required this.firebaseUser,});

  @override
  State<TeacherDetailsPage> createState() => _TeacherDetailsPageState();
}

class _TeacherDetailsPageState extends State<TeacherDetailsPage> {

  Future addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users_favourite");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._teacher1["teacher-name"],
      "email": widget._teacher1["teacher-email"],
      "images": widget._teacher1["proimg"],
    }).then((value) => Fluttertoast.showToast(msg: "Added to favourite"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.new_color,
       centerTitle: true,
        title: const Text(
          "Tutor Details",
         style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
        ),
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(top:15.0,bottom: 40,left: 15,right: 15),
                child: Column(
                  children: [
                    Container(
                      decoration:  BoxDecoration(
                          border: Border.all(color: AppColors.new_color),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(30)
                          )),
                      //margin: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      //height: 200,
                      //color: Colors.black12,
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: CircleAvatar(
                              radius: 50,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(widget._teacher1['proimg'])) ,
                            ),
                          ),
                          Text(
                            widget._teacher1['teacher-name'],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget._teacher1['teacher-email'],
                                // widget._image1['email'],
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    String? encodeQueryParameters(
                                        Map<String, String> params) {
                                      return params.entries
                                          .map((MapEntry<String, String> e) =>
                                      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                          .join('&');
                                    }

                                    final Uri emailLaunchUri = Uri(
                                      scheme: 'mailto',
                                      path: widget._teacher1['teacher-email'],
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
                                  icon: const Icon(
                                    Icons.send_and_archive_outlined,
                                    color: AppColors.new_color,
                                  ))
                            ],
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("users_favourite").doc(FirebaseAuth.instance.currentUser!.email)
                                .collection("items").where("email",isEqualTo: widget._teacher1['teacher-email']).snapshots(),
                            builder: (BuildContext context, AsyncSnapshot snapshot){
                              if(snapshot.data==null){
                                return const Text("");
                              }
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                  backgroundColor: Colors.lightBlue,
                                  child: IconButton(
                                    onPressed: () => snapshot.data.docs.length==0?addToFavourite()
                                        :Fluttertoast.showToast(msg: "Already Added") ,
                                    icon: snapshot.data.docs.length==0? const Icon(
                                      Icons.favorite_outline,
                                      color: Colors.white,
                                    ):const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },

                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        // color: Colors.white,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(

                                color: Colors.white,
                                //shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: AppColors.new_color,
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(widget._teacher1['teacher-details'],
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              //mainAxisAlignment: MainAxisAlignment.end,
                              //mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Department : ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                                Container(
                                  width: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Text(widget._teacher1['teacher-department'],
                                      style: const TextStyle(
                                          fontSize: 13,
                                          // fontWeight: FontWeight.bold,
                                          // color: Colors.black54
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Institute : ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                                Container(
                                  width: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Text(widget._teacher1['teacher-institute'],
                                      style: const TextStyle(
                                          fontSize: 13,
                                          // fontWeight: FontWeight.bold,
                                          // color: Colors.black54
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 15,
                                        backgroundColor: Colors.black12,
                                        child: Icon(
                                          Icons.man,size: 20,
                                          color: AppColors.new_color,
                                        )),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      "Gender : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                    Text(
                                      widget._teacher1['teacher-gender'],
                                      style: const TextStyle(
                                          fontSize: 13,
                                          // fontWeight: FontWeight.bold,
                                          // color: Colors.black54
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Row(
                                //   children: [
                                //     const CircleAvatar(
                                //       radius: 15,
                                //         backgroundColor: Colors.black12,
                                //         child: Icon(
                                //           Icons.date_range_sharp,
                                //           color: Colors.grey,size: 15,
                                //         )),
                                //     const SizedBox(
                                //       width: 8,
                                //     ),
                                //     const Text(
                                //       "Age : ",
                                //       style: TextStyle(
                                //           fontSize: 15,
                                //           fontWeight: FontWeight.bold,
                                //           color: Colors.black54),
                                //     ),
                                //     Text(
                                //       widget._teacher1['teacher-age'],
                                //       style: const TextStyle(
                                //           fontSize: 15,
                                //           // fontWeight: FontWeight.bold,
                                //           // color: Colors.black54
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // const SizedBox(
                                //   height: 15,
                                // ),
                                Row(
                                  children:  [
                                    const CircleAvatar(
                                      radius: 15,
                                        backgroundColor: Colors.black12,
                                        child: Icon(
                                          Icons.date_range,size: 15,
                                          color: AppColors.new_color,
                                        )),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      "Date of birth : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                    Text(
                                      widget._teacher1['teacher-dob'],
                                      style: const TextStyle(
                                        fontSize: 13,
                                        // fontWeight: FontWeight.bold,
                                        // color: Colors.black54
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 15,
                                        backgroundColor: Colors.black12,
                                        child: Icon(
                                          Icons.phone,size: 15,
                                          color: AppColors.new_color,
                                        )),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      "Phone : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                    Container(
                                      width:130,
                                      child: Text(
                                        widget._teacher1['teacher-phone'],
                                        style: const TextStyle(
                                            fontSize: 13,
                                            // fontWeight: FontWeight.bold,
                                            // color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    // ElevatedButton(
                                    //     onPressed: () async {
                                    //       final Uri call = Uri(
                                    //           scheme: 'tel',
                                    //           path: widget
                                    //               ._teacher1['teacher-phone']);
                                    //       if (await canLaunchUrl(call)) {
                                    //         await launchUrl(call);
                                    //       } else {
                                    //         print("cant launch url");
                                    //       }
                                    //       ;
                                    //     },
                                    //     child: const Text("Call")),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    CircleAvatar(
                                      radius: 15,
                                        backgroundColor: Colors.black12,
                                        child: Icon(
                                          Icons.wrong_location_outlined,size: 15,
                                          color: AppColors.new_color,
                                        )),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Prefarable area : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                    Container(
                                      width: 129,
                                      child: Text(
                                        widget._teacher1['teacher-address'],
                                        style: const TextStyle(
                                          fontSize: 13,
                                          // fontWeight: FontWeight.bold,
                                          // color: Colors.black54
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: const [
                                    CircleAvatar(
                                      radius: 15,
                                        backgroundColor: Colors.black12,
                                        child: Icon(
                                          Icons.menu_book,size: 15,
                                          color: AppColors.new_color,
                                        )),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Preferable Subject : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),

                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50,bottom: 10),
                                  child: Container(
                                    width: 300,
                                    child: Text(
                                      widget._teacher1['teacher-subject'],
                                      style: const TextStyle(
                                          fontSize: 13,
                                          // fontWeight: FontWeight.bold,
                                          // color: Colors.black54
                                      ),
                                    ),
                                  ),
                                ),

                                Row(
                                  children:  [
                                    CircleAvatar(
                                      radius: 15,
                                        backgroundColor: Colors.black12,
                                        child: Icon(
                                          Icons.menu_book,size: 15,
                                          color: AppColors.new_color,
                                        )),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Preferable Class : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                    Container(
                                      width: 120,
                                      child: Text(
                                        widget._teacher1['teacher-class'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          // fontWeight: FontWeight.bold,
                                          // color: Colors.black54
                                        ),
                                      ),
                                    ),
                                  ],
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
                                                    .map((MapEntry<String, String>
                                                e) =>
                                                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                                    .join('&');
                                              }

                                              final Uri emailLaunchUri = Uri(
                                                scheme: 'mailto',
                                                path: widget
                                                    ._teacher1['teacher-email'],
                                                query: encodeQueryParameters(<
                                                    String, String>{
                                                  'subject':
                                                  'Example Subject & Symbols are allowed!',
                                                }),
                                              );
                                              if (await canLaunchUrl(
                                                  emailLaunchUri)) {
                                                launchUrl(emailLaunchUri);
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.email,
                                                  color: AppColors.new_color,
                                                ),
                                                Text(
                                                  "Email",
                                                  style: TextStyle(fontSize: 10),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final Uri call = Uri(
                                            scheme: 'tel',
                                            path:
                                            widget._teacher1['teacher-phone'],
                                          );
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
                                            Text(
                                              "call",
                                              style: TextStyle(fontSize: 10),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            final Uri call = Uri(
                                              scheme: 'sms',
                                              path: widget
                                                  ._teacher1['teacher-phone'],
                                            );
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
                                                Icons.sms,
                                                color: AppColors.new_color,
                                              ),
                                              Text(
                                                "SMS",
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          )),
                                      GestureDetector(
                                          onTap: () async {
                                            final Uri call = Uri(
                                              scheme: 'sms',
                                              path: widget
                                                  ._teacher1['teacher-phone'],
                                            );
                                            if (await canLaunchUrl(call)) {
                                              await launchUrl(call);
                                            } else {
                                              print("cant launch url");
                                            }
                                            ;
                                          },
                                          child: Column(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.squareWhatsapp,
                                                color: Colors.green,
                                              ),
                                              Text(
                                                "WhatsApp",
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )

    );
  }
}
